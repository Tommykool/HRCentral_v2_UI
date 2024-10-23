class PerformanceDTO {
  final int id;
  final String employeeId;
  final String reviewPeriod;
  final double reviewScore;
  final String feedback;
  final String reviewerName;
  final DateTime createdAt;
  final DateTime updatedAt;

  PerformanceDTO({
    required this.id,
    required this.employeeId,
    required this.reviewPeriod,
    required this.reviewScore,
    required this.feedback,
    required this.reviewerName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PerformanceDTO.fromJson(Map<String, dynamic> json) {
    return PerformanceDTO(
      id: json['id'],
      employeeId: json['employeeId'],
      reviewPeriod: json['reviewPeriod'],
      reviewScore: json['reviewScore'],
      feedback: json['feedback'],
      reviewerName: json['reviewerName'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
