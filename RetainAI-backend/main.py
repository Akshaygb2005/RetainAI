from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session
import pandas as pd
import joblib

from database import get_db, init_db, PredictionRecord

init_db()
pipeline = joblib.load("log_reg_pipeline.joblib")

app = FastAPI(title="Employee Attrition Prediction API (Upsert Enabled)")

class PredictionRequest(BaseModel):
    Employee_ID: str
    Gender: str
    Age: int
    Years_at_Company: int
    Annual_Income: int
    Department: str
    Job_Role: str
    Position: str
    Employment_Type: str
    State: str
    Education_Level: str
    Marital_Status: str
    Environment_Satisfaction: str
    Employee_Cost_to_Company: int

class PredictionResponse(BaseModel):
    Employee_ID: str
    Attrition_Status: str
    confidence_percentage: float
    database_record_id: int
    action_taken: str  # Shows whether it was 'created' or 'updated'

@app.post("/predict", response_model=PredictionResponse)
def predict_attrition(payload: PredictionRequest, db: Session = Depends(get_db)):
    try:
        # 1. Feature extraction for model inference
        feature_data = {
            "Gender": payload.Gender,
            "Age": payload.Age,
            "Years_at_Company": payload.Years_at_Company,
            "Annual_Income": payload.Annual_Income,
            "Department": payload.Department,
            "Job_Role": payload.Job_Role,
            "Position": payload.Position,
            "Employment_Type": payload.Employment_Type,
            "State": payload.State,
            "Education_Level": payload.Education_Level,
            "Marital_Status": payload.Marital_Status,
            "Environment_Satisfaction": payload.Environment_Satisfaction,
            "Employee_Cost_to_Company": payload.Employee_Cost_to_Company
        }
        input_df = pd.DataFrame([feature_data])

        # 2. Run inference
        pred_code = pipeline.predict(input_df)[0]
        attrition_result = "Yes" if pred_code == 1 else "No"
        confidence_val = round(float(pipeline.predict_proba(input_df)[0].max()) * 100, 2)

        # 3. Check if employee already exists in MySQL
        #db.query(PredictionRecord): Initiates a SQLAlchemy SELECT query targeting the prediction_records table.
        #.filter(PredictionRecord.employee_id == payload.employee_id): Translates to SQL WHERE employee_id = '...'. It looks specifically for a row matching the ID passed in the current API request.
        #.first(): Executes the query and returns the first matching record as a Python object. If no record exists with that ID, it returns None.
        existing_record = (
            db.query(PredictionRecord)
            .filter(PredictionRecord.Employee_ID == payload.Employee_ID)
            .first()
        )

        if existing_record:
            # UPDATE existing row with latest features & predictions
            for key, value in feature_data.items():
                setattr(existing_record, key, value)
            
            existing_record.Attrition_Status = attrition_result
            existing_record.confidence = confidence_val
            
            db.commit()
            db.refresh(existing_record)
            record_to_return = existing_record
            action = "updated"

        else:
            # INSERT new row
            new_record = PredictionRecord(
                Employee_ID=payload.Employee_ID,
                Attrition_Status=attrition_result,
                confidence=confidence_val,
                **feature_data
            )
            db.add(new_record)
            db.commit()
            db.refresh(new_record)
            record_to_return = new_record
            action = "created"

        return PredictionResponse(
            Employee_ID=record_to_return.Employee_ID,
            Attrition_Status=record_to_return.Attrition_Status,
            confidence_percentage=record_to_return.confidence,
            database_record_id=record_to_return.id,
            action_taken=action
        )

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


# To run -> python -m uvicorn main:app --reload --host [IP_ADDRESS] --port 8000
# To test -> http://localhost:8000/docs