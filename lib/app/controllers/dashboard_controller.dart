import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/dashboard_modal.dart';
import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs;

  // Initialize with empty DashboardModel
  var dashboardModel = DashboardModel().obs;
  var selectedBooking = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    try {
      isLoading(true);

      // Get centerId from shared preferences
      String? centerId = await MySharedPrefs.get();

      if (centerId == null || centerId.isEmpty) {
        print("❌ Center ID not found in SharedPreferences");
        return;
      }

      print("🔥 DASHBOARD API CALL START");
      print("CENTER ID: $centerId");

      // API URL
      final url = Uri.parse("${ApiEndpoints.baseUrl}/dashboard?center_id=$centerId");

      print("🌍 URL: $url");

      // API CALL
      final response = await http.get(url);

      print("📡 STATUS CODE: ${response.statusCode}");
      print("📦 RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);


        if (jsonData["status"] == true) {
          // Parse full JSON including status and message
          dashboardModel.value = DashboardModel.fromJson(jsonData);
          print("✅ DASHBOARD DATA LOADED");


        } else {
          print("❌ API FAILED: ${jsonData["message"]}");
        }
      } else {
        print("❌ API CALL FAILED: HTTP ${response.statusCode}");
      }
    } catch (e) {
      print("❌ ERROR: $e");
    } finally {
      isLoading(false);
      print("🏁 DASHBOARD API END");
    }
  }
}
