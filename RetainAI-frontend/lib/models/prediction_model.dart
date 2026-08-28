class EmployeePredictionRequest {
  final String employeeId;
  final String gender;
  final int age;
  final int yearsAtCompany;
  final int annualIncome;
  final String department;
  final String jobRole;
  final String position;
  final String employmentType;
  final String state;
  final String educationLevel;
  final String maritalStatus;
  final String environmentSatisfaction;
  final int employeeCostToCompany;

  EmployeePredictionRequest({
    required this.employeeId,
    required this.gender,
    required this.age,
    required this.yearsAtCompany,
    required this.annualIncome,
    required this.department,
    required this.jobRole,
    required this.position,
    required this.employmentType,
    required this.state,
    required this.educationLevel,
    required this.maritalStatus,
    required this.environmentSatisfaction,
    required this.employeeCostToCompany,
  });

  Map<String, dynamic> toJson() {
    return {
      "Employee_Id": employeeId,
      "Gender": gender,
      "Age": age,
      "Years_at_Company": yearsAtCompany,
      "Annual_Income": annualIncome,
      "Department": department,
      "Job_Role": jobRole,
      "Position": position,
      "Employment_Type": employmentType,
      "State": state,
      "Education_Level": educationLevel,
      "Marital_Status": maritalStatus,
      "Environment_Satisfaction": environmentSatisfaction,
      "Employee_Cost_to_Company": employeeCostToCompany,
    };
  }
}

class EmployeePredictionResponse {
  final String employeeId;
  final String attritionStatus; // "Yes" or "No"
  final double confidencePercentage;
  final int? databaseRecordId;
  final String? actionTaken;
  final bool isSimulated;
  final String? errorMessage;

  EmployeePredictionResponse({
    required this.employeeId,
    required this.attritionStatus,
    required this.confidencePercentage,
    this.databaseRecordId,
    this.actionTaken,
    this.isSimulated = false,
    this.errorMessage,
  });

  bool get willChurn =>
      attritionStatus.toLowerCase() == 'yes' ||
      attritionStatus.toLowerCase() == 'true';

  factory EmployeePredictionResponse.fromJson(Map<String, dynamic> json) {
    // Handle both field name variations safely
    final empId = json['employee_id'] ?? json['Employee_Id'] ?? 'EMP-UNKNOWN';
    final status = json['Attrition_Status'] ?? json['attrition_status'] ?? 'No';
    
    double conf = 85.0;
    if (json['confidence_percentage'] != null) {
      if (json['confidence_percentage'] is num) {
        conf = (json['confidence_percentage'] as num).toDouble();
      } else if (json['confidence_percentage'] is String) {
        conf = double.tryParse(json['confidence_percentage']) ?? 85.0;
      }
    }

    final dbId = json['database_record_id'] != null
        ? (json['database_record_id'] as num?)?.toInt()
        : null;

    final action = json['action_taken'] as String?;

    return EmployeePredictionResponse(
      employeeId: empId.toString(),
      attritionStatus: status.toString(),
      confidencePercentage: conf,
      databaseRecordId: dbId,
      actionTaken: action,
      isSimulated: false,
    );
  }

  factory EmployeePredictionResponse.fromSimulation(
    EmployeePredictionRequest req,
  ) {
    // Mathematical propensity simulation matching the logic
    double points = 35.0;

    switch (req.environmentSatisfaction) {
      case 'Low':
        points += 34;
        break;
      case 'Medium':
        points += 12;
        break;
      case 'High':
        points -= 14;
        break;
      case 'Very High':
        points -= 25;
        break;
    }

    if (req.yearsAtCompany <= 1) {
      points += 18;
    } else if (req.yearsAtCompany <= 3) {
      points += 8;
    } else if (req.yearsAtCompany <= 7) {
      points -= 10;
    } else {
      points -= 18;
    }

    final ctcRatio = req.employeeCostToCompany > 0
        ? (req.annualIncome / req.employeeCostToCompany)
        : 0.8;
    if (req.annualIncome < 55000) points += 16;
    if (req.annualIncome > 140000) points -= 15;
    if (ctcRatio < 0.72) points += 10;

    if (req.age < 26) {
      points += 12;
    } else if (req.age > 45) {
      points -= 14;
    }

    if (req.employmentType.toLowerCase().contains('contract')) points += 20;
    if (req.position.toLowerCase().contains('entry')) points += 8;
    if (req.position.toLowerCase().contains('exec')) points -= 12;

    if (req.maritalStatus == 'Single') points += 6;
    if (req.maritalStatus == 'Married') points -= 6;

    final finalScore = points.clamp(5.0, 95.0);
    final willChurn = finalScore >= 50;

    final conf = willChurn
        ? (58 + ((finalScore - 50) * 0.85))
        : (58 + ((50 - finalScore) * 0.85));

    return EmployeePredictionResponse(
      employeeId: req.employeeId,
      attritionStatus: willChurn ? "Yes" : "No",
      confidencePercentage: double.parse(conf.toStringAsFixed(2)),
      databaseRecordId: 1,
      actionTaken: "simulated_local",
      isSimulated: true,
    );
  }
}
