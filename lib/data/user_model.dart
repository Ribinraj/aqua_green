class UserModel {
  final String userId;
  final String userMobileNumber;
  final String userFullName;

  UserModel({
    required this.userId,
    required this.userMobileNumber,
    required this.userFullName,
  });

  // Factory constructor to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      userMobileNumber: json['userMobileNumber'],
      userFullName: json['userFullName'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userMobileNumber': userMobileNumber,
      'userFullName': userFullName,
    };
  }
}
