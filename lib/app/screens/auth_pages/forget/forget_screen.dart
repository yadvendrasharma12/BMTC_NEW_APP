
import 'dart:async';

import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/screens/auth_pages/forget/forget_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/text_style.dart';
import '../../../utils/toast_message.dart';
import '../../../utils/validators.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../otp/otp_screen.dart';
import '../register/register_screen.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController;
  String currentText = "";

  String _selectedCountryCode = '+91';
  bool _agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    errorController.close();
    super.dispose();
  }

  void _onSignUp() {
    final phoneError = Validators.phone(_phoneController.text);

    if (phoneError != null) {
      AppToast.showError(context, phoneError);
      return;
    }

    _formKey.currentState?.validate();
    AppToast.showSuccess(context, 'OTP sent successful!');

    Get.to(
          () => ForgetOtpScreen(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Welcome to BookMyTestCenter",),
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

                const SizedBox(height: 24),
                Text("Reset/Forget MpIN",style: AppTextStyles.topHeading1,),
                const SizedBox(height: 6),
                Text("Enter your registered phone number", style: AppTextStyles.topHeading3),
                const SizedBox(height: 24),

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

                const SizedBox(height: 24),

                CustomPrimaryButton(
                  text: "Send OTP",
                  icon: Icons.arrow_right_alt_rounded,
                  onPressed: () =>_onSignUp(),
                ),
                const SizedBox(height: 24),

                CustomPrimaryButton(
                  text: "Back To Login",
                  icon: Icons.arrow_right_alt_rounded,
                  onPressed: () =>Get.back(),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
