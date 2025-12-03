import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:bmtc_app/app/screens/auth_pages/login/login_screen.dart';
import 'package:bmtc_app/app/screens/auth_pages/otp/otp_screen.dart';
import 'package:bmtc_app/app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/center_form_controller.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController  = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ExamCenterController formController = Get.put(ExamCenterController());

  String _selectedCountryCode = '+91';
  bool _agreedToTerms = false;


  bool _isLoading = false;
  void _onSignUp() async {
    final nameError  = Validators.name(_nameController.text);
    final emailError = Validators.email(_emailController.text);
    final phoneError = Validators.phone(_phoneController.text);

    if (nameError != null) {
      AppToast.showError(context, nameError);
      return;
    }
    if (emailError != null) {
      AppToast.showError(context, emailError);
      return;
    }
    if (phoneError != null) {
      AppToast.showError(context, phoneError);
      return;
    }

    if (!_agreedToTerms) {
      AppToast.showError(context, 'Please agree to Terms & Privacy Policy');
      return;
    }

    // ✅ Save data in controller
    formController.name.value = _nameController.text.trim();
    formController.email.value = _emailController.text.trim();
    formController.mobilePhone.value = _phoneController.text.trim();
    formController.countryCode.value = _selectedCountryCode;
    formController.isAgree.value = _agreedToTerms;


    Get.to(() => OtpScreen(
      mobileNumber: formController.mobilePhone.value,
      countryCode: formController.countryCode.value,
      name: formController.name.value,
    ));
  }





  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
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
            right: 16,
            bottom: 24,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: SizedBox(
                    height: 170,
                    width: 170,
                    child: Image.asset(
                      "assets/logo/BMTCLogo.png",
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "Create an account",
                  style: AppTextStyles.topHeading1,
                ),
                const SizedBox(height: 6),

                Text(
                  "You are just a few steps away, please give us your details",
                  style: AppTextStyles.topHeading3,
                ),

                const SizedBox(height: 24),


                AppTextField(
                  controller: _nameController,
                  label: "Full name",
                  hintText: "James Gordon",
                  keyboardType: TextInputType.name,
                  validator: Validators.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z ]")),
                  ],
                ),

                const SizedBox(height: 16),

                AppTextField(
                  controller: _emailController,
                  label: "Email",
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.fillColorFB,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCountryCode,
                          items: const [
                            DropdownMenuItem(
                              value: '+91',
                              child: Text('Ind (+91)'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() => _selectedCountryCode = value);
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: AppTextField(
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
                    ),
                  ],
                ),

                const SizedBox(height: 21),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      activeColor: AppColors.primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -3,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _agreedToTerms = value ?? false;
                        });
                      },
                    ),
                    const SizedBox(width: 4),

                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "I agree to the ",
                            style: GoogleFonts.karla(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Terms & Service",
                              style: AppTextStyles.linkText,
                            ),
                          ),
                          Text(
                            " & ",
                            style: GoogleFonts.karla(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Privacy Policy",
                              style: AppTextStyles.linkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                CustomPrimaryButton(
                  text: "Sign Up",
                  icon: Icons.arrow_right_alt_rounded,
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : _onSignUp,
                ),

                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    children: [
                      Text(
                        "Already have an account?\t",
                        style: GoogleFonts.karla(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff737373),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Text(
                          "Log in",
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
