import 'package:bmtc_app/app/screens/add_center_pages/center_details_page3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_colors.dart';
import '../../core/text_style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../utils/toast_message.dart';

class CenterDetailsPage2 extends StatefulWidget {
  const CenterDetailsPage2({super.key});

  @override
  State<CenterDetailsPage2> createState() => _CenterDetailsPage2State();
}

class _CenterDetailsPage2State extends State<CenterDetailsPage2> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController(); // (unused – agar nahi chahiye to hata sakte ho)
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController altPhoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController phone2Controller = TextEditingController();
  final TextEditingController name2Controller = TextEditingController();
  final TextEditingController email2Controller = TextEditingController();

  final TextEditingController phone3Controller = TextEditingController();
  final TextEditingController name3Controller = TextEditingController();
  final TextEditingController email3Controller = TextEditingController();

  final TextEditingController phone4Controller = TextEditingController();
  final TextEditingController landLineController = TextEditingController();

  final TextEditingController phone5Controller = TextEditingController(); // (unused)
  final TextEditingController name5Controller = TextEditingController();  // (unused)
  final TextEditingController email5Controller = TextEditingController(); // (unused)

  @override
  void dispose() {
    nameController.dispose();
    designationController.dispose();
    phoneController.dispose();
    altPhoneController.dispose();
    emailController.dispose();

    phone2Controller.dispose();
    name2Controller.dispose();
    email2Controller.dispose();

    phone3Controller.dispose();
    name3Controller.dispose();
    email3Controller.dispose();

    phone4Controller.dispose();
    landLineController.dispose();

    phone5Controller.dispose();
    name5Controller.dispose();
    email5Controller.dispose();

    super.dispose();
  }

  bool _isValidPhone(String value) {
    final trimmed = value.trim();
    return trimmed.length == 10 && int.tryParse(trimmed) != null;
  }

  bool _isValidEmail(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    if (!trimmed.contains("@")) return false;
    if (!trimmed.endsWith("@gmail.com")) return false; // simple gmail check
    return true;
  }

  // void _validateAndNext() {
  //   // 🔹 Point of Contact
  //   if (nameController.text.trim().isEmpty) {
  //     AppToast.showError(context, "Please enter Point of Contact Name");
  //     return;
  //   }
  //
  //   if (!_isValidPhone(phoneController.text)) {
  //     AppToast.showError(context, "Please enter valid 10 digit Phone Number");
  //     return;
  //   }
  //
  //   if (altPhoneController.text.trim().isNotEmpty &&
  //       !_isValidPhone(altPhoneController.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid 10 digit Alternate Phone Number");
  //     return;
  //   }
  //
  //   if (!_isValidEmail(emailController.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid Email (e.g. example@gmail.com)");
  //     return;
  //   }
  //
  //   // 🔹 Center Superintendent details
  //   if (name2Controller.text.trim().isEmpty) {
  //     AppToast.showError(context, "Please enter Superintendent Name");
  //     return;
  //   }
  //
  //   if (!_isValidPhone(phone2Controller.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid 10 digit Superintendent Phone Number");
  //     return;
  //   }
  //
  //   if (!_isValidEmail(email2Controller.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid Superintendent Email (@gmail.com)");
  //     return;
  //   }
  //
  //   // 🔹 IT Manager details
  //   if (name3Controller.text.trim().isEmpty) {
  //     AppToast.showError(context, "Please enter IT Manager Name");
  //     return;
  //   }
  //
  //   if (!_isValidPhone(phone3Controller.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid 10 digit IT Manager Phone Number");
  //     return;
  //   }
  //
  //   if (!_isValidEmail(email3Controller.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid IT Manager Email (@gmail.com)");
  //     return;
  //   }
  //
  //   // 🔹 Emergency Contact numbers
  //   if (!_isValidPhone(phone4Controller.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid 10 digit Emergency Phone Number");
  //     return;
  //   }
  //
  //   if (landLineController.text.trim().isNotEmpty &&
  //       !_isValidPhone(landLineController.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid 10 digit Alternate Emergency Number");
  //     return;
  //   }
  //
  //   // ✅ All good
  //   AppToast.showSuccess(context, "All contact details validated");
  //   Get.to(() => const CenterDetailsPage3());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                // 🔹 Top Step Heading
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        "Step 2",
                        style: AppTextStyles.bodyStepText,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Center Administration details",
                        style: AppTextStyles.centerDetailsTopTitle,
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Please enter the details of the points of contact at the center",
                          style: AppTextStyles.centerSubTitle,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 21),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Point of Contact",
                        style: GoogleFonts.karla(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text("Name", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.text,
                        controller: nameController,
                      ),
                      const SizedBox(height: 14),

                      Text("Phone Number", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                      ),

                      const SizedBox(height: 14),

                      Text("Alternate Phone Number",
                          style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.number,
                        controller: altPhoneController,
                      ),

                      const SizedBox(height: 14),

                      Text("Email Address", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                      ),

                      const SizedBox(height: 14),

                      Text(
                        "Center Superintendent details",
                        style: GoogleFonts.karla(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text("Name", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.text,
                        controller: name2Controller,
                      ),

                      const SizedBox(height: 14),
                      Text("Phone Number", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.number,
                        controller: phone2Controller,
                      ),
                      const SizedBox(height: 14),

                      Text("Email Address", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.emailAddress,
                        controller: email2Controller,
                      ),

                      const SizedBox(height: 16),

                      Text(
                        "IT Manager details",
                        style: GoogleFonts.karla(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text("Name", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.text,
                        controller: name3Controller,
                      ),

                      const SizedBox(height: 14),

                      Text("Phone Number", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.number,
                        controller: phone3Controller,
                      ),

                      const SizedBox(height: 14),

                      Text("Email Address", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.emailAddress,
                        controller: email3Controller,
                      ),

                      const SizedBox(height: 16),

                      Text(
                        "Emergency Contact number of the Center",
                        style: GoogleFonts.karla(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Phone Number", style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.number,
                        controller: phone4Controller,
                      ),
                      const SizedBox(height: 14),
                      Text("Alternate Phone Number",
                          style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      AppTextField(
                        label: "",
                        hintText: "",
                        keyboardType: TextInputType.number,
                        controller: landLineController,
                      ),

                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                           child: GestureDetector(
                             onTap: (){
                               Get.back();
                             },
                             child: Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(color: Color(0xffDDDDDD))
                               ),
                               height: 48,
                               width: double.infinity,
                               child: Align(
                                 alignment: Alignment.center,
                                 child: Text(
                                   textAlign: TextAlign.center,
                                   "Go Back",style: AppTextStyles.centerText,),
                               ),
                             ),
                           ),
                          ),
                          SizedBox(width: 26,),
                          Expanded(
                            flex: 2,
                            child: CustomPrimaryButton(
                              icon: Icons.arrow_right_alt_rounded,
                              text: "Next",
                              onPressed: (){
                                Get.to(() => const CenterDetailsPage3());
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
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
