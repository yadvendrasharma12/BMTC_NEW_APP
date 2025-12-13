import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../screens/home/center_pages/edit_center_information_screen.dart';
import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';
import '../utils/toast_message.dart';

class ProfileUpdateController extends GetxController {
  var isLoading = false.obs;

  List<Map<String, dynamic>> labsPayload = [];
  /// ============ UPDATE CENTER PROFILE ============
  Future<void> updateCenterProfile(BuildContext context) async {
    try {
      isLoading(true);

      // Get center_id from SharedPreferences
      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) {
        AppToast.showError(context, "Center ID not found!");
        isLoading.value = false;
        return;
      }

      final body = buildFullBody();
      body['center_id'] = centerId;

      final url = Uri.parse("${ApiEndpoints.baseUrl}/update-center");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      print("📤 REQUEST BODY: ${json.encode(body)}");
      print("✅ RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        if (res['status'] == true) {
          AppToast.showSuccess(context, res['message'] ?? "Center updated successfully!");
        } else {
          AppToast.showError(context, res['message'] ?? "Failed to update center");
        }
      } else {
        AppToast.showError(context, "Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ ERROR: $e");
      AppToast.showError(context, "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }

  /// ============ BUILD FULL REQUEST BODY ============
  Map<String, dynamic> buildFullBody() {
    return {
      // Basic Info
      "center_type": centerType,
      "type_of_center": typeOfCenter,
      "center_name": centerName,
      "center_description": centerDescription,
      "capacity": capacity,
      "country_id": countryId,
      "state_id": stateId,
      "city_id": cityId,
      "local_area_name": localAreaName,
      "postal_address": postalAddress,
      "address_lat": addressLat,
      "address_long": addressLong,
      "nearby_landmark": nearbyLandmark,
      "is_lift_available": isLiftAvailable ? "Yes" : "No",

      // Contact Info
      "point_of_contact": pointOfContact,
      "contact_phone_number": contactPhoneNumber,
      "contact_alternate_phone_number": contactAlternatePhoneNumber,
      "contact_email": contactEmail,
      "superintendent_name": superintendentName,
      "superintendent_number": superintendentNumber,
      "superintendent_email": superintendentEmail,
      "assistant_manager_name": assistantManagerName,
      "assistant_manager_phone_number": assistantManagerPhoneNumber,
      "assistant_manager_email": assistantManagerEmail,
      "emergency_landline_number": emergencyLandlineNumber,
      "emergency_phone_number": emergencyPhoneNumber,

      // Center Extra Info
      "region_code": regionCode,
      "state_code": stateCode,
      "city_code": cityCode,
      "vendor_id": vendorId,
      "address_second": addressSecond,
      "nearest_railway_station": nearestRailwayStation,
      "station_lat": stationLat,
      "station_long": stationLong,
      "distance_from_station": distanceFromStation,
      "nearest_bus_stop": nearestBusStop,
      "bus_lat": busLat,
      "bus_long": busLong,
      "distance_from_bus_stop": distanceFromBusStop,
      "nearest_metro_station": nearestMetroStation,
      "distance_from_metro": distanceFromMetro,
      "nearest_airport": nearestAirport,
      "distance_from_airport": distanceFromAirport,
      "for_ph_candidate": forPHCandidate,
      "phydical_handicapped": physicalHandicapped,
      "document_sign": documentSign,
      "photographs": photographs,
      "cs_name": csName,
      "cs_country_code": csCountryCode,
      "cs_contact_number": csContactNumber,
      "cs_phone_alternate": csPhoneAlternate,
      "cs_email": csEmail,
      "am_name": amNameExtra,
      "am_country_code": amCountryCodeExtra,
      "am_contact_no": amContactNoExtra,
      "am_phone_alternate": amPhoneAlternateExtra,
      "am_email": amEmailExtra,
      "poc_name": pocName,
      "poc_country_code": pocCountryCode,
      "poc_contact_no": pocContactNo,
      "poc_mobile_alternate": pocMobileAlternate,
      "poc_email": pocEmail,
      "td_name": tdName,
      "td_country_code": tdCountryCode,
      "td_contact_no": tdContactNo,
      "td_phone_alternate": tdPhoneAlternate,
      "td_email": tdEmail,
      "total_no_system": totalNumberOfSystem,
      "total_no_lab": totalNumberOfLab,
      "partition_in_each_lab": partitionEachLab,
      "connected_single_network": connectedSingleNetwork,
      "ac_in_each_lab": acInEachLabExtra,
      "lan_company_name": lanCompanyName,
      "lan_model_number": lanModelNumber,
      "lan_speed": lanSpeed,
      "lan_managed": lanManaged,
      "primary_isp_name": primaryISPName,
      "primary_isp_bband_or_lease": primaryISPBbandOrLease,
      "secondary_isp_name": secondaryISPName,
      "secondary_isp_bband_or_lease": secondaryISPBbandOrLease,
      "power_backup_generator_kv": powerBackupGeneratorKV,
      "power_back_ups_kv": powerBackUpsKV,
      "power_backup_hour": powerBackupHour,
      "power_backup_unit": powerBackupUnit,
      "cctv_dvr": cctvDVR,
      "network_printer": networkPrinterExtra,
      "projector_sound_system": projectorSoundSystem,
      "how_many_fire_extinguisher_in_each_lab": fireExtinguisherExtra,
      "parking_facility": parkingFacility,
      "security_guard_male": securityGuardMale,
      "security_guard_female": securityGuardFemale,
      "entry_point": entryPoint,
      "exit_point": exitPoint,
      "locker_facility": lockerFacility,
      "drinking_water_facility": drinkingWaterFacilityExtra,
      "onsite_engineer": onsiteEngineer,
      "parents_waiting_hall": parentsWaitingHall,
      "candidates_waiting_hall": candidatesWaitingHall,
      "availability_of_engineers": availabilityOfEngineers,
      "center_approved_by": centerApprovedBy,
      "center_affiliation_by": centerAffiliationBy,
      "center_lab_establish_year": centerLabEstablishYear,
      "center_client_name": centerClientName,
      "center_prev_exam_name": centerPrevExamName,
      "udyam_number": udyamNumber,

      // Backup Info
      "is_generator_backup": isGeneratorBackup,
      "generator_backup_capacity": generatorBackupCapacity,
      "generator_fuel_tank_capacity": generatorFuelTankCapacity,
      "ups_backup": upsBackup,
      "ups_backup_time": upsBackupTime,
      "total_no_of_connection": totalNoOfConnection,
      "backup_hours": backupHours,
      "backup_minutes": backupMinutes,

      // Bank & Legal Info
      "beneficiary_name": beneficiaryName,
      "bank_name": bankName,
      "bank_account_number": bankAccountNumber,
      "bank_ifsc_code": bankIfsc,
      "pan_no": pannumber,
      "gst_no": gstNumber,
      "gst_state_code": gstStateCode,
      "uidai_number": uidaiNumber,
      "msme_number": msmeNumber,
      "has_gst": hasGst,
      "has_msme": hasMsme,






      // Media & Files
      "lab_photos": labPhotos.map((f) => base64Encode(f.readAsBytesSync())).toList(),
      "canceled_cheque": canceledCheque != null ? base64Encode(canceledCheque!.readAsBytesSync()) : null,
      "agreement": agreementFile != null ? base64Encode(agreementFile!.readAsBytesSync()) : null,
      "mou": mouFile != null ? base64Encode(mouFile!.readAsBytesSync()) : null,
      "gst_certificate": gstCertFile != null ? base64Encode(gstCertFile!.readAsBytesSync()) : null,
      "udyam_certificate": udyamCertFile != null ? base64Encode(udyamCertFile!.readAsBytesSync()) : null,
      "pan_number": panNumberFile != null ? base64Encode(panNumberFile!.readAsBytesSync()) : null,
    };
  }

  // ================= FIELDS ===================
  // Basic Info
  String centerType = "";
  String typeOfCenter = "";
  String centerName = "";
  String centerDescription = "";
  int capacity = 0;
  String countryId = "";
  String stateId = "";
  String cityId = "";
  String localAreaName = "";
  String postalAddress = "";
  double addressLat = 0.0;
  double addressLong = 0.0;
  String nearbyLandmark = "";
  bool isLiftAvailable = false;

  // Contact Info
  String pointOfContact = "";
  String contactPhoneNumber = "";
  String contactAlternatePhoneNumber = "";
  String contactEmail = "";
  String superintendentName = "";
  String superintendentNumber = "";
  String superintendentEmail = "";
  String assistantManagerName = "";
  String assistantManagerPhoneNumber = "";
  String assistantManagerEmail = "";
  String emergencyLandlineNumber = "";
  String emergencyPhoneNumber = "";

  // Media & Files
  List<String> centerEntrances = [];
  List<File> labPhotos = [];
  List<String> mainGateImages = [];
  List<String> serverRoomImages = [];
  List<String> observerRoomImages = [];
  List<String> upsGeneratorImages = [];
  String walkthroughVideo = "";

  // Center Extra Info
  String regionCode = "";
  String stateCode = "";
  String cityCode = "";
  String vendorId = "";
  String addressSecond = "";
  String nearestRailwayStation = "";
  String stationLat = "";
  String stationLong = "";
  String distanceFromStation = "";
  String nearestBusStop = "";
  String busLat = "";
  String busLong = "";
  String distanceFromBusStop = "";
  String nearestMetroStation = "";
  String distanceFromMetro = "";
  String nearestAirport = "";
  String distanceFromAirport = "";
  String forPHCandidate = "";
  String physicalHandicapped = "";
  String documentSign = "";
  String photographs = "";
  String csName = "";
  String csCountryCode = "";
  String csContactNumber = "";
  String csPhoneAlternate = "";
  String csEmail = "";
  String amNameExtra = "";
  String amCountryCodeExtra = "";
  String amContactNoExtra = "";
  String amPhoneAlternateExtra = "";
  String amEmailExtra = "";
  String pocName = "";
  String pocCountryCode = "";
  String pocContactNo = "";
  String pocMobileAlternate = "";
  String pocEmail = "";
  String tdName = "";
  String tdCountryCode = "";
  String tdContactNo = "";
  String tdPhoneAlternate = "";
  String tdEmail = "";
  String totalNoSystemExtra = "";
  String totalNoLabExtra = "";
  String partitionEachLab = "";
  String connectedSingleNetwork = "";
  String acInEachLabExtra = "";
  String lanCompanyName = "";
  String lanModelNumber = "";
  String lanSpeed = "";
  String lanManaged = "";
  String primaryISPName = "";
  String primaryISPBbandOrLease = "";
  String secondaryISPName = "";
  String secondaryISPBbandOrLease = "";
  String powerBackupGeneratorKV = "";
  String powerBackUpsKV = "";
  String powerBackupHour = "";
  String powerBackupUnit = "";
  String cctvDVR = "";
  String networkPrinterExtra = "";
  String projectorSoundSystem = "";
  String fireExtinguisherExtra = "";
  String parkingFacility = "";
  int securityGuardMale = 0;
  int securityGuardFemale = 0;
  int entryPoint = 0;
  int exitPoint = 0;
  String lockerFacility = "";
  String drinkingWaterFacilityExtra = "";
  String onsiteEngineer = "";
  String parentsWaitingHall = "";
  String candidatesWaitingHall = "";
  String availabilityOfEngineers = "";
  String centerApprovedBy = "";
  String centerAffiliationBy = "";
  String centerLabEstablishYear = "";
  String centerClientName = "";
  String centerPrevExamName = "";
  String udyamNumber = "";
  File? udyamDocument;

  // Files/Documents
  File? canceledCheque;
  File? agreementFile;
  File? mouFile;
  File? gstCertFile;
  File? udyamCertFile;
  File? panNumberFile;

  // Logo / Images
  String centerLogo = "";
  List<String> labImages = [];
  List<String> gateImages = [];
  List<String> serverImages = [];
  List<String> observerImages = [];
  List<String> upsImages = [];

  // Exam/Admin URLs
  String examCenterUrl = "";
  String adminUrl = "";

  // Coupon / Audit
  String couponCode = "";
  String couponStatus = "";
  String couponAdd = "";
  String couponCreateDate = "";
  File? auditFile;
  String auditStatus = "";
  String lastAudited = "";
  String approved = "";

  // Lab & Equipment Info
  List<int> floorNumber = [];
  List<int> totalComputers = [];
  List<String> windowGeneration = [];
  List<String> monitorType = [];
  List<String> operatingSystem = [];
  List<String> ram = [];
  List<String> hdd = [];
  List<String> ethernetCompany = [];
  List<String> switchCategory = [];
  List<int> noOfEachEthernetPorts = [];
  List<String> ethernetCompanyOther = [];

  int totalNumberOfLab = 0;
  int totalNumberOfSystem = 0;
  bool labAreConnectToSingleNetwork = false;
  int totalNetwork = 0;
  int partitionInEachLab = 0;
  bool isNetworkPrinterAvailabel = false;
  bool isThereProjectorInEachLab = false;
  bool isThereSoundSystemInEachLab = false;
  int howManyFireExtinguisherInEachLab = 0;
  bool isThereALockerFacilityInLab = false;
  bool isThereADrinkingWaterFacilityInLab = false;

  // Network Info
  String primaryInfrastructure = "";
  String primaryIspConnectType = "";
  double primaryIspSpeed = 0.0;
  String acInEachLab = "";
  String primaryInternetSpeedUnit = "";

  String secondaryInfrastructure = "";
  String secondaryIspConnectType = "";
  double secondaryIspSpeed = 0.0;
  String secondaryInternetSpeedUnit = "";

  // Backup Info
  bool isGeneratorBackup = false;
  double generatorBackupCapacity = 0.0;
  double generatorFuelTankCapacity = 0.0;
  bool upsBackup = false;
  double upsBackupTime = 0.0;
  int totalNoOfConnection = 0;
  int backupHours = 0;
  int backupMinutes = 0;

  // Bank & Legal Info
  String beneficiaryName = "";
  String bankName = "";
  String bankAccountNumber = "";
  String bankIfsc = "";
  String pannumber = "";
  String gstNumber = "";
  int gstStateCode = 0;
  String uidaiNumber = "";
  String msmeNumber = "";
  bool hasGst = false;
  bool hasMsme = false;
}
