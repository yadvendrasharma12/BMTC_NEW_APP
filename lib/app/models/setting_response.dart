
class SettingsResponse {
  final bool status;
  final String message;
  final SettingsData data;

  SettingsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SettingsResponse.fromJson(Map<String, dynamic> json) {
    return SettingsResponse(
      status: json['status'],
      message: json['message'],
      data: SettingsData.fromJson(json['data']),
    );
  }
}

class SettingsData {
  final User user;
  final Center center;

  SettingsData({
    required this.user,
    required this.center,
  });

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
      user: User.fromJson(json['user']),
      center: Center.fromJson(json['center']),
    );
  }
}

class User {
  final String id;
  final String username;
  final String email;
  final String mobile;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.mobile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile_phone'] ?? '',
    );
  }
}

class Center {
  final String centerName;
  final String address;

  Center({
    required this.centerName,
    required this.address,
  });

  factory Center.fromJson(Map<String, dynamic> json) {
    return Center(
      centerName: json['center_name'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
