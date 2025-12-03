import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import '../../controllers/center_form_controller.dart';
import '../../core/app_colors.dart';
import '../../core/text_style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/uploading_container.dart';
import '../../utils/toast_message.dart';
import '../video_page/video_page_screen.dart';

class CenterDetailsPage4 extends StatefulWidget {
  const CenterDetailsPage4({Key? key}) : super(key: key);

  @override
  State<CenterDetailsPage4> createState() => _CenterDetailsPage4State();
}

class _CenterDetailsPage4State extends State<CenterDetailsPage4> {
  final ExamCenterController examController = Get.find<ExamCenterController>();
  // TextEditingControllers for all fields
  late TextEditingController beneficiaryController;
  late TextEditingController bankNameController;
  late TextEditingController accountNumberController;
  late TextEditingController ifscController;
  late TextEditingController panController;
  late TextEditingController gstController;
  late TextEditingController gstStateCodeController;
  late TextEditingController uidaiController;
  late TextEditingController msmeController;

  @override
  void initState() {
    super.initState();
    beneficiaryController = TextEditingController(text: examController.beneficiaryName.value);
    bankNameController = TextEditingController(text: examController.bankName.value);
    accountNumberController = TextEditingController(text: examController.bankAccountNumber.value);
    ifscController = TextEditingController(text: examController.bankIfsc.value);
    panController = TextEditingController(text: examController.panNumber.value);
    gstController = TextEditingController(text: examController.gstNumber.value);
    gstStateCodeController = TextEditingController(
        text: examController.gstStateCode.value == 0 ? '' : examController.gstStateCode.value.toString());
    uidaiController = TextEditingController(text: examController.uidaiNumber.value);
    msmeController = TextEditingController(text: examController.msmeNumber.value);
  }

  @override
  void dispose() {
    beneficiaryController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    ifscController.dispose();
    panController.dispose();
    gstController.dispose();
    gstStateCodeController.dispose();
    uidaiController.dispose();
    msmeController.dispose();
    super.dispose();
  }

  Future<void> _pickFile({
    required double maxSizeMB,
    required List<String> allowedExtensions,
    required Function(File file) onFilePicked,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      final picked = result.files.first;
      final sizeInMB = picked.size / (1024 * 1024);

      if (sizeInMB > maxSizeMB) {
        AppToast.showError(Get.context!, "File size must be less than ${maxSizeMB.toStringAsFixed(0)} MB");
        return;
      }

      if (picked.path == null) {
        AppToast.showError(Get.context!, "Invalid file path");
        return;
      }

      final file = File(picked.path!);
      onFilePicked(file);

      AppToast.showSuccess(Get.context!, "File selected: ${picked.name}");
    } catch (e) {
      AppToast.showError(Get.context!, "Failed to pick file");
    }
  }

