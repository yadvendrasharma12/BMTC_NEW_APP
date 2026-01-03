import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/self_booking_model.dart';
import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';

class SelfBookingController extends GetxController {
  var isLoading = false.obs;
  var selfBookingModel = Rxn<SelfBookingModel>();
  var selectedBooking = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchSelfBooking();
    print("🔥 SelfBookingController INIT → ${hashCode}");
  }

  /// 👉 Fetch all bookings
  Future<void> fetchSelfBooking() async {
    try {
      isLoading.value = true;
      String? centerId = await MySharedPrefs.get();
      if (centerId == null) {
        print("❌ No center ID found");
        return;
      }

      final url = Uri.parse("${ApiEndpoints.baseUrl}/my-self-booking?center_id=$centerId");
      print("🌍 GET → $url");

      final response = await http.get(url);
      print("📡 Status Code → ${response.statusCode}");
      print("📦 Response → ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse["status"] == true) {
          selfBookingModel.value = SelfBookingModel.fromJson(jsonResponse);
          print("✅ Bookings loaded successfully");
        } else {
          print("❌ API Error → ${jsonResponse["message"]}");
        }
      }
    } catch (e) {
      print("❌ Exception → $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 👉 Update a booking
  Future<void> updateBooking(
      Map<String, dynamic> updatedData) async {
    try {
      isLoading.value = true;

      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) {
        print("❌ Center ID not found in SharedPreferences");
        isLoading.value = false;
        return;
      }

      updatedData['center_id'] = centerId;

      final url = Uri.parse("${ApiEndpoints.baseUrl}/self-booking/update");
      print("🌍 POST → $url");
      print("📦 Payload → $updatedData");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedData),
      );

      print("📡 Status Code → ${response.statusCode}");
      print("📦 Response → ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == "success") {

        Get.snackbar(
          backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,

            "Success", responseData['message'],colorText: Colors.white);
        Get.back(result: true, closeOverlays: true); // ✅ NOW BACK WORKS
        selectedBooking.value = updatedData;

        print("✅ Booking updated successfully");

      } else {
        Get.snackbar("Error", responseData['message'] ?? "Failed to update booking");
        print("❌ Failed to update booking → ${responseData['message']}");
      }
    } catch (e) {
      print("❌ Exception → $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
