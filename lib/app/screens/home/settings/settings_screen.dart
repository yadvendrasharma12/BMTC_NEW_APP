import 'dart:io';

import 'package:bmtc_app/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/setting_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../utils/shared_preferances.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  final SettingsController controller = Get.put(SettingsController());
  final AuthController authController = Get.put(AuthController());



  @override
  void initState() {
    super.initState();
    _loadProfileImage();

    /// Fetch settings
    controller.fetchSettings();
    controller.fetchSettings().then((_) {
      final data = controller.settingsData.value;
      if (data != null) {
        nameController.text = data.user.username;
        emailController.text = data.user.email;
        phoneController.text = data.user.mobile;
      }
    });


  }

  Future<void> _pickProfileImage() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', picked.path);
    }
  }

// Load image path on screen init
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image_path');

    if (path != null && path.isNotEmpty) {
      setState(() {
        _profileImage = File(path);
      });
    }
  }
  /// SAVE → UPDATE API
  Future<void> _onSave() async {
    final success = await controller.updateSettings(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
    );

    if (success) {
      AppToast.showSuccess(context, "Profile updated successfully");
    } else {
      AppToast.showError(context, "Failed to update profile");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = controller.settingsData.value;
        if (data == null) return const SizedBox();

        return SingleChildScrollView(
          child: Column(
            children: [
              /// ==========================
              /// PROFILE CARD
              /// ==========================
              Container(
                margin: const EdgeInsets.all(14),
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.borderColor,
                      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person, size: 28)
                          : null,
                    ),

                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(  data.center.centerName,
                            style: AppTextStyles.dashBordButton2),
                        Text( data.user.username,
                            style: AppTextStyles.inputHint),
                        Text( data.center.address,
                            style: AppTextStyles.inputHint),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _pickProfileImage,
                      child: Image.asset(
                        "assets/icons/edit.png",
                        height: 36,
                        width: 90,
                      ),
                    ),
                  ],
                ),
              ),

              /// ==========================
              /// PERSONAL INFO
              /// ==========================
              Container(
                margin: const EdgeInsets.all(14),
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Personal Information",
                        style: AppTextStyles.heading2),
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
                      label: '',
                    ),
                  ],
                ),
              ),

              /// ==========================
              /// LOGOUT
              /// ==========================
              Container(
                margin: const EdgeInsets.all(14),
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    Text("TestPan India",
                        style: AppTextStyles.dashBordButton2),
                    const Spacer(),
                    GestureDetector(
                      onTap: authController.logout,
                      child: Image.asset(
                        "assets/icons/Delete.png",
                        height: 40,
                        width: 112,
                      ),
                    ),
                  ],
                ),
              ),

              /// ==========================
              /// DELETE ACCOUNT
              /// ==========================
              Container(
                margin: const EdgeInsets.all(14),
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delete account",
                            style: AppTextStyles.dashBordButton2),
                        Text("This action cannot be undone",
                            style: AppTextStyles.delete),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () =>
                          authController.deleteAccount(context: context),
                      child: Image.asset(
                        "assets/logo/Delete.png",
                        height: 40,
                        width: 120,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// SAVE BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomPrimaryButton(
                  text: "Save",
                  onPressed: _onSave,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 4,
          spreadRadius: 1,
          color: Colors.black.withOpacity(0.05),
        ),
      ],
    );
  }
}
