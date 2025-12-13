import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/view_self_booking.dart';


class ViewSelfBookingController extends GetxController {
  var isLoading = false.obs;
  var bookingList = <BookingData>[].obs;

  /// Fetch booking details by booking ID
  Future<void> fetchBookingById({required String id}) async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
        'http://staging.bookmytestcenter.com/api/api/v1/self-booking/view',
      );

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          'id': id,
          'type': 'self-booking',
        },
      );

      final decoded = json.decode(response.body);
      if (response.statusCode == 200 && decoded['status'] == true && decoded['data'] != null) {
        BookingData booking = BookingData.fromJson(decoded['data']);
        bookingList.removeWhere((b) => b.id == booking.id);
        bookingList.insert(0, booking);
        print("✅ Booking added: ${booking.clientName}");
      } else {
        print("❌ No booking found for this ID: $id");
      }
    } catch (e) {
      print("🔥 Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

}

