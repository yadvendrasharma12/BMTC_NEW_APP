import 'dart:convert';
import 'lab_model.dart';

ProfileDataModel profileDataModelFromJson(String str) =>
    ProfileDataModel.fromJson(json.decode(str));

String profileDataModelToJson(ProfileDataModel data) =>
    json.encode(data.toJson());

class ProfileDataModel {
  bool status;
  String message;
  Data data;

  ProfileDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
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
  Map<String, dynamic> center;
  List<Lab> labs;
  List<dynamic> images; // <- ye add karo
  Data({
    required this.center,
    required this.labs,
    required this.images, // <- constructor me bhi
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    center: json["center"],
    labs: (json["labs"] as List? ?? [])
        .map((e) => Lab.fromJson(e))
        .toList(),
    images: json["images"] as List? ?? [], // <- JSON se parse kar rahe
  );

  Map<String, dynamic> toJson() => {
    "center": center,
    "labs": labs.map((e) => {
      "id": e.id,
      "center_id": e.centerId,
      "lab_name": e.labName,
      "floor_name": e.floorName,
      "no_of_computer": e.noOfComputer,
      "no_of_ac": e.noOfAc,
      "monitor_type": e.monitorType,
      "operating_system": e.operatingSystem,
      "processor": e.processor,
      "ram": e.ram,
      "hard_disk": e.hardDisk,
      "model_no": e.modelNo,
      "no_of_ethernet_switch": e.noOfEthernetSwitch,
      "no_of_port_eth_switch": e.noOfPortEthSwitch,
      "switch_manage_status": e.switchManageStatus,
      "lan_speed": e.lanSpeed,
      "ehternet_swtch_company": e.ethernetCompany,
      "switch_category": e.switchCategory,
      "ups_connected": e.upsConnected,
      "window_generation": e.windowGeneration,
      "ethernet_company_other": e.ethernetCompanyOther,
      "isp_connect_type": e.ispConnectType,
      "partitation": e.partitation,
      "no_of_cctv_each_lab": e.noOfCctvEachLab,
      "no_of_fan": e.noOfFan,
      "fire_extinguisher": e.fireExtinguisher,
      "created_by": e.createdBy,
      "created_on": e.createdOn,
      "last_modify_on": e.lastModifyOn,
      "verified": e.verified,
      "reason_of_delete": e.reasonOfDelete,
      "deleted": e.deleted,
    }).toList(),
    "images": images, // <- toJson me bhi add
  };

  void operator [](String other) {}
}
