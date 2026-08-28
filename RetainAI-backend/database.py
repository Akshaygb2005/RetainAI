from datetime import datetime
from sqlalchemy import create_engine, Column, Integer, Float, String, DateTime
from sqlalchemy.orm import declarative_base, sessionmaker

DATABASE_URL = "mysql+pymysql://root:sqlgb@localhost:3306/employee_churn"

engine = create_engine(DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

class PredictionRecord(Base):
    __tablename__ = "prediction_records"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    
    # Unique constraint ensures no duplicate employee rows
    Employee_ID = Column(String(50), unique=True, nullable=False, index=True)
    
    # 13 Feature columns
    Gender = Column(String(20), nullable=False)
    Age = Column(Integer, nullable=False)
    Years_at_Company = Column(Integer, nullable=False)
    Annual_Income = Column(Integer, nullable=False)
    Department = Column(String(100), nullable=False)
    Job_Role = Column(String(100), nullable=False)
    Position = Column(String(100), nullable=False)
    Employment_Type = Column(String(50), nullable=False)
    State = Column(String(50), nullable=False)
    Education_Level = Column(String(50), nullable=False)
    Marital_Status = Column(String(50), nullable=False)
    Environment_Satisfaction = Column(String(50), nullable=False)
    Employee_Cost_to_Company = Column(Integer, nullable=False)
    
    # Model inference logs
    Attrition_Status = Column(String(10), nullable=False)
    confidence = Column(Float, nullable=False)
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def init_db():
    Base.metadata.create_all(bind=engine)