// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../utils/api_ends_points.dart';
// import '../utils/shared_preferances.dart';
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
//   List<String> calendarDates = [];
//
//   /// Message for popup (exam / no exam)
//   var dateMessage = "".obs;
//
//   /// -------------------------------
//   /// FETCH MONTH CALENDAR
//   /// -------------------------------
//   Future<void> fetchCalendar({required int month, required int year}) async {
//     isLoading.value = true;
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
//       final uri = Uri.parse(
//           "${ApiEndpoints.calendar}?center_id=$centerId&month=$month&year=$year");
//
//       final response = await http.post(uri);
//
//       if (response.statusCode == 200) {
//         calendarData.value = jsonDecode(response.body);
//         print("✅ Calendar Loaded");
//       } else {
//         print("❌ Calendar API failed");
//       }
//     } catch (e) {
//       print("❌ Exception Calendar API: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// -----------------------------------------------------
//   /// FETCH BOOKING DETAILS FOR SELECTED DATE (NEW API CALL)
//   /// -----------------------------------------------------
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
//       String date = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
//
//       final url =
//           "http://staging.bookmytestcenter.com/api/api/v1/get-booking-details?center_id=$centerId&date=$date";
//
//       print("📌 Booking API URL: $url");
//
//       final response = await http.post(Uri.parse(url));
//
//       print("📌 Booking Details Status: ${response.statusCode}");
//
//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);
//
//         if (decoded["status"] == true) {
//           selectedDateExams.value = decoded["data"] ?? [];
//
//           if (selectedDateExams.isEmpty) {
//             dateMessage.value = "No exam scheduled for this date";
//           } else {
//             dateMessage.value = "Exam details loaded";
//           }
//
//           print("✅ Booking Data Loaded: ${selectedDateExams.length}");
//         } else {
//           selectedDateExams.clear();
//           dateMessage.value = "No exam scheduled for this date";
//         }
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
//   /// -----------------------------------------------------
//   void onDateSelected(DateTime date) {
//     print("📌 Selected Date: $date");
//
//     /// Call booking API
//     fetchBookingDetails(date);
//   }
// }


import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';

class CalendarController extends GetxController {
  var isLoading = false.obs;

  /// Calendar API (month-year)
  var calendarData = {}.obs;

  /// Date wise booking details API
  var selectedDateExams = [].obs;

  /// Message for popup (exam / no exam)
  var dateMessage = "".obs;

  /// List of booked dates for current month
  List<DateTime> bookedDates = [];

  /// -------------------------------
  /// FETCH MONTH CALENDAR & BOOKED DATES
  /// -------------------------------
  Future<void> fetchCalendar({required int month, required int year}) async {
    isLoading.value = true;
    bookedDates.clear();
    print("📅 fetchCalendar -> Month: $month, Year: $year");

    try {
      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) {
        print("❌ Center ID missing");
        isLoading.value = false;
        return;
      }

      /// Loop through all days of month to check booking
      final daysInMonth = DateTime(year, month + 1, 0).day;
      for (int day = 1; day <= daysInMonth; day++) {
        String dateStr =
            "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
        final url =
            "http://staging.bookmytestcenter.com/api/api/v1/get-booking-details?center_id=$centerId&date=$dateStr";
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data["data"] != null && data["data"].length > 0) {
            bookedDates.add(DateTime(year, month, day));
          }
        }
      }

      print("✅ Booked dates loaded: ${bookedDates.length}");
    } catch (e) {
      print("❌ Exception fetching booked dates: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// -----------------------------------------------------
  /// FETCH BOOKING DETAILS FOR SELECTED DATE
  /// -----------------------------------------------------
  Future<void> fetchBookingDetails(DateTime selectedDate) async {
    isLoading.value = true;

    try {
      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) {
        print("❌ No center ID");
        return;
      }

      String date =
          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

      final url =
          "http://staging.bookmytestcenter.com/api/api/v1/get-booking-details?center_id=$centerId&date=$date";

      print("📌 Booking API URL: $url");

      final response = await http.get(Uri.parse(url));
      print("📌 Booking Details Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded["data"] != null && decoded["data"].length > 0) {
          selectedDateExams.value =
          List<Map<String, dynamic>>.from(decoded["data"]);
          dateMessage.value = "Exam details loaded";
        } else {
          selectedDateExams.clear();
          dateMessage.value = "No exam scheduled for this date";
        }

        print("✅ Booking Data Loaded: ${selectedDateExams.length}");
      } else {
        selectedDateExams.clear();
        dateMessage.value = "No exam scheduled for this date";
      }
    } catch (e) {
      print("❌ Booking API Exception: $e");
      selectedDateExams.clear();
      dateMessage.value = "No exam scheduled for this date";
    } finally {
      isLoading.value = false;
    }
  }

  /// -----------------------------------------------------
  /// HANDLE DATE SELECT → CALL BOOKING API AUTOMATICALLY
  /// -----------------------------------------------------
  void onDateSelected(DateTime date) {
    print("📌 Selected Date: $date");
    fetchBookingDetails(date);
  }
}
