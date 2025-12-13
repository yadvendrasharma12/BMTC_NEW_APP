import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';
import '../utils/toast_message.dart';



int? latestBookingId;

Future<int?> createSelfBooking({
  required BuildContext context,
  required String startDate,
  required String endDate,
  required String clientName,
  required String clientEmail,
  required String clientPhone,
  required String examName,
  required String examType,
  required String examLocation,
  required String examDuration,
  required String seatsBooked,
  required String labsAssigned,
  required int examBatch,
  required List<String> batchTimings,
}) async {
  print("🟦 ---------------- CREATE SELF BOOKING START ----------------");

  try {
    String? centerId = await MySharedPrefs.get();
    print("🔵 Center ID from SharedPrefs = $centerId");

    if (centerId == null || centerId.isEmpty) {
      print("❌ Center ID Not Found!");
      AppToast.showError(context, "Center ID not found!");
      return null;
    }

    final url = Uri.parse("${ApiEndpoints.baseUrl}/self-booking/create");
    print("🌐 API URL = $url");

    final body = {
      "center_id": centerId,
      "start_date": startDate,
      "end_date": endDate,
      "client_name": clientName,
      "client_email": clientEmail,
      "client_phone": clientPhone,
      "exam_name": examName,
      "exam_type": examType,
      "exam_location": examLocation,
      "exam_duration": examDuration,
      "seats_booked": seatsBooked,
      "labs_assigned": labsAssigned,
      "exam_batch": examBatch.toString(),
    };

    for (int i = 0; i < batchTimings.length; i++) {
      body["batch${i + 1}"] = batchTimings[i];
    }

    print("📤 FINAL REQUEST BODY = ${jsonEncode(body)}");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("📥 API STATUS CODE = ${response.statusCode}");
    print("📥 RAW RESPONSE = ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      print("📦 JSON DECODED = $jsonResponse");
      print("🟢 API Status: ${jsonResponse["status"]}");
      print("🟢 API Message: ${jsonResponse["message"]}");

      if (jsonResponse["status"] == "success") {
        // ✅ Save booking ID in global variable
        latestBookingId = jsonResponse["booking_id"];
        print("🎯 BOOKING ID RECEIVED & SAVED = $latestBookingId");

        AppToast.showSuccess(
            context,
            jsonResponse["message"] ?? "Booking created successfully!"
        );

        return latestBookingId;
      } else {
        print("❌ API Failed Message: ${jsonResponse["message"]}");
        AppToast.showError(context, jsonResponse["message"] ?? "Failed to create booking!");
        return null;
      }
    } else {
      print("❌ HTTP Error Code: ${response.statusCode}");
      AppToast.showError(context, "HTTP Error: ${response.statusCode}");
      return null;
    }

  } catch (e) {
    print("🔥 EXCEPTION: $e");
    AppToast.showError(context, "Exception: $e");
    return null;
  }
}



