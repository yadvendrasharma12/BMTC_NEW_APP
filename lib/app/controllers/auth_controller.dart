import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/toast_message.dart';
import '../utils/shared_preferances.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> login({
    required BuildContext context,
    required String mobilePhone,
    required String mpin,
  }) async {
    if (mobilePhone.isEmpty || mpin.isEmpty) {
      AppToast.showError(context, "Please enter phone and MPIN");
      return;
    }

    isLoading.value = true;

    final url = Uri.parse("http://staging.bookmytestcenter.com/api/api/v1/login");
    final body = jsonEncode({"mobile_phone": mobilePhone, "mpin": mpin});

    print("Login URL: $url");
    print("Request Body: $body");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == "success") {
          AppToast.showSuccess(context, data['message'] ?? "Login successful");
        } else {
          AppToast.showError(context, data['message'] ?? "Login failed");
        }
      } else {
        AppToast.showError(context, "Server error: ${response.statusCode}");

        print(response.statusCode);
      }
    } catch (e) {
      AppToast.showError(context, "Something went wrong: $e");

      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
