import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import '../models/examCenter_Model.dart';
import '../services/exam_center_service.dart';
import '../utils/shared_preferances.dart';

class LabDetail {
  RxString floor = ''.obs;
  RxString processor = ''.obs;
  RxString monitor = ''.obs;
  RxString os = ''.obs;
  RxString ram = ''.obs;
  RxString hdd = ''.obs;
  RxString ethernetCompany = ''.obs;
  RxString switchCategory = ''.obs;
  RxString ethernetPorts = ''.obs;
  final TextEditingController computersController = TextEditingController();

  void dispose() {
    computersController.dispose();
  }
}
class ExamCenterController extends GetxController {
  // ================= BASIC INFO =================
  var centerId = ''.obs;
  var name = ''.obs;
  var email = ''.obs;
  var mobilePhone = ''.obs;
  var countryCode = ''.obs;
  var isAgree = false.obs;
  var otp = ''.obs;
  var mpin = ''.obs;

  // ================= CENTER INFO =================
  var centerType = ''.obs;
  var typeOfCenter = ''.obs;
  var centerName = ''.obs;
  var centerDescription = ''.obs;
  var capacity = 0.obs;
  var countryId = 0.obs;
  var stateId = 0.obs;
  var cityId = 0.obs;
  var localAreaName = ''.obs;
  var postalAddress = ''.obs;
  var pinCode = ''.obs;

  var addressLat = 0.0.obs;
  var addressLong = 0.0.obs;
  var nearbyLandmark = ''.obs;
  RxBool isLiftAvailable = false.obs;
  // var isLiftAvailable = false.obs;
  var nearestRailwayStation = ''.obs;
  var nearestBusStop = ''.obs;
  var nearestMetroStation = ''.obs;
  var nearestAirport = ''.obs;
  var distanceFromRailwayStation = 0.0.obs;
  var distanceFromBusStop = 0.0.obs;
  var distanceFromMetroStation = 0.0.obs;
  var distanceFromAirport = 0.0.obs;

  // ================= FILES =================
  var entranceFile = Rxn<File>();
  var labPhotoFile = Rxn<File>();
  var mainGateFile = Rxn<File>();
  var serverRoomFile = Rxn<File>();
  var conferenceRoomFile = Rxn<File>();
  var upsGeneratorFile = Rxn<File>();
  var walkthroughVideoFile = Rxn<File>();

  // ================= BANKING =================
  var beneficiaryName = ''.obs;
  var bankName = ''.obs;
  var bankAccountNumber = ''.obs;
  var bankIfsc = ''.obs;
  var panNumber = ''.obs;
  var gstNumber = ''.obs;
  var gstStateCode = 0.obs;
  var uidaiNumber = ''.obs;
  var msmeNumber = ''.obs;
  var hasGst = false.obs;
  var hasMsme = false.obs;

  // ================= CONTACT INFO =================
  var pointOfContact = ''.obs;
  var contactPhoneNumber = ''.obs;
  var contactAlternatePhoneNumber = ''.obs;
  var contactEmail = ''.obs;
  var superintendentName = ''.obs;
  var superintendentNumber = ''.obs;
  var superintendentEmail = ''.obs;
  var assistantManagerName = ''.obs;
  var assistantManagerPhoneNumber = ''.obs;
  var assistantManagerEmail = ''.obs;
  var emergencyLandlineNumber = ''.obs;
  var emergencyPhoneNumber = ''.obs;
  // var partitionInEachLab  = false.obs;
  RxnBool partitionInEachLab = RxnBool();
  // var acInEachLab = false.obs;
  RxnBool acInEachLab = RxnBool();
  var fireExtinguisherInEachLab = 0.obs;
  // ================= LAB DETAILS =================
  RxList<LabDetail> labs = <LabDetail>[].obs;

  var totalNumberOfLab = 0.obs;
  var totalNumberOfSystem = 0.obs;
  // var labAreConnectToSingleNetwork = false.obs;
  RxnBool labAreConnectToSingleNetwork = RxnBool();
  var totalNetwork = 0.obs;

  // var isNetworkPrinterAvailabel = false.obs;
  // var isThereProjectorInEachLab = false.obs;
  RxnBool isThereProjectorInEachLab = RxnBool();
  // var isThereSoundSystemInEachLab = false.obs;
  RxnBool isThereSoundSystemInEachLab = RxnBool();


