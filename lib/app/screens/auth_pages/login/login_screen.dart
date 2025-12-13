import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../controllers/auth_controller.dart';
import '../../../core/text_style.dart';
import '../../../utils/toast_message.dart';
import '../../../utils/validators.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../../widgets/otp_pin_field.dart';
import '../../auth_pages/forget/forget_screen.dart';
import '../../auth_pages/register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

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

    if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      AppToast.showError(context, "Enter a valid 10-digit phone number");
      return;
    }

    if (mpin.isEmpty || mpin.length != 4) {
      errorController.add(ErrorAnimationType.shake);
      AppToast.showError(context, "Please enter a valid 4-digit MPIN");
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      authController.checkPhoneExistsAndLogin(
        context: context,
        mobilePhone: phone,
        mpin: mpin,
        countryCode: "+91",
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Welcome to BookMyTestCenter"),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text("Welcome back!", style: AppTextStyles.topHeading1, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text("Enter your 4 digit M-Pin to log in", style: AppTextStyles.topHeading2),
                const SizedBox(height: 6),
                Text("Good to see you back", style: AppTextStyles.topHeading3),
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
                const SizedBox(height: 21),
                OtpPinField(
                  controller: _otpController,
                  length: 4,
                  errorController: errorController,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 24),
                Obx(() {
                  return CustomPrimaryButton(
                    text: "Log in",
                    icon: Icons.arrow_right_alt_rounded,
                    isLoading: authController.isLoading.value,
                    onPressed: authController.isLoading.value ? null : _onLogin,
                  );
                }),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: AppTextStyles.linkText),
                      GestureDetector(
                        onTap: () => Get.to(RegisterScreen()),
                        child: Text("Sign up", style: AppTextStyles.linkText),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("Reset/Forget MPIN ", style: AppTextStyles.linkText),
                      GestureDetector(
                        onTap: () => Get.to(ForgetScreen()),
                        child: Text("Go", style: AppTextStyles.linkTexts),
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
