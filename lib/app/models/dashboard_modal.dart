class DashboardModel {
  bool? status;
  String? message;
  DashboardData? data;

  DashboardModel({this.status, this.message, this.data});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? DashboardData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

// ================= Dashboard Data =================

class DashboardData {
  List<Country>? countries;
  List<CenterType>? centerType;
  CenterDetails? centerDetails;
  List<Lab>? labs;
  List<DocumentModel>? documents;
  List<CenterImage>? images;
  List<TotalBookingRequest>? totalBookingRequest;
  int? totalBookingReqCount;
  int? numberOfSeats;
  List<TotalInReviewBooking>? totalInReviewBooking;
  List<TotalBookingRequest>? totalConfirmBooking;
  List<SelfBookingData>? selfBookingData;
  int? totalSelfBookingReqCount;
  String? calendarMonth;
  String? calendarYear;
  List<ExamDate>? examDates;

  DashboardData({
    this.countries,
    this.centerType,
    this.centerDetails,
    this.labs,
    this.documents,
    this.images,
    this.totalBookingRequest,
    this.totalBookingReqCount,
    this.numberOfSeats,
    this.totalInReviewBooking,
    this.totalConfirmBooking,
    this.selfBookingData,
    this.totalSelfBookingReqCount,
    this.calendarMonth,
    this.calendarYear,
    this.examDates,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    countries: json["countries"] == null
        ? []
        : List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
    centerType: json["center_type"] == null
        ? []
        : List<CenterType>.from(json["center_type"].map((x) => CenterType.fromJson(x))),
    centerDetails: json["center_details"] == null
        ? null
        : CenterDetails.fromJson(json["center_details"]),
    labs: json["labs"] == null
        ? []
        : List<Lab>.from(json["labs"].map((x) => Lab.fromJson(x))),
    documents: json["documents"] == null
        ? []
        : List<DocumentModel>.from(json["documents"].map((x) => DocumentModel.fromJson(x))),
    images: json["images"] == null
        ? []
        : List<CenterImage>.from(json["images"].map((x) => CenterImage.fromJson(x))),
    totalBookingRequest: json["totalBookingRequest"] == null
        ? []
        : List<TotalBookingRequest>.from(
        json["totalBookingRequest"]
            .map((x) => TotalBookingRequest.fromJson(x))),
    totalBookingReqCount: json["total_booking_req_count"] ?? 0,
    numberOfSeats: json["number_of_seats"] ?? 0,
    totalInReviewBooking: json["totalInReviewBooking"] == null
        ? []
        : List<TotalInReviewBooking>.from(
        json["totalInReviewBooking"].map((x) => TotalInReviewBooking.fromJson(x))),
    totalConfirmBooking: json["totalConfirmBooking"] == null
        ? []
        : List<TotalBookingRequest>.from(
      json["totalConfirmBooking"].map((x) => TotalBookingRequest.fromJson(x)),
    ),
    selfBookingData: json["selfBookingData"] == null
        ? []
        : List<SelfBookingData>.from(json["selfBookingData"].map((x) => SelfBookingData.fromJson(x))),
    totalSelfBookingReqCount: json["total_self_booking_req_count"] ?? 0,
    calendarMonth: json["calendar_month"],
    calendarYear: json["calendar_year"],
    examDates: json["exam_dates"] == null
        ? []
        : List<ExamDate>.from(json["exam_dates"].map((x) => ExamDate.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    "countries": countries?.map((x) => x.toJson()).toList(),
    "center_type": centerType?.map((x) => x.toJson()).toList(),
    "center_details": centerDetails?.toJson(),
    "labs": labs?.map((x) => x.toJson()).toList(),
    "documents": documents?.map((x) => x.toJson()).toList(),
    "images": images?.map((x) => x.toJson()).toList(),
    "totalBookingRequest": totalBookingRequest,
    "total_booking_req_count": totalBookingReqCount,
    "number_of_seats": numberOfSeats,
    "totalInReviewBooking":
    totalInReviewBooking?.map((x) => x.toJson()).toList(),
    "totalConfirmBooking": totalConfirmBooking,
    "selfBookingData":
    selfBookingData?.map((x) => x.toJson()).toList(),
    "total_self_booking_req_count": totalSelfBookingReqCount,
    "calendar_month": calendarMonth,
    "calendar_year": calendarYear,
    "exam_dates": examDates?.map((x) => x.toJson()).toList(),
  };
}

// ================= Country =================

class Country {
  String? id;
  String? name;

  Country({this.id, this.name});

  factory Country.fromJson(Map<String, dynamic> json) =>
      Country(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

// ================= Center Type =================

class CenterType {
  String? id;
  String? centerType;

  CenterType({this.id, this.centerType});

  factory CenterType.fromJson(Map<String, dynamic> json) =>
      CenterType(id: json["id"], centerType: json["center_type"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "center_type": centerType};
}

// ================= Center Details =================

class CenterDetails {
  String? id;
  String? centerName;
  String? nearestRailwayStation;
  String? nearestMetroStation;
  String? nearestAirport;

  CenterDetails({
    this.id,
    this.centerName,
    this.nearestRailwayStation,
    this.nearestMetroStation,
    this.nearestAirport,
  });

  factory CenterDetails.fromJson(Map<String, dynamic> json) =>
      CenterDetails(
        id: json["id"],
        centerName: json["center_name"],
        nearestRailwayStation: json["nearest_railway_station"],
        nearestMetroStation: json["nearest_metro_station"],
        nearestAirport: json["nearest_airport"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "center_name": centerName,
    "nearest_railway_station": nearestRailwayStation,
    "nearest_metro_station": nearestMetroStation,
    "nearest_airport": nearestAirport,
  };
}

// ================= Labs =================

class Lab {
  String? id;
  String? floorName;
  String? noOfComputer;

  Lab({this.id, this.floorName, this.noOfComputer});

  factory Lab.fromJson(Map<String, dynamic> json) => Lab(
    id: json["id"],
    floorName: json["floor_name"],
    noOfComputer: json["no_of_computer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "floor_name": floorName,
    "no_of_computer": noOfComputer,
  };
}

// ================= Documents =================

class DocumentModel {
  String? id;
  String? docName;
  String? url;

  DocumentModel({this.id, this.docName, this.url});

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      DocumentModel(
        id: json["id"],
        docName: json["doc_name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "doc_name": docName, "url": url};
}

// ================= Images =================

class CenterImage {
  String? id;
  String? imageType;
  String? centerImage;

  CenterImage({this.id, this.imageType, this.centerImage});

  factory CenterImage.fromJson(Map<String, dynamic> json) =>
      CenterImage(
        id: json["id"],
        imageType: json["image_type"],
        centerImage: json["center_image"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_type": imageType,
    "center_image": centerImage,
  };
}



class TotalConfirmBooking {
  String? id;
  String? projectId;
  String? clientId;
  String? clientName;
  String? examName;
  String? startDate;
  String? endDate;
  String? examType;
  String? examTypeDetail;
  String? examMode;

  String? inetModeOs;
  String? inetModeRam;
  String? inetModeProcessor;
  String? inetModeDisplay;
  String? inetModeInternetEach;

  String? totalBatch;
  String? batch1;
  String? batch2;
  String? batch3;
  String? batch4;
  String? batch5;

  String? parkingFacility;
  String? securityGuard;
  String? lockerFacility;
  String? waitingArea;

  String? numberOfSeats;
  String? pricePerSeat;
  String? examCityName;
  String? duration;


  TotalConfirmBooking({
    this.id,
    this.projectId,
    this.clientId,
    this.clientName,
    this.examName,
    this.startDate,
    this.endDate,
    this.examType,
    this.examTypeDetail,
    this.examMode,
    this.inetModeOs,
    this.inetModeRam,
    this.inetModeProcessor,
    this.inetModeDisplay,
    this.inetModeInternetEach,
    this.totalBatch,
    this.batch1,
    this.batch2,
    this.batch3,
    this.batch4,
    this.batch5,
    this.parkingFacility,
    this.securityGuard,
    this.lockerFacility,
    this.waitingArea,
    this.numberOfSeats,
    this.pricePerSeat,
    this.examCityName,
    this.duration,
  });

  factory TotalConfirmBooking.fromJson(Map<String, dynamic> json) =>
      TotalConfirmBooking(
        id: json["id"]?.toString(),
        projectId: json["project_id"]?.toString(),
        clientId: json["client_id"]?.toString(),
        clientName: json["client_name"],
        examName: json["exam_name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        examType: json["exam_type"],
        examTypeDetail: json["exam_type_detail"],
        examMode: json["exam_mode"],
        duration: json["exam_duration"],

        inetModeOs: json["inet_mode_os"],
        inetModeRam: json["inet_mode_ram"]?.toString(),
        inetModeProcessor: json["inet_mode_processor"],
        inetModeDisplay: json["inet_mode_display"],
        inetModeInternetEach: json["inet_mode_internet_each"]?.toString(),

        totalBatch: json["total_batch"]?.toString(),
        batch1: json["batch1"],
        batch2: json["batch2"],
        batch3: json["batch3"],
        batch4: json["batch4"],
        batch5: json["batch5"],

        parkingFacility: json["parking_facility"]?.toString(),
        securityGuard: json["security_guard"],
        lockerFacility: json["locker_facility"]?.toString(),
        waitingArea: json["waiting_area"]?.toString(),

        numberOfSeats: json["number_of_seats"]?.toString(),
        pricePerSeat: json["price_per_seat"]?.toString(),
        examCityName: json["exam_city_name"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_id": projectId,
    "client_id": clientId,
    "client_name": clientName,
    "exam_name": examName,
    "start_date": startDate,
    "end_date": endDate,
    "exam_type": examType,
    "exam_type_detail": examTypeDetail,
    "exam_mode": examMode,

    "inet_mode_os": inetModeOs,
    "inet_mode_ram": inetModeRam,
    "inet_mode_processor": inetModeProcessor,
    "inet_mode_display": inetModeDisplay,
    "inet_mode_internet_each": inetModeInternetEach,

    "total_batch": totalBatch,
    "batch1": batch1,
    "batch2": batch2,
    "batch3": batch3,
    "batch4": batch4,
    "batch5": batch5,

    "parking_facility": parkingFacility,
    "security_guard": securityGuard,
    "locker_facility": lockerFacility,
    "waiting_area": waitingArea,

    "number_of_seats": numberOfSeats,
    "price_per_seat": pricePerSeat,
    "exam_city_name": examCityName,
  };
}


class TotalBookingRequest {
  String? id;
  String? projectId;
  String? clientId;
  String? clientName;
  String? examName;
  String? startDate;
  String? endDate;
  String? examType;
  String? examTypeDetail;
  String? examMode;

  String? inetModeOs;
  String? inetModeRam;
  String? inetModeProcessor;
  String? inetModeDisplay;
  String? inetModeInternetEach;

  String? serverModeOs;
  String? serverModeRam;
  String? serverModeProcessor;
  String? serverModeRatio;
  String? serverModeInternet;

  String? totalBatch;
  String? batch1;
  String? batch2;
  String? batch3;
  String? batch4;
  String? batch5;

  String? parkingFacility;
  String? securityGuard;
  String? lockerFacility;
  String? waitingArea;
  String? powerBackup;
  String? phHandicaped;
  String? printer;
  String? roughSheet;
  String? partitionInLab;
  String? acInLab;
  String? cctvRequired;
  String? cctvRecording;

  String? centerSuptnRatio;
  String? techPersonRatio;
  String? invigilatorRatio;
  String? securityGuardRatio;

  String? techPersonMale;
  String? invigilatorMale;
  String? invigilatorFemale;
  String? securityGuardMale;
  String? securityGuardFemale;
  String? techPersonFemale;
  String? centerSuptnMale;
  String? centerSuptnFemale;

  String? stateId;
  String? examCityId;
  String? examCityName;

  String? examRequiredSeat;
  String? examReqDays;

  String? createdBy;
  String? createdOn;
  String? lastModifiedBy;
  String? lastModifiedOn;

  String? bookFlag;
  String? numberOfSeats;
  String? pricePerSeat;
  String? status;
  String? valid;
  String? deleted;
  String? requestStatus;
  String? clientStatus;
  String? examCenterStatus;

  TotalBookingRequest({
    this.id,
    this.projectId,
    this.clientId,
    this.clientName,
    this.examName,
    this.startDate,
    this.endDate,
    this.examType,
    this.examTypeDetail,
    this.examMode,
    this.inetModeOs,
    this.inetModeRam,
    this.inetModeProcessor,
    this.inetModeDisplay,
    this.inetModeInternetEach,
    this.serverModeOs,
    this.serverModeRam,
    this.serverModeProcessor,
    this.serverModeRatio,
    this.serverModeInternet,
    this.totalBatch,
    this.batch1,
    this.batch2,
    this.batch3,
    this.batch4,
    this.batch5,
    this.parkingFacility,
    this.securityGuard,
    this.lockerFacility,
    this.waitingArea,
    this.powerBackup,
    this.phHandicaped,
    this.printer,
    this.roughSheet,
    this.partitionInLab,
    this.acInLab,
    this.cctvRequired,
    this.cctvRecording,
    this.centerSuptnRatio,
    this.techPersonRatio,
    this.invigilatorRatio,
    this.securityGuardRatio,
    this.techPersonMale,
    this.invigilatorMale,
    this.invigilatorFemale,
    this.securityGuardMale,
    this.securityGuardFemale,
    this.techPersonFemale,
    this.centerSuptnMale,
    this.centerSuptnFemale,
    this.stateId,
    this.examCityId,
    this.examCityName,
    this.examRequiredSeat,
    this.examReqDays,
    this.createdBy,
    this.createdOn,
    this.lastModifiedBy,
    this.lastModifiedOn,
    this.bookFlag,
    this.numberOfSeats,
    this.pricePerSeat,
    this.status,
    this.valid,
    this.deleted,
    this.requestStatus,
    this.clientStatus,
    this.examCenterStatus,
  });

  factory TotalBookingRequest.fromJson(Map<String, dynamic> json) =>
      TotalBookingRequest(
        id: json["id"]?.toString(),
        projectId: json["project_id"]?.toString(),
        clientId: json["client_id"]?.toString(),
        clientName: json["client_name"],
        examName: json["exam_name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        examType: json["exam_type"],
        examTypeDetail: json["exam_type_detail"],
        examMode: json["exam_mode"],

        // Internet Mode
        inetModeOs: json["inet_mode_os"],
        inetModeRam: json["inet_mode_ram"]?.toString(),
        inetModeProcessor: json["inet_mode_processor"],
        inetModeDisplay: json["inet_mode_display"],
        inetModeInternetEach: json["inet_mode_internet_each"]?.toString(),

        // Server Mode
        serverModeOs: json["server_mode_os"],
        serverModeRam: json["server_mode_ram"]?.toString(),
        serverModeProcessor: json["server_mode_processor"],
        serverModeRatio: json["server_mode_ratio"],
        serverModeInternet: json["server_mode_internet"],

        totalBatch: json["total_batch"]?.toString(),
        batch1: json["batch1"],
        batch2: json["batch2"],
        batch3: json["batch3"],
        batch4: json["batch4"],
        batch5: json["batch5"],

        parkingFacility: json["parking_facility"]?.toString(),
        securityGuard: json["security_guard"],
        lockerFacility: json["locker_facility"]?.toString(),
        waitingArea: json["waiting_area"]?.toString(),
        powerBackup: json["power_backup"]?.toString(),
        phHandicaped: json["ph_handicaped"]?.toString(),
        printer: json["printer"]?.toString(),
        roughSheet: json["rough_sheet"]?.toString(),
        partitionInLab: json["partition_in_lab"]?.toString(),
        acInLab: json["ac_in_lab"]?.toString(),
        cctvRequired: json["cctv_required"]?.toString(),
        cctvRecording: json["cctv_recording"]?.toString(),

        centerSuptnRatio: json["center_suptn_ratio"],
        techPersonRatio: json["tech_person_ratio"],
        invigilatorRatio: json["invigilator_ratio"],
        securityGuardRatio: json["security_guard_ratio"],

        techPersonMale: json["tech_person_male"]?.toString(),
        invigilatorMale: json["invigilator_male"]?.toString(),
        invigilatorFemale: json["invigilator_female"]?.toString(),
        securityGuardMale: json["security_guard_male"]?.toString(),
        securityGuardFemale: json["security_guard_female"]?.toString(),
        techPersonFemale: json["tech_person_female"]?.toString(),
        centerSuptnMale: json["center_suptn_male"]?.toString(),
        centerSuptnFemale: json["center_suptn_female"]?.toString(),

        stateId: json["state_id"]?.toString(),
        examCityId: json["exam_city_id"]?.toString(),
        examCityName: json["exam_city_name"],

        examRequiredSeat: json["exam_required_seat"]?.toString(),
        examReqDays: json["exam_req_days"]?.toString(),

        createdBy: json["created_by"]?.toString(),
        createdOn: json["created_on"],
        lastModifiedBy: json["last_modified_by"]?.toString(),
        lastModifiedOn: json["last_modified_on"],

        bookFlag: json["book_flag"]?.toString(),

        /// 🔥 THESE 2 FIX YOUR ISSUE (MOST IMPORTANT)
        numberOfSeats: json["number_of_seats"]?.toString(),
        pricePerSeat: json["price_per_seat"]?.toString(),

        status: json["status"]?.toString(),
        valid: json["valid"]?.toString(),
        deleted: json["deleted"]?.toString(),
        requestStatus: json["request_status"]?.toString(),
        clientStatus: json["client_status"]?.toString(),
        examCenterStatus: json["exam_center_status"]?.toString(),
      );


  Map<String, dynamic> toJson() => {
    "id": id,
    "project_id": projectId,
    "client_id": clientId,
    "client_name": clientName,
    "exam_name": examName,
    "start_date": startDate,
    "end_date": endDate,
    "exam_type": examType,
    "exam_type_detail": examTypeDetail,
    "exam_mode": examMode,

    "inet_mode_os": inetModeOs,
    "inet_mode_ram": inetModeRam,
    "inet_mode_processor": inetModeProcessor,
    "inet_mode_display": inetModeDisplay,
    "inet_mode_internet_each": inetModeInternetEach,

    "server_mode_os": serverModeOs,
    "server_mode_ram": serverModeRam,
    "server_mode_processor": serverModeProcessor,
    "server_mode_ratio": serverModeRatio,
    "server_mode_internet": serverModeInternet,

    "total_batch": totalBatch,
    "batch1": batch1,
    "batch2": batch2,
    "batch3": batch3,
    "batch4": batch4,
    "batch5": batch5,

    "parking_facility": parkingFacility,
    "security_guard": securityGuard,
    "locker_facility": lockerFacility,
    "waiting_area": waitingArea,
    "power_backup": powerBackup,
    "ph_handicaped": phHandicaped,
    "printer": printer,
    "rough_sheet": roughSheet,
    "partition_in_lab": partitionInLab,
    "ac_in_lab": acInLab,
    "cctv_required": cctvRequired,
    "cctv_recording": cctvRecording,

    "center_suptn_ratio": centerSuptnRatio,
    "tech_person_ratio": techPersonRatio,
    "invigilator_ratio": invigilatorRatio,
    "security_guard_ratio": securityGuardRatio,

    "tech_person_male": techPersonMale,
    "invigilator_male": invigilatorMale,
    "invigilator_female": invigilatorFemale,
    "security_guard_male": securityGuardMale,
    "security_guard_female": securityGuardFemale,
    "tech_person_female": techPersonFemale,
    "center_suptn_male": centerSuptnMale,
    "center_suptn_female": centerSuptnFemale,

    "state_id": stateId,
    "exam_city_id": examCityId,
    "exam_city_name": examCityName,

    "exam_required_seat": examRequiredSeat,
    "exam_req_days": examReqDays,

    "created_by": createdBy,
    "created_on": createdOn,
    "last_modified_by": lastModifiedBy,
    "last_modified_on": lastModifiedOn,

    "book_flag": bookFlag,
    "number_of_seats": numberOfSeats,
    "price_per_seat": pricePerSeat,
    "status": status,
    "valid": valid,
    "deleted": deleted,
    "request_status": requestStatus,
    "client_status": clientStatus,
    "exam_center_status": examCenterStatus,
  };
}



class TotalInReviewBooking {
  String? id;
  String? projectId;     // <-- ADD THIS
  String? clientName;
  String? examName;
  String? startDate;
  String? endDate;
  String? examCityName;
  String? numberOfSeats;
  String? pricePerSeat;
  String? examCenterStatus;

  TotalInReviewBooking({
    this.id,
    this.projectId,      // <-- ADD THIS
    this.clientName,
    this.examName,
    this.startDate,
    this.endDate,
    this.examCityName,
    this.numberOfSeats,
    this.pricePerSeat,
    this.examCenterStatus,
  });

  factory TotalInReviewBooking.fromJson(Map<String, dynamic> json) =>
      TotalInReviewBooking(
        id: json["id"],
        projectId: json["project_id"],      // <-- ADD THIS
        clientName: json["client_name"],
        examName: json["exam_name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        examCityName: json["exam_city_name"],
        numberOfSeats: json["number_of_seats"],
        pricePerSeat: json["price_per_seat"],
        examCenterStatus: json['exam_center_status'],

      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_id": projectId,          // <-- ADD THIS
    "client_name": clientName,
    "exam_name": examName,
    "start_date": startDate,
    "end_date": endDate,
    "exam_city_name": examCityName,
    "number_of_seats": numberOfSeats,
    "price_per_seat": pricePerSeat,
    "exam_center_status":examCenterStatus,
  };
}





class SelfBookingData {
  String? id;
  String? clientName;
  String? examName;
  String? startDate;
  String? endDate;

  SelfBookingData({
    this.id,
    this.clientName,
    this.examName,
    this.startDate,
    this.endDate,
  });

  factory SelfBookingData.fromJson(Map<String, dynamic> json) =>
      SelfBookingData(
        id: json["id"],
        clientName: json["client_name"],
        examName: json["exam_name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_name": clientName,
    "exam_name": examName,
    "start_date": startDate,
    "end_date": endDate,
  };
}

// ================= Exam Dates =================

class ExamDate {
  String? startDate;
  String? endDate;
  String? examName;
  String? type;

  ExamDate({this.startDate, this.endDate, this.examName, this.type});

  factory ExamDate.fromJson(Map<String, dynamic> json) => ExamDate(
    startDate: json["start_date"],
    endDate: json["end_date"],
    examName: json["exam_name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "start_date": startDate,
    "end_date": endDate,
    "exam_name": examName,
    "type": type,
  };
}
