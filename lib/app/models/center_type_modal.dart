

class CenterTypeModel {
  final String id;
  final String centerType;

  CenterTypeModel({
    required this.id,
    required this.centerType,
  });

  factory CenterTypeModel.fromJson(Map<String, dynamic> json) {
    return CenterTypeModel(
      id: json['id']?.toString() ?? '',
      centerType: json['center_type'] ?? '',
    );
  }
}
