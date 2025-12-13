// import 'dart:convert';
// import 'dart:io';
// import 'package:bmtc_app/app/screens/auth_pages/main_page/main_screen.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:http/http.dart' as http;
// import '../models/examCenter_Model.dart';
// import '../utils/toast_message.dart';
//
// class ExamCenterService {
//   static Future<Map<String, dynamic>?> storeExamCenter(ExamCenter center) async {
//     const String url =
//         "http://staging.bookmytestcenter.com/api/api/v1/store-exam-center";
//
//     try {
//       print("🔹 Preparing request for Exam Center submission...");
//
//       var request = http.MultipartRequest("POST", Uri.parse(url));
//
//       // ✅ HEADERS
//       request.headers.addAll({
//         "Accept": "application/json",
//       });
//
//       print("🔹 Headers added: ${request.headers}");
//
//       // ✅ NORMAL (NON-LIST) FIELDS
//       print("🔹 Adding normal fields...");
//       center.toJson().forEach((key, value) {
//         if (value != null && value is! List) {
//           request.fields[key] = value.toString();
//           print("   Field: $key => ${value.toString()}");
//         }
//       });
//
//       // ✅ NORMAL ARRAY FIELDS (INT / STRING LIST)
//       void addArray(String key, List list) {
//         for (var item in list) {
//           request.fields["$key[]"] = item.toString();
//           print("   Array Field: $key[] => ${item.toString()}");
//         }
//       }
//
//       print("🔹 Adding normal array fields...");
//       addArray("floor_number", center.floorNumber);
//       addArray("total_computers", center.totalComputers);
//       addArray("window_generation", center.windowGeneration);
//       addArray("monitor_type", center.monitorType);
//       addArray("operating_system", center.operatingSystem);
//       addArray("ram", center.ram);
//       addArray("hdd", center.hdd);
//       addArray("ethernet_company", center.ethernetCompany);
//       addArray("switch_category", center.switchCategory);
//       addArray("no_of_each_ethernet_ports", center.noOfEachEthernetPorts);
//
//       request.fields["partition_in_each_lab"] =
//           center.partitionInEachLab.toString();
//
//       request.fields["ac_in_each_lab"] =
//           center.acInEachLab.toString();
//
//       request.fields["how_many_fire_extinguisher_in_each_lab"] =
//           center.howManyFireExtinguisherInEachLab.toString();
//
//       // ✅ ✅ ✅ IMAGE / FILE UPLOAD FUNCTION
//       Future<void> addFileArray(
//           http.MultipartRequest request,
//           String key,
//           List<String> filePaths,
//           ) async {
//         for (var path in filePaths) {
//           final file = File(path);
//           if (file.existsSync()) {
//             request.files.add(
//               await http.MultipartFile.fromPath("$key[]", file.path),
//             );
//             print("✅ FILE UPLOADED: $key => ${file.path}");
//           } else {
//             print("❌ FILE NOT FOUND: ${file.path}");
//           }
//         }
//       }
//
//       // ✅ ✅ ✅ REAL IMAGE UPLOADS (NOT JUST FILENAMES)
//       print("🔹 Uploading image files...");
//
//       await addFileArray(request, "center_entrances", center.centerEntrances);
//       await addFileArray(request, "lab_photos", center.labPhotos);
//       await addFileArray(request, "main_gate_images", center.mainGateImages);
//       await addFileArray(request, "server_room_images", center.serverRoomImages);
//       await addFileArray(
//           request, "observer_room_images", center.observerRoomImages);
//       await addFileArray(
//           request, "ups_generator_images", center.upsGeneratorImages);
//
//       print("🔹 Sending request to API...");
//       var response = await request.send();
//
//       print("🔹 Response received, reading body...");
//       var responseBody = await response.stream.bytesToString();
//
//       print("✅ STATUS CODE: ${response.statusCode}");
//       print("✅ RAW RESPONSE BODY: $responseBody");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(responseBody);
//         print("🔹 Parsed JSON Response: $data");
//
//         if (data['status'] == 'success') {
//
//           Get.to(MainScreen());
//
//           print("✅ API call successful!");
//
//
//           return data;
//         } else {
//           print("❌ API returned failure: ${data['message'] ?? 'Unknown error'}");
//           return null;
//         }
//       }
//       else {
//         print("❌ HTTP ERROR: ${response.statusCode} => $responseBody");
//         return null;
//       }
//     } catch (e, stack) {
//       print("❌ EXCEPTION OCCURRED: $e");
//       print("StackTrace: $stack");
//       return null;
//     }
//   }
// }



import 'dart:convert';
import 'dart:io';
import 'package:bmtc_app/app/screens/auth_pages/main_page/main_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/examCenter_Model.dart';
import '../utils/toast_message.dart';

class ExamCenterService {
  static Future<Map<String, dynamic>?> storeExamCenter(ExamCenter center) async {
    const String url =
        "http://staging.bookmytestcenter.com/api/api/v1/store-exam-center";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.headers.addAll({"Accept": "application/json"});

      // Normal fields
      center.toJson().forEach((key, value) {
        if (value != null && value is! List) {
          request.fields[key] = value.toString();
        }
      });

      // Array fields helper
      void addArray(String key, List list) {
        for (var item in list) {
          request.fields["$key[]"] = item.toString();
        }
      }

      addArray("floor_number", center.floorNumber);
      addArray("total_computers", center.totalComputers);
      addArray("window_generation", center.windowGeneration);
      addArray("monitor_type", center.monitorType);
      addArray("operating_system", center.operatingSystem);
      addArray("ram", center.ram);
      addArray("hdd", center.hdd);
      addArray("ethernet_company", center.ethernetCompany);
      addArray("switch_category", center.switchCategory);
      addArray("no_of_each_ethernet_ports", center.noOfEachEthernetPorts);

      request.fields["partition_in_each_lab"] = center.partitionInEachLab.toString();
      request.fields["ac_in_each_lab"] = center.acInEachLab.toString();
      request.fields["how_many_fire_extinguisher_in_each_lab"] =
          center.howManyFireExtinguisherInEachLab.toString();

      // File uploads helper
      Future<void> addFileArray(
          http.MultipartRequest request, String key, List<String> filePaths) async {
        for (var path in filePaths) {
          final file = File(path);
          if (file.existsSync()) {
            request.files.add(await http.MultipartFile.fromPath("$key[]", file.path));
          }
        }
      }

      await addFileArray(request, "center_entrances", center.centerEntrances);
      await addFileArray(request, "lab_photos", center.labPhotos);
      await addFileArray(request, "main_gate_images", center.mainGateImages);
      await addFileArray(request, "server_room_images", center.serverRoomImages);
      await addFileArray(request, "observer_room_images", center.observerRoomImages);
      await addFileArray(request, "ups_generator_images", center.upsGeneratorImages);

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(responseBody);

        if (data['status'] == 'success') {
          // ✅ Save mobile, OTP, and MPIN in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('mobile_phone', center.mobilePhone);
          await prefs.setString('otp', center.otp);
          await prefs.setString('mpin', center.mpin);

          // ✅ Navigate to MainScreen
          Get.to(MainScreen());

          // ✅ Show success toast
          AppToast.showSuccess(Get.context!, "Center submitted successfully!");

          return data;
        } else {
          AppToast.showError(Get.context!, data['message'] ?? 'Unknown error');
          return null;
        }
      } else {
        AppToast.showError(Get.context!, "HTTP ERROR: ${response.statusCode}");
        return null;
      }
    } catch (e, stack) {
      AppToast.showError(Get.context!, "Exception occurred: $e");
      return null;
    }
  }
}
