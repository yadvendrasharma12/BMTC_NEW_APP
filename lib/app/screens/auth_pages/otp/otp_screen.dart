import 'dart:async';

import 'package:bmtc_app/app/screens/auth_pages/Mpin/mpin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/otp_pin_field.dart';
import '../login/login_screen.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String countryCode;
  final String name;

  const OtpScreen({
    super.key,
    required this.mobileNumber,
    this.countryCode = '+91', required this.name,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _otpController = TextEditingController();

  // PinCode ke error animation ke liye
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

    _formKey.currentState?.validate();
    AppToast.showSuccess(context, 'Sign in successful!');
    Get.to(MpinScreen());
  }

  @override
  void dispose() {

    errorController.close();
    super.dispose();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fullNumber = '${widget.countryCode} ${widget.mobileNumber}';


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
                  "Verify your phone number, ${widget.name}",
                  style: AppTextStyles.topHeading2,
                ),
                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "We sent a 6 digit OTP to ",
                        style: GoogleFonts.karla(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xff737373),
                        ),
                      ),
                      Text(
                        fullNumber,
                        style: AppTextStyles.linkText,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                OtpPinField(
                  controller: _otpController,
                  length: 6,
                  errorController: errorController,
                  onChanged: (value) {},

                ),
                SizedBox(height: 9,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Text(
                        "Didn't get a code? ",
                        style: GoogleFonts.karla(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xff737373),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Text(
                          "Resend",
                          style: AppTextStyles.linkText,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 21),


                CustomPrimaryButton(
                  text: "Verify OTP",
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
