

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferances.dart';
//
// class CalendarController extends GetxController {
//   var isLoading = false.obs;
//
//   /// Calendar API (month-year)
//   var calendarData = {}.obs;
//
//   /// Date wise booking details API
//   var selectedDateExams = [].obs;
//
//   /// Message for popup (exam / no exam)
//   var dateMessage = "".obs;
//
//   /// List of booked dates for current month
//   List<DateTime> bookedDates = [];
//
//   /// -------------------------------
//   /// FETCH MONTH CALENDAR & BOOKED DATES
//   /// -------------------------------
//
//   Future<void> fetchCalendar({required int month, required int year}) async {
//     isLoading.value = true;
//     bookedDates.clear();
//     print("📅 fetchCalendar -> Month: $month, Year: $year");
//
//     try {
//       String? centerId = await MySharedPrefs.get();
//       if (centerId == null || centerId.isEmpty) {
//         print("❌ Center ID missing");
//         isLoading.value = false;
//         return;
//       }
//
//       /// Loop through all days of month to check booking
//       final daysInMonth = DateTime(year, month + 1, 0).day;
//       for (int day = 1; day <= daysInMonth; day++) {
//         String dateStr =
//             "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
//         final url =
//             "http://staging.bookmytestcenter.com/api/api/v1/get-booking-details?center_id=$centerId&date=$dateStr";
//         final response = await http.get(Uri.parse(url));
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           if (data["data"] != null && data["data"].length > 0) {
//             bookedDates.add(DateTime(year, month, day));
//           }
//         }
//       }
//
//       print("✅ Booked dates loaded: ${bookedDates.length}");
//     } catch (e) {
//       print("❌ Exception fetching booked dates: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// -----------------------------------------------------
//   /// FETCH BOOKING DETAILS FOR SELECTED DATE
//   /// -----------------------------------------------------
//
//   Future<void> fetchBookingDetails(DateTime selectedDate) async {
//     isLoading.value = true;
//
//     try {
//       String? centerId = await MySharedPrefs.get();
//       if (centerId == null || centerId.isEmpty) {
//         print("❌ No center ID");
//         return;
//       }
//
//       String date =
//           "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
//
//       final url =
//           "http://staging.bookmytestcenter.com/api/api/v1/get-booking-details?center_id=$centerId&date=$date";
//
//       print("📌 Booking API URL: $url");
//
//       final response = await http.get(Uri.parse(url));
//       print("📌 Booking Details Status: ${response.statusCode}");
//
//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);
//
//         if (decoded["data"] != null && decoded["data"].length > 0) {
//           selectedDateExams.value =
//           List<Map<String, dynamic>>.from(decoded["data"]);
//           dateMessage.value = "Exam details loaded";
//         } else {
//           selectedDateExams.clear();
//           dateMessage.value = "No exam scheduled for this date";
//         }
//
//         print("✅ Booking Data Loaded: ${selectedDateExams.length}");
//       } else {
//         selectedDateExams.clear();
//         dateMessage.value = "No exam scheduled for this date";
//       }
//     } catch (e) {
//       print("❌ Booking API Exception: $e");
//       selectedDateExams.clear();
//       dateMessage.value = "No exam scheduled for this date";
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// -----------------------------------------------------
//   /// HANDLE DATE SELECT → CALL BOOKING API AUTOMATICALLY
//
//
//   void onDateSelected(DateTime date) {
//     if (kDebugMode) {
//       print("📌 Selected Date: $date");
//     }
//     fetchBookingDetails(date);
//   }
// }


class CalendarController extends GetxController {
  /// UI loader
  var isLoading = false.obs;

  /// Background booked dates loader
  var isBookedDatesLoading = false.obs;

  /// Booking popup loader
  var isBookingLoading = false.obs;

  /// 🔥 MUST BE RxList
  RxList<DateTime> bookedDates = <DateTime>[].obs;

  var selectedDateExams = <Map<String, dynamic>>[].obs;
  var dateMessage = "".obs;

  /// -------------------------------
  /// CALENDAR LOAD
  /// -------------------------------
  Future<void> fetchCalendar({
    required int month,
    required int year,
  }) async {
    isLoading.value = true;

    // Minimum loader time
    await Future.delayed(const Duration(seconds: 3));

    try {
      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) return;

      /// background load
      fetchBookedDates(month: month, year: year);
    } catch (e) {
      print("❌ Calendar error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// -------------------------------
  /// BOOKED DATES (BACKGROUND)
  /// -------------------------------
  Future<void> fetchBookedDates({
    required int month,
    required int year,
  }) async {
    isBookedDatesLoading.value = true;
    bookedDates.clear();

    try {
      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) return;

      final daysInMonth = DateTime(year, month + 1, 0).day;
      List<Future> calls = [];

      for (int day = 1; day <= daysInMonth; day++) {
        final date =
            "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";

        calls.add(
          http.get(Uri.parse(
              "http://staging.bookmytestcenter.com/api/api/v1/get-booking-details?center_id=$centerId&date=$date"))
              .then((res) {
            if (res.statusCode == 200) {
              final decoded = jsonDecode(res.body);
              if (decoded["data"] != null &&
                  decoded["data"].isNotEmpty) {
                bookedDates.add(DateTime(year, month, day));
              }
            }
          }),
        );
      }

      await Future.wait(calls);

      /// 🔥 FORCE UI UPDATE
      bookedDates.refresh();

      print("✅ Booked dates loaded: ${bookedDates.length}");
    } catch (e) {
      print("❌ Booked dates error: $e");
    } finally {
      isBookedDatesLoading.value = false;
    }
  }

  /// -------------------------------
  /// DATE CLICK → BOOKING DETAILS
  /// -------------------------------
  Future<void> fetchBookingDetails(DateTime date) async {
    isLoading.value = true;

    isBookingLoading.value = true;
    selectedDateExams.clear();

    try {
      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) return;

      final d =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      final res = await http.get(Uri.parse(
          "http://staging.bookmytestcenter.com/api/api/v1/get-booking-details?center_id=$centerId&date=$d"));

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        if (decoded["data"] != null && decoded["data"].isNotEmpty) {
          selectedDateExams.value =
          List<Map<String, dynamic>>.from(decoded["data"]);
          dateMessage.value = "Exam details loaded";
        } else {
          dateMessage.value = "No exam scheduled";
        }
      }
    } catch (e) {
      dateMessage.value = "No exam scheduled";
    } finally {

      isLoading.value = false;
    }
  }
}

