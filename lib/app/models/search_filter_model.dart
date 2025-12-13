


import 'dart:convert';

SearcFilterModel searcFilterModelFromJson(String str) => SearcFilterModel.fromJson(json.decode(str));

String searcFilterModelToJson(SearcFilterModel data) => json.encode(data.toJson());

class SearcFilterModel {
  bool status;
  String message;
  Data data;

  SearcFilterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearcFilterModel.fromJson(Map<String, dynamic> json) => SearcFilterModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<Country> countries;
  List<CenterType> centerType;
  Map<String, String?> centerDetails;
  List<Map<String, String?>> labs;
  List<dynamic> documents;
  List<Image> images;
  List<dynamic> totalBookingRequest;
  int totalBookingReqCount;
  int numberOfSeats;
  List<dynamic> totalInReviewBooking;
  List<dynamic> totalConfirmBooking;
  List<Map<String, String?>> selfBookingData;
  int totalSelfBookingReqCount;
  String calendarMonth;
  String calendarYear;
  List<ExamDate> examDates;

  Data({
    required this.countries,
    required this.centerType,
    required this.centerDetails,
    required this.labs,
    required this.documents,
    required this.images,
    required this.totalBookingRequest,
    required this.totalBookingReqCount,
    required this.numberOfSeats,
    required this.totalInReviewBooking,
    required this.totalConfirmBooking,
    required this.selfBookingData,
    required this.totalSelfBookingReqCount,
    required this.calendarMonth,
    required this.calendarYear,
    required this.examDates,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
    centerType: List<CenterType>.from(json["center_type"].map((x) => CenterType.fromJson(x))),
    centerDetails: Map.from(json["center_details"]).map((k, v) => MapEntry<String, String?>(k, v)),
    labs: List<Map<String, String?>>.from(json["labs"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    documents: List<dynamic>.from(json["documents"].map((x) => x)),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    totalBookingRequest: List<dynamic>.from(json["totalBookingRequest"].map((x) => x)),
    totalBookingReqCount: json["total_booking_req_count"],
    numberOfSeats: json["number_of_seats"],
    totalInReviewBooking: List<dynamic>.from(json["totalInReviewBooking"].map((x) => x)),
    totalConfirmBooking: List<dynamic>.from(json["totalConfirmBooking"].map((x) => x)),
    selfBookingData: List<Map<String, String?>>.from(json["selfBookingData"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    totalSelfBookingReqCount: json["total_self_booking_req_count"],
    calendarMonth: json["calendar_month"],
    calendarYear: json["calendar_year"],
    examDates: List<ExamDate>.from(json["exam_dates"].map((x) => ExamDate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
    "center_type": List<dynamic>.from(centerType.map((x) => x.toJson())),
    "center_details": Map.from(centerDetails).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "labs": List<dynamic>.from(labs.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "documents": List<dynamic>.from(documents.map((x) => x)),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "totalBookingRequest": List<dynamic>.from(totalBookingRequest.map((x) => x)),
    "total_booking_req_count": totalBookingReqCount,
    "number_of_seats": numberOfSeats,
    "totalInReviewBooking": List<dynamic>.from(totalInReviewBooking.map((x) => x)),
    "totalConfirmBooking": List<dynamic>.from(totalConfirmBooking.map((x) => x)),
    "selfBookingData": List<dynamic>.from(selfBookingData.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "total_self_booking_req_count": totalSelfBookingReqCount,
    "calendar_month": calendarMonth,
    "calendar_year": calendarYear,
    "exam_dates": List<dynamic>.from(examDates.map((x) => x.toJson())),
  };
}

class CenterType {
  String id;
  String centerType;
  Doe doe;
  String deleted;

  CenterType({
    required this.id,
    required this.centerType,
    required this.doe,
    required this.deleted,
  });

  factory CenterType.fromJson(Map<String, dynamic> json) => CenterType(
    id: json["id"],
    centerType: json["center_type"],
    doe: doeValues.map[json["doe"]]!,
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "center_type": centerType,
    "doe": doeValues.reverse[doe],
    "deleted": deleted,
  };
}

enum Doe {
  THE_00000000000000
}

final doeValues = EnumValues({
  "0000-00-00 00:00:00": Doe.THE_00000000000000
});

class Country {
  String id;
  String name;
  String createdBy;
  DateTime createDate;
  dynamic modiDate;
  String isActive;
  String deleted;
  dynamic x;

  Country({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createDate,
    required this.modiDate,
    required this.isActive,
    required this.deleted,
    required this.x,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    createdBy: json["created_by"],
    createDate: DateTime.parse(json["create_date"]),
    modiDate: json["modi_date"],
    isActive: json["is_active"],
    deleted: json["deleted"],
    x: json["x"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_by": createdBy,
    "create_date": createDate.toIso8601String(),
    "modi_date": modiDate,
    "is_active": isActive,
    "deleted": deleted,
    "x": x,
  };
}

class ExamDate {
  DateTime startDate;
  DateTime endDate;
  String examName;
  String type;

  ExamDate({
    required this.startDate,
    required this.endDate,
    required this.examName,
    required this.type,
  });

  factory ExamDate.fromJson(Map<String, dynamic> json) => ExamDate(
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    examName: json["exam_name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "exam_name": examName,
    "type": type,
  };
}

class Image {
  String id;
  String centerId;
  ImageType imageType;
  String centerImage;
  DateTime doe;
  String addedBy;
  String deleted;

  Image({
    required this.id,
    required this.centerId,
    required this.imageType,
    required this.centerImage,
    required this.doe,
    required this.addedBy,
    required this.deleted,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    centerId: json["center_id"],
    imageType: imageTypeValues.map[json["image_type"]]!,
    centerImage: json["center_image"],
    doe: DateTime.parse(json["doe"]),
    addedBy: json["added_by"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "center_id": centerId,
    "image_type": imageTypeValues.reverse[imageType],
    "center_image": centerImage,
    "doe": doe.toIso8601String(),
    "added_by": addedBy,
    "deleted": deleted,
  };
}

enum ImageType {
  GATE_IMAGE,
  LAB_PHOTO,
  OBSERVER_IMAGE,
  SERVER_IMAGE,
  UPS_IMAGE
}

final imageTypeValues = EnumValues({
  "gate_image": ImageType.GATE_IMAGE,
  "lab_photo": ImageType.LAB_PHOTO,
  "observer_image": ImageType.OBSERVER_IMAGE,
  "server_image": ImageType.SERVER_IMAGE,
  "ups_image": ImageType.UPS_IMAGE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
