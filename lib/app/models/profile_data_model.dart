class CenterResponse {
  final bool status;
  final String message;
  final CenterData data;

  CenterResponse({required this.status, required this.message, required this.data});

  factory CenterResponse.fromJson(Map<String, dynamic> json) {
    return CenterResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: CenterData.fromJson(json['data']),
    );
  }
}

class CenterData {
  final List<Country> countries;
  final List<State> states; // add this
  final List<City> cities;  // add this
  final List<CenterType> centerType;
  final Center center;
  final List<Lab> labs;
  final List<Document> documents;
  final List<CenterImage> images;

  CenterData({
    required this.countries,
    required this.states,
    required this.cities,
    required this.centerType,
    required this.center,
    required this.labs,
    required this.documents,
    required this.images,
  });

  factory CenterData.fromJson(Map<String, dynamic> json) {
    return CenterData(
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e))
          .toList() ?? [],
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => State.fromJson(e))
          .toList() ?? [],
      cities: (json['cities'] as List<dynamic>?)
          ?.map((e) => City.fromJson(e))
          .toList() ?? [],
      centerType: (json['center_type'] as List<dynamic>?)
          ?.map((e) => CenterType.fromJson(e))
          .toList() ?? [],
      center: Center.fromJson(json['center']),
      labs: (json['labs'] as List<dynamic>?)
          ?.map((e) => Lab.fromJson(e))
          .toList() ?? [],
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e))
          .toList() ?? [],
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => CenterImage.fromJson(e))
          .toList() ?? [],
    );
  }
}

