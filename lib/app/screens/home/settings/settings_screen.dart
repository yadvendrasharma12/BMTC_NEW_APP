import 'dart:io';

import 'package:bmtc_app/app/screens/auth_pages/register/register_screen.dart';
import 'package:bmtc_app/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../services/auth_services.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_textformfield.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Controllers
  final TextEditingController nameController =
  TextEditingController(text: "James Gordon");
  final TextEditingController emailController =
  TextEditingController(text: "james.gordon@testpanindia.com");
  final TextEditingController phoneController =
  TextEditingController(text: "+91 9876543210");

  // Profile image file (gallery se pick)
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfileImage() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  void _onSave() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    debugPrint("Saved: $name | $email | $phone");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.borderColor,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              margin:
              const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.borderColor,
                    backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 28)
                        : null,
                  ),

                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TestPan India',
                        style: AppTextStyles.dashBordButton2,
                      ),
                      Text(
                        nameController.text,
                        style: AppTextStyles.inputHint,
                      ),
                      Text(
                        'India',
                        style: AppTextStyles.inputHint,
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _pickProfileImage,
                    child: Image.asset(
                      "assets/icons/edit.png",
                      height: 36,
                      width: 100,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ],
              ),
            ),

            // PERSONAL INFO
            Container(
              width: double.infinity,
              margin:
              const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: 14),
                  Text("Full Name", style: AppTextStyles.centerText),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    label: '',
                  ),
                  const SizedBox(height: 14),
                  Text("Email", style: AppTextStyles.centerText),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: '',
                  ),
                  const SizedBox(height: 14),
                  Text("Phone Number", style: AppTextStyles.centerText),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: const [],
                    label: '',
                  ),
                ],
              ),
            ),

            // DELETE ACCOUNT BUTTON (simple card)
            Container(
              margin:
              const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TestPan India',
                        style: AppTextStyles.dashBordButton2,
                      ),
                    ],
                  ),
                  const Spacer(),

                  GestureDetector(
                    onTap: () async {
                      bool success = await AuthService.logout();
                      if (success) {
                        AppToast.showSuccess(context, "Logged out successfully");


                        Future.delayed(const Duration(seconds: 1), () {
                          Get.offAll(RegisterScreen());
                        });
                      } else {
                        AppToast.showError(context, "Logout failed. Try again.");
                      }
                    },
                    child: Image.asset(
                      "assets/icons/Delete.png",
                      height: 40,
                      width: 112,
                      filterQuality: FilterQuality.high,
                    ),
                  ),


                ],
              ),
            ),

            // DANGER ZONE
            Container(
              margin:
              const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delete account',
                        style: AppTextStyles.dashBordButton2,
                      ),
                      Text(
                        'This action cannot be undone',
                        style: AppTextStyles.delete,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/logo/Delete.png",
                    height: 40,
                    width: 120,
                    filterQuality: FilterQuality.high,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomPrimaryButton(
                text: "Save",
                onPressed: _onSave,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
