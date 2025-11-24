import 'dart:async';
import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page1.dart';
import 'package:bmtc_app/app/screens/auth_pages/forget/forget_screen.dart';
import 'package:bmtc_app/app/screens/auth_pages/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/text_style.dart';
import '../../../widgets/otp_pin_field.dart';
import '../../../utils/toast_message.dart';
import '../../../utils/validators.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    errorController.close();
    super.dispose();
  }


  void _onLogin() {
    final phone = _phoneController.text.trim();
    final mpin = _otpController.text.trim();

    // Phone validation
    final phoneError = Validators.phone(phone);
    if (phoneError != null) {
      AppToast.showError(context, phoneError);
      return;
    }

    // MPIN validation
    if (mpin.isEmpty) {
      errorController.add(ErrorAnimationType.shake);
      AppToast.showError(context, 'Please enter your MPIN');
      return;
    }

    if (mpin.length != 4) {
      errorController.add(ErrorAnimationType.shake);
      AppToast.showError(context, 'MPIN must be 4 digits');
      return;
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    AppToast.showSuccess(context, 'OTP/MPIN valid!');
    Get.to(CenterDetailsPage1());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Welcome to BookMyTestCenter"),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Title
                Text(
                  "Welcome back!",
                  style: AppTextStyles.topHeading1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Enter your 4 digit M-Pin to log in",
                  style: AppTextStyles.topHeading2,
                ),
                const SizedBox(height: 6),
                Text(
                  "Good to see you back",
                  style: AppTextStyles.topHeading3,
                ),
                const SizedBox(height: 24),

                // Phone input
                AppTextField(
                  controller: _phoneController,
                  label: "Phone number",
                  hintText: "Enter your phone number",
                  keyboardType: TextInputType.phone,
                  validator: Validators.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(height: 12),


                OtpPinField(
                  controller: _otpController,
                  length: 4,
                  errorController: errorController,
                  onChanged: (value) {},

                ),
                const SizedBox(height: 24),


                CustomPrimaryButton(
                  text: "Log in",
                  icon: Icons.arrow_right_alt_rounded,
                  onPressed: _onLogin,
                ),

                const SizedBox(height: 15),

                // Sign Up
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.karla(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xff737373),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(RegisterScreen());
                        },
                        child: Text("Sign up", style: AppTextStyles.linkText),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Reset/Forget MPIN
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Reset/Forget MPIN ",
                        style: GoogleFonts.karla(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xff737373),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(ForgetScreen());
                        },
                        child: Text("Go", style: AppTextStyles.linkText),
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
