class Lab {
  String id;
  String centerId;
  String labName;
  String floorName;
  String noOfComputer;
  String noOfAc;
  String monitorType;
  String operatingSystem;
  String processor;
  String ram;
  String hardDisk;
  String modelNo;
  String noOfEthernetSwitch;
  String noOfPortEthSwitch;
  String switchManageStatus;
  String lanSpeed;
  String ethernetCompany;
  String switchCategory;
  String upsConnected;
  String windowGeneration;
  String? ethernetCompanyOther;
  String? ispConnectType;
  String partitation;
  String noOfCctvEachLab;
  String noOfFan;
  String fireExtinguisher;
  String createdBy;
  String createdOn;
  String lastModifyOn;
  String verified;
  String reasonOfDelete;
  String deleted;

  Lab({
    required this.id,
    required this.centerId,
    required this.labName,
    required this.floorName,
    required this.noOfComputer,
    required this.noOfAc,
    required this.monitorType,
    required this.operatingSystem,
    required this.processor,
    required this.ram,
    required this.hardDisk,
    required this.modelNo,
    required this.noOfEthernetSwitch,
    required this.noOfPortEthSwitch,
    required this.switchManageStatus,
    required this.lanSpeed,
    required this.ethernetCompany,
    required this.switchCategory,
    required this.upsConnected,
    required this.windowGeneration,
    this.ethernetCompanyOther,
    this.ispConnectType,
    required this.partitation,
    required this.noOfCctvEachLab,
    required this.noOfFan,
    required this.fireExtinguisher,
    required this.createdBy,
    required this.createdOn,
    required this.lastModifyOn,
    required this.verified,
    required this.reasonOfDelete,
    required this.deleted,
  });

  factory Lab.fromJson(Map<String, dynamic> json) => Lab(
    id: json["id"] ?? "",
    centerId: json["center_id"] ?? "",
    labName: json["lab_name"] ?? "",
    floorName: json["floor_name"] ?? "",
    noOfComputer: json["no_of_computer"] ?? "0",
    noOfAc: json["no_of_ac"] ?? "0",
    monitorType: json["monitor_type"] ?? "",
    operatingSystem: json["operating_system"] ?? "",
    processor: json["processor"] ?? "",
    ram: json["ram"] ?? "",
    hardDisk: json["hard_disk"] ?? "",
    modelNo: json["model_no"] ?? "",
    noOfEthernetSwitch: json["no_of_ethernet_switch"] ?? "",
    noOfPortEthSwitch: json["no_of_port_eth_switch"] ?? "0",
    switchManageStatus: json["switch_manage_status"] ?? "",
    lanSpeed: json["lan_speed"] ?? "",
    ethernetCompany: json["ethernet_switch_company"] ?? "", // fixed typo
    switchCategory: json["switch_category"] ?? "",
    upsConnected: json["ups_connected"] ?? "",
    windowGeneration: json["window_generation"] ?? "",
    ethernetCompanyOther: json["ethernet_company_other"],
    ispConnectType: json["isp_connect_type"],
    partitation: json["partitation"] ?? "",
    noOfCctvEachLab: json["no_of_cctv_each_lab"] ?? "0",
    noOfFan: json["no_of_fan"] ?? "0",
    fireExtinguisher: json["fire_extinguisher"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdOn: json["created_on"] ?? "",
    lastModifyOn: json["last_modify_on"] ?? "",
    verified: json["verified"] ?? "",
    reasonOfDelete: json["reason_of_delete"] ?? "",
    deleted: json["deleted"] ?? "",
  );
}
