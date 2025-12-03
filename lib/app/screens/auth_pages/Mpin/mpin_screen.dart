
import 'dart:async';

import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page1.dart';
import 'package:bmtc_app/app/screens/auth_pages/main_page/main_screen.dart';
import 'package:bmtc_app/app/screens/auth_pages/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../controllers/center_form_controller.dart';
import '../../../core/text_style.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/otp_pin_field.dart';

class MpinScreen extends StatefulWidget {
  const MpinScreen({super.key});

  @override
  State<MpinScreen> createState() => _MpinScreenState();
}

class _MpinScreenState extends State<MpinScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mPinController = TextEditingController();
  final ExamCenterController formController = Get.find<ExamCenterController>();

  late StreamController<ErrorAnimationType> errorController;
  String currentText = "";

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  void _onVerify() {
    final mpin = _mPinController.text.trim();

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

    _formKey.currentState?.validate();


    formController.mpin.value = mpin;

    AppToast.showSuccess(context, 'MPIN created successfully!');
    Get.off(() => MainScreen());
  }



  @override
  void dispose() {

    errorController.close();
    super.dispose();
    _mPinController.dispose();
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

                const SizedBox(height: 15),

                Text(
                  "Enter MPIN",
                  style: AppTextStyles.topHeading1,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 13),

                Text(
                  "Setup your 4 digit M-Pin",
                  style: AppTextStyles.topHeading2,
                ),
                const SizedBox(height: 6),

                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "The M-Pin will be used for logging in in the future",
                        style: GoogleFonts.karla(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xff737373),
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 24),

                OtpPinField(
                  controller: _mPinController,
                  length: 4,
                  errorController: errorController,
                  onChanged: (value) {},

                ),



            const SizedBox(height: 21),


                CustomPrimaryButton(
                  text: "Create MPIN",
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
                        "Don't have an account? ",
                        style: GoogleFonts.karla(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xff737373),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => RegisterScreen());
                        },
                        child: Text(
                          "Sign up",
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
