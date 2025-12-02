
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';

class AuthService {


  static Future<bool> logout() async {
    try {
      final token = await LocalStorage.getToken();
      if (token == null) return false;

      final response = await http.get(
        Uri.parse(ApiEndpoints.logout),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response.body);
        print(response.statusCode);
        if (data['status'] == "success") {
          await LocalStorage.clearAll();
          Get.snackbar("Success", data['message']);
          return true;
        }
      } else {
        Get.snackbar("Error", "Failed to logout");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      return false;
    }
    return false;
  }

// You can add login, register, forgot password API here
}
