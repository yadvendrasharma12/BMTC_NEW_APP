
class CenterResponseModel {
  bool status;
  String message;
  CenterData data;

  CenterResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CenterResponseModel.fromJson(Map<String, dynamic> json) {
    return CenterResponseModel(
      status: json['status'],
      message: json['message'],
      data: CenterData.fromJson(json['data']),
    );
  }
}

// ================= CENTER DATA =================

class CenterData {
  Center center;
  List<Lab> labs;

  CenterData({
    required this.center,
    required this.labs,
  });

  factory CenterData.fromJson(Map<String, dynamic> json) {
    return CenterData(
      center: Center.fromJson(json['center']),
      labs: List<Lab>.from(json['labs'].map((x) => Lab.fromJson(x))),
    );
  }
}

// ================= CENTER MODEL =================

class Center {
  String id;
  String centerName;
  String address;
  String pinCode;
  String capacity;
  String city;
  String landmark;

  Center({
    required this.id,
    required this.centerName,
    required this.address,
    required this.pinCode,
    required this.capacity,
    required this.city,
    required this.landmark,
  });

  factory Center.fromJson(Map<String, dynamic> json) {
    return Center(
      id: json['id'] ?? "",
      centerName: json['center_name'] ?? "",
      address: json['address'] ?? "",
      pinCode: json['pin_code'] ?? "",
      capacity: json['capacity'] ?? "",
      city: json['city'] ?? "",
      landmark: json['landmark'] ?? "",
    );
  }
}

// ================= LAB MODEL =================

class Lab {
  String id;
  String floorName;
  String computerCount;
  String acCount;

  Lab({
    required this.id,
    required this.floorName,
    required this.computerCount,
    required this.acCount,
  });

  factory Lab.fromJson(Map<String, dynamic> json) {
    return Lab(
      id: json['id'] ?? "",
      floorName: json['floor_name'] ?? "",
      computerCount: json['no_of_computer'] ?? "0",
      acCount: json['no_of_ac'] ?? "0",
    );
  }
}