class State {
  final String id;
  final String name;
  State({required this.id, required this.name});

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class City {
  final String id;
  final String name;
  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Country {
  final String id;
  final String name;
  Country({required this.id, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class CenterType {
  final String id;
  final String centerType;
  CenterType({required this.id, required this.centerType});

  factory CenterType.fromJson(Map<String, dynamic> json) {
    return CenterType(
      id: json['id'] ?? '',
      centerType: json['center_type'] ?? '',
    );
  }
}

class Center {
  final String id;
  final String centerType;
  final String centerId;
  final String countryId;
  final String stateId;
  final String cityId;
  final String centerName;
  final String address;
  final String addressLat;
  final String addressLong;
  final String description;
  final String landmark;
  final String pinCode;
  final String landlineNumber;
  final String beneficiaryName;
  final String csName;
  final String csContactNumber;
  final String amName;
  final String amContactNo;
  final String pocName;
  final String pocContactNo;
  final String pocMobileAlternate;
  final String emergencyContactNo;
  final String totalNoSystem;
  final String totalNoLab;
  final String primaryIspName;
  final String primaryIspSpeed;
  final String secondaryIspName;
  final String secondaryIspSpeed;
  final String upsBackupTime;
  final String nearestMetroStation;
  final String distanceFromMetro;
  final String nearestAirport;
  final String distanceFromAirport;
  final String examCenterUrl;
  final String adminUrl;
  final String capacity;
  final String localArea;
  final String logo;
  final String generatorBackupCapacity;
  final String generatorBackupTime;
  final String backupHours;
  final String backupMinutes;
  final String nearestRailway;
  final String distanceRailw;
  final String nearestBus;
  final String distanceBus;
  final String pocEmail;
  final String csEmail;
  final String amEmail;
  final String connectedSingleNetwork;
  final String howManyNetwork;
  final String parttionEachLab;
  final String acInLab;
  final String printerLab;
  final String projectorLab;
  final String? soundSystem;
  final String? fireExuter;
  final String lockerFacelity;
  final String drinkingWater;
  final String primaryConnectType;
  final String speedUnitPrimary;
  final String secoundaryUnit;
  final String secondaryConnectedType;
  final String? upsBackupKua;
  final String bankName;
  final String bankAccount;
  final String Ifsc;
  final String panNo;
  final String gstNo;
  final String gstState;
  final String uidainNo;
  final String msmeNo;
  final String primaryinternetspeedunit;
  final String? powerbachup;
  final String fuilTankCapacity;
  final String typeOfCenter;
  final String amAltNumber;
  final bool? isLiftAvailable;



  Center({
    required this.id,
    required this.centerType,
    required this.centerId,
    required this.countryId,
    required this.stateId,
    required this.bankAccount,
    required this.cityId,
    required this.centerName,
    required this.address,
    required this.addressLat,
    required this.addressLong,
    required this.landmark,
    required this.pinCode,
    required this.landlineNumber,
    required this.beneficiaryName,
    required this.csName,
    required this.csContactNumber,
    required this.amName,
    required this.amContactNo,
    required this.pocName,
    required this.pocContactNo,
    required this.pocMobileAlternate,
    required this.emergencyContactNo,
    required this.totalNoSystem,
    required this.totalNoLab,
    required this.primaryIspName,
    required this.primaryIspSpeed,
    required this.secondaryIspName,
    required this.secondaryIspSpeed,
    required this.upsBackupTime,
    required this.nearestMetroStation,
    required this.distanceFromMetro,
    required this.nearestAirport,
    required this.distanceFromAirport,
    required this.examCenterUrl,
    required this.adminUrl,
    required this.capacity,
    required this.logo,
    required this.generatorBackupCapacity,
    required this.generatorBackupTime,
    required this.backupHours,
    required this.backupMinutes,
    required this.description,
    required this.localArea,
    required this.nearestRailway,
    required this.distanceRailw,
    required this.nearestBus,
    required this.distanceBus,
    required this.pocEmail,
    required this.csEmail,
    required this.amEmail,
    required this.connectedSingleNetwork,
    required this.howManyNetwork,
    required this.parttionEachLab,
    required this.acInLab,
    required this.printerLab,
    required this.projectorLab,
    required this.soundSystem,
    required this.fireExuter,
    required this.lockerFacelity,
    required this.drinkingWater,
    required this.primaryConnectType,
    required this.speedUnitPrimary,
    required this.secoundaryUnit,
    required this.secondaryConnectedType,
    required this.upsBackupKua,
    required this.bankName,
    required this.Ifsc,
    required this.panNo,
    required this.gstState,
    required this.uidainNo,
    required this.gstNo,
    required  this.msmeNo,
    required this.powerbachup,
    required this.primaryinternetspeedunit,
    required this.fuilTankCapacity,
    required this.typeOfCenter,
    required this.amAltNumber,
    required this.isLiftAvailable,
  });

  factory Center.fromJson(Map<String, dynamic> json) {
    return Center(
      id: json['id'] ?? '',
      centerType: json['center_type'] ?? '',
      centerId: json['center_id'] ?? '',
      countryId: json['country_id'] ?? '',
      bankName: json["bank_name"],
      stateId: json['state_id'] ?? '',
      cityId: json['city_id'] ?? '',
      description: json['center_description']?? '',
      bankAccount: json["bank_account_number"]?? '',
      uidainNo: json["uidai_number"]?? '',
      powerbachup: json["power_back_ups_kv"]?? '',
      primaryinternetspeedunit: json["primary_internet_speed_unit"]?? '',
      localArea: json["local_area_name"]?? '',
      msmeNo: json["msme_number"]?? '',
      speedUnitPrimary: json["primary_internet_speed_unit"]?? '',
      nearestBus: json["nearest_bus_stop"]?? '',
      lockerFacelity: json['locker_facility']?? '',
      gstState: json["gst_state_code"]?? '',
      Ifsc: json["bank_ifsc_code"]?? '',
      panNo: json["pan_no"]?? '',
      typeOfCenter: json['type_of_center']?? '',
      distanceBus: json["distance_from_bus_stop"]?? '',
      upsBackupKua: json["power_back_ups_kv"]?? '',
      nearestRailway: json["nearest_railway_station"]?? '',
      centerName: json['center_name'] ?? '',
      fuilTankCapacity: json["generator_fuel_tank_capacity"]?? '',
      distanceRailw: json['distance_from_station']?? '',
      secondaryConnectedType: json["secondary_isp_connect_type"]?? '',
      address: json['address'] ?? '',
      printerLab: json["network_printer"]?? '',
      gstNo: json["gst_no"]?? '',
      fireExuter: json["how_many_fire_extinguisher_in_each_lab"]?? '',
      acInLab: json["ac_in_each_lab"]?? '',
      addressLat: json['address_lat'] ?? '',
      addressLong: json['address_long'] ?? '',
      landmark: json['landmark'] ?? '',
      pinCode: json['pin_code'] ?? '',
      amAltNumber: json['am_phone_alternate']?? '',
      secoundaryUnit: json["secondary_internet_speed_unit"]?? '',
      primaryConnectType: json["primary_isp_connect_type"]?? '',
      drinkingWater: json["drinking_water_facility"]?? '',
      soundSystem: json["is_there_sound_sytem_in_each_lab"]?? '',
      landlineNumber: json['landline_number'] ?? '',
      beneficiaryName: json['beneficiary_name'] ?? '',
      pocEmail: json["poc_email"]?? '',
      csName: json['cs_name'] ?? '',
      csContactNumber: json['cs_contact_number'] ?? '',
      amName: json['am_name'] ?? '',
      amContactNo: json['am_contact_no'] ?? '',
      amEmail: json["am_email"]?? '',
      csEmail: json["cs_email"]?? '',
      projectorLab: json["is_there_projector_in_each_lab"]?? '',
      pocName: json['poc_name'] ?? '',
      pocContactNo: json['poc_contact_no'] ?? '',
      pocMobileAlternate: json['poc_mobile_alternate'] ?? '',
      emergencyContactNo: json['emergency_contact_no'] ?? '',
      totalNoSystem: json['total_no_system'] ?? '',
      howManyNetwork: json["how_many_network"]?? '',
      totalNoLab: json['total_no_lab'] ?? '',
      parttionEachLab: json["partitaion_each_lab"]?? '',
      primaryIspName: json['primary_isp_name'] ?? '',
      primaryIspSpeed: json['primary_isp_speed'] ?? '',
      secondaryIspName: json['secondary_isp_name'] ?? '',
      secondaryIspSpeed: json['secondary_isp_speed'] ?? '',
      upsBackupTime: json['ups_backup_time'] ?? '',
      nearestMetroStation: json['nearest_metro_station'] ?? '',
      distanceFromMetro: json['distance_from_metro'] ?? '',
      nearestAirport: json['nearest_airport'] ?? '',
      distanceFromAirport: json['distance_from_airport'] ?? '',
      examCenterUrl: json['exam_center_url'] ?? '',
      adminUrl: json['admin_url'] ?? '',
      capacity: json['capacity'] ?? '',
      logo: json['logo'] ?? '',
      isLiftAvailable: json['is_lift_available'] == true,
      generatorBackupCapacity: json['generator_backup_capacity'] ?? '',
      generatorBackupTime: json['generator_backup_time'] ?? '',
      backupHours: json['backup_hours'] ?? '',
      backupMinutes: json['backup_minutes'] ?? '',
      connectedSingleNetwork: json["connected_single_network"]?? '',
    );
  }
}




class Lab {
  final String id;
  final String centerId;
  final String labName;
  final String floorName;
  final String noOfComputer;
  final String noOfAc;
  final String monitorType;
  final String operatingSystem;
  final String ram;
  final String hardDisk;
  final String windowGeneration;
  final String noOfPortEthSwitch;
  final String ehternetSwtchCompany;
  final String switchCategory;


  Lab( {
    required this.id,
    required this.centerId,
    required this.labName,
    required this.floorName,
    required this.noOfComputer,
    required this.noOfAc,
    required this.monitorType,
    required this.operatingSystem,
    required this.ram,
    required this.hardDisk,
    required this.windowGeneration,
    required this.noOfPortEthSwitch,
    required this.ehternetSwtchCompany,
    required this.switchCategory,

  });

  factory Lab.fromJson(Map<String, dynamic> json) {
    return Lab(
      id: json['id'] ?? '',
      centerId: json['center_id'] ?? '',
      labName: json['lab_name'] ?? '',
      floorName: json['floor_name'] ?? '',
      noOfComputer: json['no_of_computer'] ?? '',
      noOfAc: json['no_of_ac'] ?? '',
      monitorType: json['monitor_type'] ?? '',
      operatingSystem: json['operating_system'] ?? '',

      ram: json['ram'] ?? '',
      hardDisk: json['hard_disk'] ?? '',
      windowGeneration: json['window_generation'] ?? '',
      noOfPortEthSwitch: json['no_of_port_eth_switch'] ?? '',
      ehternetSwtchCompany: json['ehternet_swtch_company'] ?? '',
      switchCategory: json['switch_category'] ?? '',
    );
  }
}

class Document {
  final String id;
  final String centerId;
  final String docName;
  final String url;

  Document({
    required this.id,
    required this.centerId,
    required this.docName,
    required this.url,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id']?.toString() ?? '',
      centerId: json['center_id']?.toString() ?? '',
      docName: json['doc_name'] ?? 'Document',
      url: json['url'] ?? '',
    );
  }
}


class CenterImage {
  final String id;
  final String centerId;
  final String imageType;
  final String centerImage;

  CenterImage({
    required this.id,
    required this.centerId,
    required this.imageType,
    required this.centerImage,
  });

  factory CenterImage.fromJson(Map<String, dynamic> json) {
    return CenterImage(
      id: json['id'] ?? '',
      centerId: json['center_id'] ?? '',
      imageType: json['image_type'] ?? '',
      centerImage: json['center_image'] ?? '',
    );
  }



}

