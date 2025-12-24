


import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';
import '../utils/toast_message.dart';

class ProfileUpdateController extends GetxController {
  var isLoading = false.obs;
  Future<void> pickFile({
    required String type,
    bool isImage = false,
  }) async {
    if (isImage) {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (image != null) {
        _assignFile(type, File(image.path));
        update();
      }
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
      );

      if (result != null) {
        _assignFile(type, File(result.files.single.path!));
        update();
      }
    }
  }

  // ================= BASIC INFO =================
  String centerType = "";
  String typeOfCenter = "";
  String centerName = "";
  String centerDescription = "";
  int capacity = 0;
  String postalAddress = "";
  double addressLat = 0.0;
  double addressLong = 0.0;
  String countryId = "";
  String stateId = "";
  String cityId = "";
  String localArea ="";
  String pincode = "";
  String landmark = "";
  String nearestRailway = "";
  String nearestBusStop = "";
  String distaceBus = "";
  String distanceRailways =  "";

  String nearestMetro = "";
  String distaceMetro = "";
  String nearestAirport = "";
  String distaceAirport = "";
  String amName = "";
  String amNumber = "";
  String amEmail = "";

  String csName = "";
  String csNumber = "";
  String csEmail = "";

  String pocName = "";
  String pocEmail = "";
  String pocNumber = "";
  String emergencyNo = "";
  String landLineNo = "";
  String primaaryIsp = '';
  String totalLab ='';
  String totalSystem = "";
  String connectSingle = "";
  String networkTotal = "";
  String partition = "";
  String acInLab = "";
  String networkPrinter = "";
  String projectorLab = "";
  String soundSystem = "";
  String fireExutter = "";
  String lockerFacelity = "";
  String drinkingWater = "";
  String benifiyName = "";
  String bankName = "";
  String bankAccount = "";
  String iFSC = "";
  String panNo = "";
  String gstNo = "";
  String gstStateCode = "";
  String UidiaNo = "";
  String mSMENo = "";
  String primaryIspType = "";
  String primaryInternateSpeed = "";
  String primaryInternateUnit = "";
  String secondryIsp = "";
  String secondryInternatetype = "";
  String secondryInternateUnit = "";
  String generatorCapacity = "";
  String fuilTnak = "";
  String upsBackup = "";
  String upsBackuptimeMinutes= "";
  String secondryIspType = "";











  List<File> labPhotos = [];
  List<File> mainGateImages = [];
  List<File> serverRoomImages = [];
  List<File> observerRoomImages = [];
  List<File> upsGeneratorImages = [];
  File? walkthroughVideo;

  // ================= DOCUMENT FILES =================

  File? entranceImage;
  File? canceledCheque;
  File? agreementFile;
  File? mouFile;
  File? gstCertFile;
  File? udyamCertFile;
  File? panNumberFile;
  List<Map<String, dynamic>> labs = [];


  // ================= UPDATE API =================
  Future<void> updateCenterProfile(BuildContext context) async {
    try {
      isLoading(true);

      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) {
        AppToast.showError(context, "Center ID not found");
        return;
      }

      final body = buildFullBody();
      body['center_id'] = centerId;

      final url = Uri.parse("${ApiEndpoints.baseUrl}/update-center");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("📤 REQUEST BODY => ${jsonEncode(body)}");
      print("📥 RESPONSE => ${response.body}");

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        if (res['status'] == true) {
          AppToast.showSuccess(
              context, res['message'] ?? "Center updated successfully");
        } else {
          AppToast.showError(
              context, res['message'] ?? "Update failed");
        }
      } else {
        AppToast.showError(context, "Server error ${response.statusCode}");
      }
    } catch (e) {
      print("❌ ERROR => $e");
      AppToast.showError(context, "Something went wrong");
    } finally {
      isLoading(false);
    }
  }

  // ================= BUILD REQUEST BODY =================
  Map<String, dynamic> buildFullBody() {
    return {
      // ================= BASIC =================
      "total_no_system":totalSystem,
      "power_back_ups_kv":upsBackup,
      "beneficiary_name":benifiyName,
      "total_no_lab":totalLab,
      "primary_isp_speed":primaryInternateSpeed,
      "center_name": centerName,
      "primary_isp_name":primaaryIsp,
      "primary_isp_connect_type":primaryIspType,
      "center_description": centerDescription,
      "center_type": centerType,
      "type_of_center": typeOfCenter,
      "how_many_network":networkTotal,
      "partitation":partition,
      "primary_internet_speed_unit":primaryInternateUnit,
      "capacity": capacity.toString(),
      "is_there_projector_in_each_lab":projectorLab,
      "address": postalAddress,
      "ac_in_each_lab":acInLab,
      "network_printer":networkPrinter,
      "ups_backup_time":upsBackuptimeMinutes,
      "address_second": "",
      "address_lat": addressLat.toString(),
      "address_long": addressLong.toString(),

      "is_there_sound_sytem_in_each_lab": soundSystem,
      "how_many_fire_extinguisher_in_each_lab": fireExutter,
      "locker_facility": lockerFacelity,
      "drinking_water_facility": drinkingWater,

      "bank_name":bankName,
      "generator_backup_capacity":generatorCapacity,
      "generator_fuel_tank_capacity":fuilTnak,
      "bank_account_number":bankAccount,
      "bank_ifsc_code":iFSC,
      "pan_no":panNo,
      "gst_no":gstNo,

"secondary_isp_connect_type":secondryIspType,

      "country_id": countryId,
      "state_id": stateId,
      "city_id": cityId,
      "local_area_name": localArea,
      "region_code": "",
      "state_code": "",
      "city_code": "",
      "vendor_id": "0",

      "pin_code": pincode,
      "landmark": landmark,

      // ================= CONTACT =================
      "landline_country_code": "",
      "landline_area_code": "",
      "landline_number": landLineNo,
      "landline_extension": "",
      "mobile_no": "",

      "cs_name": csName,
      "cs_country_code": "",
      "cs_contact_number": csNumber,
      "cs_phone_alternate": "",
      "cs_email": csEmail,

      "am_name": amName,
      "am_country_code": "",
      "am_contact_no": amNumber,
      "am_phone_alternate": "",
      "am_email": amEmail,

      "poc_name": pocName,
      "poc_country_code": "",
      "poc_contact_no": pocNumber,
      "poc_mobile_alternate": pocNumber,
      "poc_email": pocEmail,

      "emergency_counter_code": "",
      "emergency_contact_no": emergencyNo,
      "emergency_number_alternate": "",

      // ================= LOCATION =================
      "nearest_railway_station": nearestRailway,
      "station_lat": "",
      "station_long": "",
      "distance_from_station": distanceRailways,

      "nearest_bus_stop": nearestBusStop,
      "bus_lat": "",
      "bus_long": "",
      "distance_from_bus_stop": distaceBus,

      "nearest_metro_station": nearestMetro,
      "distance_from_metro": distaceMetro,

      "nearest_airport": nearestAirport,
      "distance_from_airport": distaceAirport,

      // ================= BANK / GST =================

      "gst_state_code": "",


      "sec_bank_option": "",
      "secondary_pan_no": "",
      "secondary_bank_name": "",
      "secondary_bank_account_no": "",
      "secondary_bank_ifsc_code": "",
      "secondary_beneficiary_name": "",
"connected_single_network": connectSingle,

      "partitaion_each_lab": "yes",



      "lan_company_name": "",
      "lan_model_number": "",
      "lan_speed": "",
      "lan_managed": "",


      "primary_isp_bband_or_lease": "",


      "secondary_isp_name": secondryIsp,
      "secondary_isp_bband_or_lease": "",

      "secondary_internet_speed_unit": secondryInternateUnit,

      // ================= POWER =================
      "power_backup_generator_kv": "",
      "power_back_ups_kv": "",
      "power_backup_hour": "",
      "power_backup_unit": "",
      "is_generator_backup": "yes",

      "generator_backup_capacity": "",
      "generator_backup_time": "",
      "ups_backup_time": "",
      "backup_hours": "",
      "backup_minutes": "",
      "generator_fuel_tank_capacity": "",

      // ================= FACILITY =================
      "cctv_dvr": "",

      "projector_sound_system": "",
      "fire_extinguisher": "",
      "parking_facility": "",

      "security_guard_male": "0",
      "security_guard_female": "0",
      "entry_point": "0",
      "exit_point": "0",


      "onsite_engineer": "",
      "parents_waiting_hall": "",
      "candidates_waiting_hall": "",
      "availability_of_engineers": "",

      // ================= CENTER META =================
      "center_approved_by": "",
      "center_affiliation_by": "",
      "center_lab_establish_year": "",
      "center_client_name": "",
      "center_prev_exam_name": "",

      "udyam_number": "",
      "uidai_number": "",
      "msme_number": "",
      "has_gst": "yes",
      "has_msme": "yes",

      "verified": "0",
      "approved": "1",
      "deleted": "0",
      "reason_of_delete": "",

      // ================= URLs =================
      "exam_center_url": "",
      "admin_url": "",

      // ================= IMAGES =================
      "center_entrance": entranceImage != null
          ? base64Encode(entranceImage!.readAsBytesSync())
          : null,
      "canceled_cheque": canceledCheque != null
          ? base64Encode(canceledCheque!.readAsBytesSync())
          : null,
      "agreement": agreementFile != null
          ? base64Encode(agreementFile!.readAsBytesSync())
          : null,
      "mou": mouFile != null
          ? base64Encode(mouFile!.readAsBytesSync())
          : null,
      "gst_certificate": gstCertFile != null
          ? base64Encode(gstCertFile!.readAsBytesSync())
          : null,
      "udyam_certificate": udyamCertFile != null
          ? base64Encode(udyamCertFile!.readAsBytesSync())
          : null,
      "pan_number": panNumberFile != null
          ? base64Encode(panNumberFile!.readAsBytesSync())
          : null,

      "lab_photos": labPhotos.map((f) => base64Encode(f.readAsBytesSync())).toList(),
      "main_gate_images": mainGateImages.map((f) => base64Encode(f.readAsBytesSync())).toList(),
      "server_room_images": serverRoomImages.map((f) => base64Encode(f.readAsBytesSync())).toList(),
      "observer_room_images": observerRoomImages.map((f) => base64Encode(f.readAsBytesSync())).toList(),
      "ups_generator_images": upsGeneratorImages.map((f) => base64Encode(f.readAsBytesSync())).toList(),

      "walkthrough_video": walkthroughVideo != null
          ? base64Encode(walkthroughVideo!.readAsBytesSync())
          : null,

      // ================= DOCUMENTS =================
      "agreement": agreementFile != null
          ? base64Encode(agreementFile!.readAsBytesSync())
          : null,

      "canceled_cheque": canceledCheque != null
          ? base64Encode(canceledCheque!.readAsBytesSync())
          : null,

      "gst_certificate": gstCertFile != null
          ? base64Encode(gstCertFile!.readAsBytesSync())
          : null,

      "udyam_certificate": udyamCertFile != null
          ? base64Encode(udyamCertFile!.readAsBytesSync())
          : null,

      "pan_number_file": panNumberFile != null
          ? base64Encode(panNumberFile!.readAsBytesSync())
          : null,
    };
  }
  void _assignFile(String type, File file) {
    switch (type) {
      case "entrance":
        entranceImage = file;
        break;
      case "cheque":
        canceledCheque = file;
        break;
      case "agreement":
        agreementFile = file;
        break;
      case "mou":
        mouFile = file;
        break;
      case "gst_cert":
        gstCertFile = file;
        break;
      case "udyam":
        udyamCertFile = file;
        break;
      case "pan":
        panNumberFile = file;
        break;
    }
  }

}
