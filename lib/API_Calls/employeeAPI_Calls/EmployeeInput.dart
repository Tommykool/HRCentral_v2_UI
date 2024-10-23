class EmployeeInput {
  final String firstName;
  final String lastName;
  final String email;
  final String department;
  final String jobTitle;
  final String phone;
  final String address;

  EmployeeInput({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.department,
    required this.jobTitle,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'department': department,
      'jobTitle': jobTitle,
      'phone': phone,
      'address': address,
    };
  }
}