  Widget _selectedFileInfo(Rxn<File> file) {
    return Obx(() {
      if (file.value == null) return const SizedBox.shrink();
      final sizeInMB = file.value!.lengthSync() / (1024 * 1024);
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          "${basename(file.value!.path)} (${sizeInMB.toStringAsFixed(2)} MB)",
          style: AppTextStyles.centerSubTitle,
        ),
      );
    });
  }

  Widget yesNoSelector(String title, RxBool value) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.centerText),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(right: 150),
          child: Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text("Yes"),
                  value: true,
                  groupValue: value.value,
                  onChanged: (val) => value.value = val!,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text("No"),
                  value: false,
                  groupValue: value.value,
                  onChanged: (val) => value.value = val!,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Future<void> _submit() async {
    // Update controller values from text controllers
    examController.beneficiaryName.value = beneficiaryController.text.trim();
    examController.bankName.value = bankNameController.text.trim();
    examController.bankAccountNumber.value = accountNumberController.text.trim();
    examController.bankIfsc.value = ifscController.text.trim();
    examController.panNumber.value = panController.text.trim();
    examController.gstNumber.value = gstController.text.trim();
    examController.gstStateCode.value = int.tryParse(gstStateCodeController.text.trim()) ?? 0;
    examController.uidaiNumber.value = uidaiController.text.trim();
    examController.msmeNumber.value = msmeController.text.trim();

    // Optional: Add field validation here if needed

    try {
      await examController.submitExamCenter();
      AppToast.showSuccess(Get.context!, "Data submitted successfully!");
      Get.to(videoPageScreen());
    } catch (e) {
      AppToast.showError(Get.context!, "Submission failed. Try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step Header
                Center(
                  child: Column(
                    children: [
                      Text("Step 4", style: AppTextStyles.bodyStepText),
                      const SizedBox(height: 2),
                      Text(
                        "Bank Account Details",
                        style: AppTextStyles.centerDetailsTopTitle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Please enter your bank details",
                        style: AppTextStyles.centerSubTitle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Beneficiary Name
                Text("Beneficiary Name", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(controller: beneficiaryController, onChanged: (val) {}, label: '',),
                const SizedBox(height: 15),

                // Bank Name
                Text("Name of the Bank", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(controller: bankNameController, onChanged: (val) {}, label: '',),
                const SizedBox(height: 15),

                // Bank Account Number
                Text("Bank Account Number", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: accountNumberController,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {}, label: '',
                ),
                const SizedBox(height: 15),

                // IFSC
                Text("Bank IFSC code", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(controller: ifscController, onChanged: (val) {}, label: '',),
                const SizedBox(height: 15),

                // PAN
                Text("PAN Number", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(controller: panController, onChanged: (val) {}, label: '',),
                const SizedBox(height: 15),

                // GST Yes/No
                yesNoSelector("Do you have GST number?", examController.hasGst),
                const SizedBox(height: 15),

                // GST Details
                Obx(() => examController.hasGst.value
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("GST Number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(controller: gstController, keyboardType: TextInputType.number, onChanged: (val) {}, label: '',),
                    const SizedBox(height: 15),
                    Text("Upload GST Certificate", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    UploadingContainer(
                      buttonText: "Upload File",
                      infoText: "Max Each file size: 2 MB | File type: doc, docx, pdf",
                      onPressed: () async {
                        await _pickFile(
                            maxSizeMB: 2,
                            allowedExtensions: ['doc', 'docx', 'pdf'],
                            onFilePicked: (file) {
                              examController.gstCertFile.value = file;
                            });
                      },
                    ),
                    _selectedFileInfo(examController.gstCertFile),
                    const SizedBox(height: 15),
                    Text("GST State Code", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(controller: gstStateCodeController, keyboardType: TextInputType.number, onChanged: (val) {}, label: '',),
                  ],
                )
                    : const SizedBox.shrink()),

                const SizedBox(height: 15),

                // UIDAI
                Text("UIDAI Number", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(controller: uidaiController, onChanged: (val) {}, label: '',),
                const SizedBox(height: 15),

                // MSME Yes/No
                yesNoSelector("Do you have MSME number?", examController.hasMsme),
                const SizedBox(height: 15),

                Obx(() => examController.hasMsme.value
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("MSME Number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(controller: msmeController, onChanged: (val) {}, label: '',),
                    const SizedBox(height: 15),
                  ],
                )
                    : const SizedBox.shrink()),

                /// File Uploads
                // Canceled Cheque
                Text("Upload Canceled Cheque", style: AppTextStyles.centerText),
                const SizedBox(height: 15),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                        maxSizeMB: 2,
                        allowedExtensions: ['doc', 'docx', 'pdf'],
                        onFilePicked: (file) {
                          examController.cancelledChequeFile.value = file;
                        });
                  },
                ),
                _selectedFileInfo(examController.cancelledChequeFile),
                const SizedBox(height: 15),

                // Agreement
                Text("Upload Agreement", style: AppTextStyles.centerText),
                const SizedBox(height: 15),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                        maxSizeMB: 2,
                        allowedExtensions: ['doc', 'docx', 'pdf'],
                        onFilePicked: (file) {
                          examController.agreementFile.value = file;
                        });
                  },
                ),
                _selectedFileInfo(examController.agreementFile),
                const SizedBox(height: 15),

                // MOU
                Text("Upload MOU", style: AppTextStyles.centerText),
                const SizedBox(height: 15),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                        maxSizeMB: 2,
                        allowedExtensions: ['doc', 'docx', 'pdf'],
                        onFilePicked: (file) {
                          examController.mouFile.value = file;
                        });
                  },
                ),
                _selectedFileInfo(examController.mouFile),
                const SizedBox(height: 15),

                // PAN Card
                Text("Upload PAN Card", style: AppTextStyles.centerText),
                const SizedBox(height: 15),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                        maxSizeMB: 2,
                        allowedExtensions: ['doc', 'docx', 'pdf'],
                        onFilePicked: (file) {
                          examController.panCardFile.value = file;
                        });
                  },
                ),
                _selectedFileInfo(examController.panCardFile),
                const SizedBox(height: 15),

                // Udhaym Certificate
                Text("Upload Udhaym Certificate", style: AppTextStyles.centerText),
                const SizedBox(height: 15),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                        maxSizeMB: 2,
                        allowedExtensions: ['doc', 'docx', 'pdf'],
                        onFilePicked: (file) {
                          examController.udhayamFile.value = file;
                        });
                  },
                ),
                _selectedFileInfo(examController.udhayamFile),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xffDDDDDD))),
                          height: 48,
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Go Back", textAlign: TextAlign.center, style: AppTextStyles.centerText),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 26),
                    Expanded(
                      flex: 2,
                      child: CustomPrimaryButton(
                        icon: Icons.arrow_right_alt_rounded,
                        text: "Next",
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
