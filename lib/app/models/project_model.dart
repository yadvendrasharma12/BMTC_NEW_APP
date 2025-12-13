class ProjectModel {
  bool? status;
  String? message;
  ProjectData? data;

  ProjectModel({this.status, this.message, this.data});

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    status: json['status'],
    message: json['message'],
    data:
    json['data'] != null ? ProjectData.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProjectData {
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

  // Internet Mode
  String? inetModeOs;
  String? inetModeRam;
  String? inetModeProcessor;
  String? inetModeDisplay;
  String? inetModeInternetEach;

  // Server Mode
  String? serverModeOs;
  String? serverModeRam;
  String? serverModeProcessor;
  String? serverModeRatio;
  String? serverModeInternet;

  // Batch info
  String? totalBatch;
  String? batch1;
  String? batch2;
  String? batch3;
  String? batch4;
  String? batch5;

  // Facilities
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

  // Ratios
  String? centerSuptnRatio;
  String? techPersonRatio;
  String? invigilatorRatio;
  String? securityGuardRatio;

  // Gender counts
  String? techPersonMale;
  String? invigilatorMale;
  String? invigilatorFemale;
  String? securityGuardMale;
  String? securityGuardFemale;
  String? techPersonFemale;
  String? centerSuptnMale;
  String? centerSuptnFemale;

  // IDs + City
  String? stateId;
  String? examCityId;
  String? examCityName;

  // Seats
  String? examRequiredSeat;
  String? examReqDays;
  String? numberOfSeats;
  String? pricePerSeat;

  // Status fields
  String? status;
  String? valid;
  String? deleted;
  String? requestStatus;
  String? clientStatus;
  String? examCenterStatus;

  // Dates
  String? createdBy;
  String? createdOn;
  String? lastModifiedBy;
  String? lastModifiedOn;

  // Booking
  String? bookingReceived;
  String? centerBookingAcceptDate;
  String? clientAcceptBookingDate;

  String? centerId;
  String? cityName;

  ProjectData({
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
    this.numberOfSeats,
    this.pricePerSeat,
    this.status,
    this.valid,
    this.deleted,
    this.requestStatus,
    this.clientStatus,
    this.examCenterStatus,
    this.createdBy,
    this.createdOn,
    this.lastModifiedBy,
    this.lastModifiedOn,
    this.bookingReceived,
    this.centerBookingAcceptDate,
    this.clientAcceptBookingDate,
    this.centerId,
    this.cityName,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
    id: json["id"],
    projectId: json["project_id"],
    clientId: json["client_id"],
    clientName: json["client_name"],
    examName: json["exam_name"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    examType: json["exam_type"],
    examTypeDetail: json["exam_type_detail"],
    examMode: json["exam_mode"],
    inetModeOs: json["inet_mode_os"],
    inetModeRam: json["inet_mode_ram"],
    inetModeProcessor: json["inet_mode_processor"],
    inetModeDisplay: json["inet_mode_display"],
    inetModeInternetEach: json["inet_mode_internet_each"],
    serverModeOs: json["server_mode_os"],
    serverModeRam: json["server_mode_ram"],
    serverModeProcessor: json["server_mode_processor"],
    serverModeRatio: json["server_mode_ratio"],
    serverModeInternet: json["server_mode_internet"],
    totalBatch: json["total_batch"],
    batch1: json["batch1"],
    batch2: json["batch2"],
    batch3: json["batch3"],
    batch4: json["batch4"],
    batch5: json["batch5"],
    parkingFacility: json["parking_facility"],
    securityGuard: json["security_guard"],
    lockerFacility: json["locker_facility"],
    waitingArea: json["waiting_area"],
    powerBackup: json["power_backup"],
    phHandicaped: json["ph_handicaped"],
    printer: json["printer"],
    roughSheet: json["rough_sheet"],
    partitionInLab: json["partition_in_lab"],
    acInLab: json["ac_in_lab"],
    cctvRequired: json["cctv_required"],
    cctvRecording: json["cctv_recording"],
    centerSuptnRatio: json["center_suptn_ratio"],
    techPersonRatio: json["tech_person_ratio"],
    invigilatorRatio: json["invigilator_ratio"],
    securityGuardRatio: json["security_guard_ratio"],
    techPersonMale: json["tech_person_male"],
    invigilatorMale: json["invigilator_male"],
    invigilatorFemale: json["invigilator_female"],
    securityGuardMale: json["security_guard_male"],
    securityGuardFemale: json["security_guard_female"],
    techPersonFemale: json["tech_person_female"],
    centerSuptnMale: json["center_suptn_male"],
    centerSuptnFemale: json["center_suptn_female"],
    stateId: json["state_id"],
    examCityId: json["exam_city_id"],
    examCityName: json["exam_city_name"],
    examRequiredSeat: json["exam_required_seat"],
    examReqDays: json["exam_req_days"],
    numberOfSeats: json["number_of_seats"],
    pricePerSeat: json["price_per_seat"],
    status: json["status"],
    valid: json["valid"],
    deleted: json["deleted"],
    requestStatus: json["request_status"],
    clientStatus: json["client_status"],
    examCenterStatus: json["exam_center_status"],
    createdBy: json["created_by"],
    createdOn: json["created_on"],
    lastModifiedBy: json["last_modified_by"],
    lastModifiedOn: json["last_modified_on"],
    bookingReceived: json["booking_received"],
    centerBookingAcceptDate: json["center_booking_accept_date"],
    clientAcceptBookingDate: json["client_accept_booking_date"],
    centerId: json["center_id"],
    cityName: json["city_name"],
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
    "number_of_seats": numberOfSeats,
    "price_per_seat": pricePerSeat,
    "status": status,
    "valid": valid,
    "deleted": deleted,
    "request_status": requestStatus,
    "client_status": clientStatus,
    "exam_center_status": examCenterStatus,
    "created_by": createdBy,
    "created_on": createdOn,
    "last_modified_by": lastModifiedBy,
    "last_modified_on": lastModifiedOn,
    "booking_received": bookingReceived,
    "center_booking_accept_date": centerBookingAcceptDate,
    "client_accept_booking_date": clientAcceptBookingDate,
    "center_id": centerId,
    "city_name": cityName,
  };
}