  var isThereALockerFacilityInLab = false.obs;
  var isThereADrinkingWaterFacilityInLab = false.obs;



  var isNetworkPrinterAvailabel = RxnBool();

  var primaryInfrastructure = ''.obs;
  var primaryIspConnectType = ''.obs;
  var primaryIspSpeed = 0.0.obs;
  var primaryInternetSpeedUnit = ''.obs;
  var secondaryInfrastructure = ''.obs;
  var secondaryIspConnectType = ''.obs;
  var secondaryIspSpeed = 0.0.obs;
  var secondaryInternetSpeedUnit = ''.obs;

  // ================= GENERATOR / UPS =================
  var isGeneratorBackup = false.obs;
  var generatorBackupCapacity = 0.0.obs;
  var generatorFuelTankCapacity = 0.0.obs;
  var upsBackup = 0.obs;
  var upsBackupTime = 0.0.obs;
  var totalNoOfConnection = 0.obs;
  var backupHours = 0.obs;
  var backupMinutes = 0.obs;

  var gstCertFile = Rxn<File>();
  var udhayamFile = Rxn<File>();
  var cancelledChequeFile = Rxn<File>();
  var agreementFile = Rxn<File>();
  var mouFile = Rxn<File>();
  var panCardFile = Rxn<File>();

  void updateLabs(int count) {
    print("🔹 Updating labs to count: $count");
    totalNumberOfLab.value = count;

    while (labs.length < count) {
      labs.add(LabDetail());
      print("✅ Added new LabDetail, total labs: ${labs.length}");
    }

    while (labs.length > count) {
      labs.last.dispose();
      labs.removeLast();
      print("❌ Removed LabDetail, total labs: ${labs.length}");
    }
  }


  // ================= FINAL SUBMIT =================



