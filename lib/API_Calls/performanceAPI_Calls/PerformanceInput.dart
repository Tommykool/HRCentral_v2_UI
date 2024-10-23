class PerformanceInput {
  final String employeeId;
  final String reviewPeriod;
  final double reviewScore;
  final String feedback;
  final String reviewerName;

  PerformanceInput({
    required this.employeeId,
    required this.reviewPeriod,
    required this.reviewScore,
    required this.feedback,
    required this.reviewerName,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'reviewPeriod': reviewPeriod,
      'reviewScore': reviewScore,
      'feedback': feedback,
      'reviewerName': reviewerName,
    };
  }
}
