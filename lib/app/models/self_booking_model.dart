import 'dart:convert';

SelfBookingModel selfBookingModelFromJson(String str) =>
    SelfBookingModel.fromJson(json.decode(str));

class SelfBookingModel {
  bool status;
  String message;
  BookingData data;

  SelfBookingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SelfBookingModel.fromJson(Map<String, dynamic> json) =>
      SelfBookingModel(
        status: json["status"],
        message: json["message"],
        data: BookingData.fromJson(json["data"]),
      );
}

class BookingData {
  List<dynamic> labs;
  List<dynamic> selfBookingData;
  int totalSelfBookingReqCount;

  BookingData({
    required this.labs,
    required this.selfBookingData,
    required this.totalSelfBookingReqCount,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    labs: json["labs"] ?? [],
    selfBookingData: json["selfBookingData"] ?? [],
    totalSelfBookingReqCount: json["total_self_booking_req_count"] ?? 0,
  );
}