  Future<void> submitExamCenter() async {
    print("🔹 Preparing ExamCenter data for submission...");

    List<String> getSingleFilePath(Rxn<File>? file) {
      return (file != null && file.value != null) ? [file.value!.path] : [];
    }

// ================= FIXED FILE LISTS =================
    List<String> centerEntrances = getSingleFilePath(entranceFile);
    List<String> labPhotos = getSingleFilePath(labPhotoFile);
    List<String> mainGateImages = getSingleFilePath(mainGateFile);
    List<String> serverRoomImages = getSingleFilePath(serverRoomFile);
    List<String> observerRoomImages = getSingleFilePath(conferenceRoomFile);
    List<String> upsGeneratorImages = getSingleFilePath(upsGeneratorFile);

    print("   File names prepared:");
    print("     Center Entrances: $centerEntrances");
    print("     Lab Photos: $labPhotos");
    print("     Main Gate: $mainGateImages");
    print("     Server Room: $serverRoomImages");
    print("     Conference Room: $observerRoomImages");
    print("     UPS/Generator: $upsGeneratorImages");


    ExamCenter center = ExamCenter(


      name: name.value,
      email: email.value,
      mobilePhone: mobilePhone.value,
      countryCode: countryCode.value,
      isAgree: isAgree.value,
      otp: otp.value,
      mpin: mpin.value,
      centerType: centerType.value,
      typeOfCenter: typeOfCenter.value,
      centerName: centerName.value,
      centerDescription: centerDescription.value,
      capacity: capacity.value,
      countryId: countryId.value,
      stateId: stateId.value,
      cityId: cityId.value,
      localAreaName: localAreaName.value,
      postalAddress: postalAddress.value,
      addressLat: addressLat.value,
      addressLong: addressLong.value,
      nearbyLandmark: nearbyLandmark.value,
      isLiftAvailable: isLiftAvailable.value,
      nearestRailwayStation: nearestRailwayStation.value,
      nearestBusStop: nearestBusStop.value,
      distanceFromRailwayStation: distanceFromRailwayStation.value,
      distanceFromBusStop: distanceFromBusStop.value,
      nearestMetroStation: nearestMetroStation.value,
      distanceFromMetroStation: distanceFromMetroStation.value,
      nearestAirport: nearestAirport.value,
      distanceFromAirport: distanceFromAirport.value,
      pointOfContact: pointOfContact.value,
      contactPhoneNumber: contactPhoneNumber.value,
      contactAlternatePhoneNumber: contactAlternatePhoneNumber.value,
      contactEmail: contactEmail.value,
      superintendentName: superintendentName.value,
      superintendentNumber: superintendentNumber.value,
      superintendentEmail: superintendentEmail.value,
      assistantManagerName: assistantManagerName.value,
      assistantManagerPhoneNumber: assistantManagerPhoneNumber.value,
      assistantManagerEmail: assistantManagerEmail.value,
      emergencyLandlineNumber: emergencyLandlineNumber.value,
      emergencyPhoneNumber: emergencyPhoneNumber.value,
      centerEntrances: centerEntrances,
      labPhotos: labPhotos,
      mainGateImages: mainGateImages,
      serverRoomImages: serverRoomImages,
      observerRoomImages: observerRoomImages,
      upsGeneratorImages: upsGeneratorImages,
      walkthroughVideo: walkthroughVideoFile.value != null
          ? basename(walkthroughVideoFile.value!.path)
          : '',
      floorNumber: labs
          .map((e) => e.floor.value.trim())
          .toList(),
      totalComputers: labs.map((e) => int.tryParse(e.computersController.text) ?? 0).toList(),
      windowGeneration: labs.map((e) => e.processor.value).toList(),
      monitorType: labs.map((e) => e.monitor.value).toList(),
      operatingSystem: labs.map((e) => e.os.value).toList(),
      ram: labs.map((e) => e.ram.value).toList(),
      hdd: labs.map((e) => e.hdd.value).toList(),
      ethernetCompany: labs.map((e) => e.ethernetCompany.value).toList(),
      switchCategory: labs.map((e) => e.switchCategory.value).toList(),
      noOfEachEthernetPorts: labs.map((e) => int.tryParse(e.ethernetPorts.value) ?? 0).toList(),
      ethernetCompanyOther: [],
      totalNumberOfLab: totalNumberOfLab.value,
      totalNumberOfSystem: totalNumberOfSystem.value,
      labAreConnectToSingleNetwork: labAreConnectToSingleNetwork.value,
      totalNetwork: totalNetwork.value,
      partitionInEachLab: partitionInEachLab.value ?? false,
      acInEachLab: acInEachLab.value ?? false,
      howManyFireExtinguisherInEachLab: fireExtinguisherInEachLab.value,
      isNetworkPrinterAvailabel: isNetworkPrinterAvailabel.value,
      isThereProjectorInEachLab: isThereProjectorInEachLab.value ?? false,
      isThereSoundSystemInEachLab: isThereSoundSystemInEachLab.value ?? false,

      isThereALockerFacilityInLab: isThereALockerFacilityInLab.value,
      isThereADrinkingWaterFacilityInLab: isThereADrinkingWaterFacilityInLab.value,
      primaryInfrastructure: primaryInfrastructure.value,
      primaryIspConnectType: primaryIspConnectType.value,
      primaryIspSpeed: primaryIspSpeed.value,
      primaryInternetSpeedUnit: primaryInternetSpeedUnit.value,
      secondaryInfrastructure: secondaryInfrastructure.value,
      secondaryIspConnectType: secondaryIspConnectType.value,
      secondaryIspSpeed: secondaryIspSpeed.value,
      secondaryInternetSpeedUnit: secondaryInternetSpeedUnit.value,
      isGeneratorBackup: isGeneratorBackup.value,
      generatorBackupCapacity: generatorBackupCapacity.value,
      generatorFuelTankCapacity: generatorFuelTankCapacity.value,
      upsBackup: upsBackup.value,
      upsBackupTime: upsBackupTime.value,
      totalNoOfConnection: totalNoOfConnection.value,
      backupHours: backupHours.value,
      backupMinutes: backupMinutes.value,
      beneficiaryName: beneficiaryName.value,
      bankName: bankName.value,
      bankAccountNumber: bankAccountNumber.value,
      bankIfsc: bankIfsc.value,
      panNumber: panNumber.value,
      gstNumber: gstNumber.value,
      gstStateCode: gstStateCode.value,
      uidaiNumber: uidaiNumber.value,
      msmeNumber: msmeNumber.value,
      hasGst: hasGst.value,
      hasMsme: hasMsme.value,
    );

    print("🔹 === SUBMITTING EXAM CENTER DATA ===");
    print("Basic Info:");
    print("  Name: ${name.value}");
    print("  Email: ${email.value}");
    print("  Mobile: ${mobilePhone.value}");
    print("  Country Code: ${countryCode.value}");
    print("  MPIN: ${mpin.value}");
    print("Center Info:");
    print("  Center Name: ${centerName.value}");
    print("  Center Description: ${centerDescription.value}");
    print("  Capacity: ${capacity.value}");
    print("  Center Type: ${centerType.value}");
    print("  Type Of Center: ${typeOfCenter.value}");
    print("  Address Lat: ${addressLat.value}");
    print("  Address Long: ${addressLong.value}");
    print("  Nearby Landmark: ${nearbyLandmark.value}");
    print("Lab Info: Total Labs: ${labs.length}");
    for (int i = 0; i < labs.length; i++) {
      final lab = labs[i];
      print("  Lab ${i + 1}:");
      print("    Floor: ${lab.floor.value}");
      print("    Computers: ${lab.computersController.text}");
      print("    Processor: ${lab.processor.value}");
      print("    Monitor: ${lab.monitor.value}");
      print("    OS: ${lab.os.value}");
      print("    RAM: ${lab.ram.value}");
      print("    HDD: ${lab.hdd.value}");
      print("    Ethernet Company: ${lab.ethernetCompany.value}");
      print("    Switch Category: ${lab.switchCategory.value}");
      print("    Ethernet Ports: ${lab.ethernetPorts.value}");
    }
    print("Files:");
    print("  Entrance: ${entranceFile.value?.path}");
    print("  Lab Photo: ${labPhotoFile.value?.path}");
    print("  Main Gate: ${mainGateFile.value?.path}");
    print("  Server Room: ${serverRoomFile.value?.path}");
    print("  Conference Room: ${conferenceRoomFile.value?.path}");
    print("  UPS/Generator: ${upsGeneratorFile.value?.path}");
    print("  Walkthrough Video: ${walkthroughVideoFile.value?.path}");
    print("Banking Info:");
    print("  Beneficiary Name: ${beneficiaryName.value}");
    print("  Bank Name: ${bankName.value}");
    print("  Account Number: ${bankAccountNumber.value}");
    print("  IFSC: ${bankIfsc.value}");
    print("  PAN: ${panNumber.value}");
    print("  GST: ${gstNumber.value}");
    print("  Has GST: ${hasGst.value}");
    print("  Has MSME: ${hasMsme.value}");
    print("Facilities:");
    print("  Lift Available: ${isLiftAvailable.value}");
    print("  Projector in Labs: ${isThereProjectorInEachLab.value}");
    print("  Sound System in Labs: ${isThereSoundSystemInEachLab.value}");
    print("  Locker Facility: ${isThereALockerFacilityInLab.value}");
    print("  Drinking Water Facility: ${isThereADrinkingWaterFacilityInLab.value}");
    print("Network Info:");
    print("  Total Network: ${totalNetwork.value}");
    print("  Lab Connected to Single Network: ${labAreConnectToSingleNetwork.value}");
    print("Generator / UPS:");
    print("  Generator Backup: ${isGeneratorBackup.value}");
    print("  UPS Backup: ${upsBackup.value}");
    print("  UPS Backup Time: ${upsBackupTime.value}");
    print("  Backup Hours: ${backupHours.value}");
    print("  Backup Minutes: ${backupMinutes.value}");
    print("=====================================");




    print("🔹 Data prepared, calling API...");
    var response = await ExamCenterService.storeExamCenter(center);

    if (response != null) {
      print("✅ Exam Center submitted successfully: $response");

      // final centerId = response['center_id'].toString();
      // await MySharedPrefs.save(centerId);
      final id = response['center_id'].toString();

      centerId.value = id;
      await MySharedPrefs.save(id);

      await MySharedPrefs.saveLoginData(
        mobilePhone: mobilePhone.value,
        mpin: mpin.value,
      );
      final loginData = await MySharedPrefs.getLoginData();
      print("✅ Mobile: ${loginData['mobile_phone']}");
      print("✅ MPIN: ${loginData['mpin']}");
      print("✅ OTP: ${loginData['otp']}");
      print("✅ Center ID: ${centerId.value}");
      print("💾 Center ID saved in SharedPreferences: ${centerId.value}");
      print("💾 Mobile saved in SharedPreferences: ${mobilePhone.value}");
      print("💾 MPIN saved in SharedPreferences: ${mpin.value}");
      print("💾 Center ID saved in SharedPreferences: $centerId");
    } else {
      print("❌ Submission failed!");
    }
  }

  @override
  void onClose() {
    print("🔹 Controller is closing, disposing labs...");
    for (var lab in labs) {
      lab.dispose();
    }
    super.onClose();
  }
}
