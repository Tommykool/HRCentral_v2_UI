class EmployeeDTO {

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String department;
  final String jobTitle;
  final String phone;
  final String address;

  EmployeeDTO({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.department,
    required this.jobTitle,
    required this.phone,
    required this.address,
  });

  factory EmployeeDTO.fromJson(Map<String, dynamic> json) {
    return EmployeeDTO(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      department: json['department'],
      jobTitle: json['jobTitle'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
