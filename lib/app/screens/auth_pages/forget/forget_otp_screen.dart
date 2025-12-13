

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../controllers/auth_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/otp_pin_field.dart';
import '../Mpin/mpin_screen.dart';
import '../login/login_screen.dart';

class ForgetOtpScreen extends StatefulWidget {
  const ForgetOtpScreen({super.key});

  @override
  State<ForgetOtpScreen> createState() => _ForgetOtpScreenState();
}

class _ForgetOtpScreenState extends State<ForgetOtpScreen> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _otpController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  late StreamController<ErrorAnimationType> errorController;
  String currentText = "";

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  void _onVerify() {
    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      errorController.add(ErrorAnimationType.shake);
      AppToast.showError(context, 'Please enter OTP');
      return;
    }

    if (otp.length != 6) {
      errorController.add(ErrorAnimationType.shake);
      AppToast.showError(context, 'OTP must be 6 digits');
      return;
    }

    // ✅ REAL API CALL
    authController.verifyOtp(
      context: context,
      otp: otp,
    );
  }


  @override
  void dispose() {

    errorController.close();
    super.dispose();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Welcome to BookMyTestCenter",),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 0,
            left: 16,
            right: 14,
            bottom: 24,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(
                  child: SizedBox(
                    height: 180,
                    width: 180,
                    child: Image.asset(
                      "assets/logo/BMTCLogo.png",
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  "Reset/Forget Mpin",
                  style: AppTextStyles.topHeading1,
                ),
                const SizedBox(height: 20),
                Text(
                  "Enter the OTP",
                  style: GoogleFonts.karla(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color:  Colors.black,
                  ),
                ),



                const SizedBox(height: 10),
                OtpPinField(
                  controller: _otpController,
                  length: 6,
                  errorController: errorController,
                  onChanged: (value) {},

                ),


                const SizedBox(height: 21),


                Obx(() {
                  return CustomPrimaryButton(
                    text: "Verify OTP",
                    icon: Icons.arrow_right_alt_rounded,
                    isLoading: authController.isLoading.value,
                    onPressed: authController.isLoading.value ? null : _onVerify,
                  );
                }),
                SizedBox(height: 14,),
                CustomPrimaryButton(
                  text: "Back To Previous Page",
                  icon: Icons.arrow_right_alt_rounded,
                  onPressed: () =>_onVerify(),
                ),

                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Incorrect phone number? ",
                        style: GoogleFonts.karla(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xff737373),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => const LoginScreen());
                        },
                        child: Text(
                          "Change",
                          style: AppTextStyles.linkText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
