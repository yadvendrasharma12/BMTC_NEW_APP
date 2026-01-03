import 'dart:convert';

import 'package:bmtc_app/app/screens/auth_pages/forget/create_mpin_screen.dart';
import 'package:bmtc_app/app/screens/auth_pages/forget/forget_otp_screen.dart';
import 'package:bmtc_app/app/screens/home/dashboard_page/dashBoard_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../screens/auth_pages/Mpin/mpin_screen.dart';
import '../screens/auth_pages/login/login_screen.dart';
import '../utils/api_ends_points.dart';
import '../utils/toast_message.dart';
import '../utils/shared_preferances.dart';


class AuthController extends GetxController {
  var isLoading = false.obs;
  String? tempMobilePhone;

  Future<void> login({
    required BuildContext context,
    required String mobilePhone,
    required String mpin,
    String countryCode = "+91",
  }) async {
    print("=== LOGIN START ===");
    if (mobilePhone.isEmpty || mpin.isEmpty) {
      AppToast.showError(context, "Please enter phone and MPIN");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        body: {
          "mobile_phone": mobilePhone,
          "mpin": mpin,
          "country_code": countryCode,
        },
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);

        if (data["status"] == "success") {

          final centerId = data["data"]?["center_id"]?.toString() ?? '';
          if (centerId.isNotEmpty) {
            await MySharedPrefs.save(centerId);
            print("✅ CenterId saved: $centerId");
          }


          await MySharedPrefs.saveLoginData(
            mobilePhone: mobilePhone,
            mpin: mpin,
          );
          final savedData = await MySharedPrefs.getLoginData();
          final savedCenterId = await MySharedPrefs.get();

          debugPrint("=== AFTER LOGIN SAVED DATA ===");
          debugPrint("CenterId: $savedCenterId");
          debugPrint("LoginData: $savedData");
          debugPrint("=============================");
          AppToast.showSuccess(context, data["message"] ?? "Login successful");


            Get.offAll(() => DashboardPageScreen());

        } else {
          AppToast.showError(context, data["message"] ?? "Login failed");
        }
      } else {
        AppToast.showError(context, "Server error: ${response.statusCode}");
      }
    } catch (e) {
      AppToast.showError(context, "Something went wrong: $e");
    } finally {
      isLoading.value = false;
      print("=== LOGIN END ===");
    }
  }


  // Future<void> sendOtp({
  //   required BuildContext context,
  //   required String mobilePhone,
  // }) async {
  //   print("=== SEND OTP START ===");
  //   print("Mobile: $mobilePhone");
  //
  //   if (mobilePhone.isEmpty) {
  //     AppToast.showError(context, "Please enter mobile number");
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(ApiEndpoints.sendOtp),
  //       body: {
  //         "mobile_phone": mobilePhone,
  //         "country_code": "+91",
  //       },
  //     );
  //
  //     print("Status Code: ${response.statusCode}");
  //     print("Response Body: ${response.body}");
  //
  //     final data = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && data["status"] == "success") {
  //
  //
  //       AppToast.showSuccess(context, data["message"] ?? "OTP Sent");
  //
  //       Get.to(() => const ForgetOtpScreen());
  //     } else {
  //       AppToast.showError(context, data["message"] ?? "OTP failed");
  //     }
  //   } catch (e) {
  //     print("OTP ERROR: $e");
  //     AppToast.showError(context, "Server error: $e");
  //   } finally {
  //     isLoading.value = false;
  //     print("=== SEND OTP END ===");
  //   }
  // }


  Future<void> sendOtp({
    required BuildContext context,
    required String mobilePhone,
  }) async {

    if (mobilePhone.isEmpty) {
      AppToast.showError(context, "Please enter mobile number");
      return;
    }

    tempMobilePhone = mobilePhone;

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.sendOtp),
        body: {
          "mobile_phone": mobilePhone,
          "country_code": "+91",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == "success") {
        AppToast.showSuccess(context, "OTP Sent");

        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");


        Get.to(() => const ForgetOtpScreen());
      } else {
        AppToast.showError(context, data["message"]);
      }
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> verifyOtp({
    required BuildContext context,
    required String otp,
  }) async {
    print("=== VERIFY OTP START ===");
    print("OTP: $otp");

    if (otp.isEmpty) {
      AppToast.showError(context, "Please enter OTP");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(

        Uri.parse(ApiEndpoints.verifyOtp),
        body: {
          "otp": otp,
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == "success") {
        AppToast.showSuccess(context, data["message"] ?? "OTP Verified Successfully");
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        Get.to(() => CreateMpinScreen());
      } else {
        AppToast.showError(context, data["message"] ?? "Invalid OTP");
      }
    } catch (e) {
      print("VERIFY OTP ERROR: $e");
      AppToast.showError(context, "Server error: $e");
    } finally {
      isLoading.value = false;
      print("=== VERIFY OTP END ===");
    }
  }



  Future<void> resendOtp({
    required BuildContext context,
    required String mobile_phone,
  }) async {
    print("=== VERIFY OTP START ===");
    print("OTP: $mobile_phone");

    if (mobile_phone.isEmpty) {
      AppToast.showError(context, "Please enter OTP");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(

        Uri.parse(ApiEndpoints.resendOtp),
        body: {
          "mobile_phone": mobile_phone,
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == "success") {
        AppToast.showSuccess(context, data["message"] ?? "OTP Verified Successfully");


        Get.to(() => const MpinScreen());
      } else {
        AppToast.showError(context, data["message"] ?? "Invalid OTP");
      }
    } catch (e) {
      print("VERIFY OTP ERROR: $e");
      AppToast.showError(context, "Server error: $e");
    } finally {
      isLoading.value = false;
      print("=== VERIFY OTP END ===");
    }
  }

  Future<void> logout() async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.logout),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == "success") {

        // ✅ Toast FIRST
        if (Get.context != null) {
          AppToast.showSuccess(
            Get.context!,
            data["message"] ?? "Logout successful",
          );
        }

        await MySharedPrefs.clearLoginData();
        await MySharedPrefs.clear();

        // ✅ Navigation LAST
        Get.offAll(() => const LoginScreen());

      } else {
        if (Get.context != null) {
          AppToast.showError(Get.context!, "Logout failed");
        }
      }
    } catch (e) {
      if (Get.context != null) {
        AppToast.showError(Get.context!, "Logout error");
      }
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> mPinGenerate({
    required BuildContext context,
    required String mobilePhone,
    required String mpin,
    String countryCode = "+91",
  }) async {
    print("=== MPIN GENERATE START ===");
    print("Mobile: $mobilePhone | MPIN: $mpin | Country: $countryCode");

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.mPinGenerate),

        body: {
          "mobile_phone": mobilePhone,
          "country_code": countryCode,
          "mpin": mpin,
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      final bool isSuccess =
          data["status"] == true || data["status"] == "success";

      if (response.statusCode == 200 && isSuccess) {
        AppToast.showSuccess(
          context,
          data["message"] ?? "MPIN Created Successfully",
        );

        Get.offAll(() => LoginScreen());
      } else {
        AppToast.showError(
          context,
          data["message"] ?? "MPIN creation failed",
        );
      }
    } catch (e) {
      print("MPIN API ERROR: $e");
      AppToast.showError(context, "Server error");
    } finally {
      isLoading.value = false;
      print("=== MPIN GENERATE END ===");
    }
  }


  Future<void> checkPhoneExistsAndLogin({
    required BuildContext context,
    required String mobilePhone,
    required String mpin,
    String countryCode = "+91",
  }) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.checkPhone),
        body: {
          "mobile_phone": mobilePhone,
        },
      );

      print("CHECK PHONE STATUS: ${response.statusCode}");
      print("CHECK PHONE BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == "success") {
        if (data["exists"] == true) {
          // ✅ User exists → LOGIN CALL
          await login(
            context: context,
            mobilePhone: mobilePhone,
            mpin: mpin,
            countryCode: countryCode,
          );
        } else {
          // ❌ User does NOT exist
          AppToast.showError(context, "User does not exist");
        }
      } else {
        AppToast.showError(context, "Something went wrong");
      }
    } catch (e) {
      print("CHECK PHONE ERROR: $e");
      AppToast.showError(context, "Server error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAccount({required BuildContext context}) async {
    isLoading.value = true;

    try {
      final String? centerId = await MySharedPrefs.get();
      final loginData = await MySharedPrefs.getLoginData();

      final String? mobilePhone = loginData['mobile_phone'];
      final String? mpin = loginData['mpin'];

      /// 🔍 DEBUG LOGS
      debugPrint("=== DELETE ACCOUNT DEBUG ===");
      debugPrint("CenterId: $centerId");
      debugPrint("Mobile: $mobilePhone");
      debugPrint("MPIN: $mpin");
      debugPrint("===========================");

      if (centerId == null || centerId.isEmpty) {
        AppToast.showError(context, "Center ID missing");
        return;
      }

      if (mpin == null || mpin.isEmpty) {
        AppToast.showError(context, "MPIN missing");
        return;
      }

      final response = await http.post(
        Uri.parse(ApiEndpoints.deleteAccount),
        body: {
          "mobile_phone": mobilePhone,
          "center_id": centerId,
          "mpin": mpin, // ✅ only required fields
        },
      );

      debugPrint("Delete API Status: ${response.statusCode}");
      debugPrint("Delete API Response: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == true) {
        await MySharedPrefs.clearLoginData();
        await MySharedPrefs.clear();

        Get.offAll(() => const LoginScreen());

        AppToast.showSuccess(
          context,
          data["message"] ?? "Account Deleted Successfully",
        );
      } else {
        AppToast.showError(
          context,
          data["message"] ?? "Failed to delete account",
        );
      }
    } catch (e) {
      debugPrint("DELETE ACCOUNT ERROR: $e");
      AppToast.showError(context, "Server error");
    } finally {
      isLoading.value = false;
    }
  }




}