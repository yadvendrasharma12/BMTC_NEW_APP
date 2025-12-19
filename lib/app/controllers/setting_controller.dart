import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/setting_response.dart';
import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';


class SettingsController extends GetxController {
  var isLoading = false.obs;
  var settingsData = Rxn<SettingsData>();

  /// ===============================
  /// 🔹 FETCH SETTINGS (GET)
  /// ===============================
  Future<void> fetchSettings() async {
    isLoading.value = true;

    try {
      String? centerId = await MySharedPrefs.get();

      if (centerId == null || centerId.isEmpty) {
        print("❌ Center ID missing");
        isLoading.value = false;
        return;
      }

      final url =
          "${ApiEndpoints.settings}?center_id=$centerId";

      print("📌 SETTINGS GET URL: $url");

      final response = await http.get(Uri.parse(url));

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded["status"] == true) {
          final model = SettingsResponse.fromJson(decoded);
          settingsData.value = model.data;
          print("✅ Settings loaded successfully");
        } else {
          print("❌ API status false");
        }
      } else {
        print("❌ Settings API failed");
      }
    } catch (e) {
      print("❌ SETTINGS EXCEPTION: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ===============================
  /// 🔹 UPDATE SETTINGS (POST)
  /// ===============================
  Future<bool> updateSettings({
    required String name,
    required String email,
    required String phone,
  }) async {
    isLoading.value = true;

    try {
      String? centerId = await MySharedPrefs.get();

      if (centerId == null || centerId.isEmpty) {
        print("❌ Center ID missing");
        return false;
      }

      final url = ApiEndpoints.updateSettings;

      final body = {
        "center_id": centerId,
        "name": name,
        "email": email,
        "mobile_phone": phone,
      };

      print("📌 UPDATE SETTINGS URL: $url");
      print("📤 REQUEST BODY: $body");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded["status"] == true) {
          print("✅ Settings updated successfully");
          return true;
        } else {
          print("❌ Update failed: ${decoded["message"]}");
          return false;
        }
      } else {
        print("❌ Update API failed");
        return false;
      }
    } catch (e) {
      print("❌ UPDATE EXCEPTION: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
