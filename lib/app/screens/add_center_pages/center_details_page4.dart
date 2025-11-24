import 'dart:io';

import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page2.dart';
import 'package:bmtc_app/app/screens/home/dashboard_page/dashBoard_page_screen.dart';
import 'package:bmtc_app/app/widgets/uploading_container.dart';
import 'package:bmtc_app/app/widgets/custom_textformfield.dart';
import 'package:bmtc_app/app/widgets/custom_button.dart';
import 'package:bmtc_app/app/utils/toast_message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CenterDetailsPage4 extends StatefulWidget {
  const CenterDetailsPage4({super.key});

  @override
  State<CenterDetailsPage4> createState() => _CenterDetailsPage4State();
}

class _CenterDetailsPage4State extends State<CenterDetailsPage4> {
  // ✅ Text Controllers
  final TextEditingController centerNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController gstStateController = TextEditingController();
  final TextEditingController udhaiController = TextEditingController();

  // ✅ Yes/No selections
  String? hasGST; // "Yes" or "No"
  String? hasMSME; // "Yes" or "No"

  @override
  void dispose() {
    centerNameController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    ifscController.dispose();
    panController.dispose();
    gstStateController.dispose();
    udhaiController.dispose();
    super.dispose();
  }

  Widget yesNoSelector(
      String title,
      String? value,
      Function(String?) onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.centerText),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(right: 150),
          child: Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text("Yes"),
                  value: "Yes",
                  groupValue: value,
                  onChanged: onChanged,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text("No"),
                  value: "No",
                  groupValue: value,
                  onChanged: onChanged,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _isValidAccountNumber(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    if (!RegExp(r'^[0-9]+$').hasMatch(trimmed)) return false;
    if (trimmed.length < 9 || trimmed.length > 18) return false;
    return true;
  }

  bool _isValidIFSC(String value) {
    final trimmed = value.trim().toUpperCase();
    // 4 letters + 0 + 6 alphanumeric
    return RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(trimmed);
  }

  bool _isValidPAN(String value) {
    final trimmed = value.trim().toUpperCase();
    // 5 letters + 4 digits + 1 letter
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(trimmed);
  }

  bool _isValidGSTStateCode(String value) {
    final trimmed = value.trim();
    // simple 2-digit numeric check (e.g., 07, 09, 27 etc.)
    return RegExp(r'^[0-9]{2}$').hasMatch(trimmed);
  }

  void _validateAndNext() {
    // Beneficiary Name
    if (centerNameController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Beneficiary Name");
      return;
    }

    // Bank Name
    if (bankNameController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Name of the Bank");
      return;
    }

    // Account Number
    if (!_isValidAccountNumber(accountNumberController.text)) {
      AppToast.showError(context, "Please enter a valid Bank Account Number");
      return;
    }

    // IFSC Code
    if (!_isValidIFSC(ifscController.text)) {
      AppToast.showError(context, "Please enter a valid IFSC Code");
      return;
    }

    // PAN
    if (!_isValidPAN(panController.text)) {
      AppToast.showError(context, "Please enter a valid PAN Number");
      return;
    }

    // GST Yes/No
    if (hasGST == null) {
      AppToast.showError(context, "Please select if you have GST number");
      return;
    }

    // Agar GST = Yes hai tabhi GST state code validate karein
    if (hasGST == "Yes") {
      if (gstStateController.text.trim().isEmpty) {
        AppToast.showError(context, "Please enter GST State Code");
        return;
      }
      if (!_isValidGSTStateCode(gstStateController.text)) {
        AppToast.showError(
          context,
          "Please enter a valid 2 digit GST State Code",
        );
        return;
      }
    }

    // UDHYAM / MSME
    if (hasMSME == null) {
      AppToast.showError(context, "Please select if you have MSME number");
      return;
    }
    if (hasMSME == "Yes" && udhaiController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter UDHYAM / MSME Number");
      return;
    }

    // ✅ All validations passed
    AppToast.showSuccess(context, "Bank details saved successfully");
    Get.to(DashboardPageScreen());
  }

  // 🔹 File variables
  File? chooseFile;
  String? chooseFileName;
  int? chooseFileSize;

  File? cancelledChequeFile;
  String? cancelledChequeFileName;
  int? cancelledChequeFileSize;

  File? agreementFile;
  String? agreementFileName;
  int? agreementFileSize;

  File? mouFile;
  String? mouFileName;
  int? mouFileSize;

  File? gstCertFile;
  String? gstCertFileName;
  int? gstCertFileSize;

  File? unhandyCertFile;
  String? unhandyCertFileName;
  int? unhandyCertFileSize;

  File? panCardFile;
  String? panCardFileName;
  int? panCardFileSize;

  File? udhayamFile;
  String? udhayamName;
  int? udhayamSize;

  Future<void> _pickFile({
    required double maxSizeMB,
    required List<String> allowedExtensions,
    required Function(File file, String name, int sizeInBytes) onFilePicked,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      final picked = result.files.first;
      final sizeInBytes = picked.size;
      final sizeInMB = sizeInBytes / (1024 * 1024);

      if (sizeInMB > maxSizeMB) {
        AppToast.showError(
          context,
          "File size must be less than ${maxSizeMB.toStringAsFixed(0)} MB",
        );
        return;
      }

      if (picked.path == null) {
        AppToast.showError(context, "Invalid file path");
        return;
      }

      final file = File(picked.path!);

      onFilePicked(file, picked.name, sizeInBytes);

      AppToast.showSuccess(context, "File selected: ${picked.name}");
    } catch (e) {
      AppToast.showError(context, "Failed to pick file");
    }
  }

  Widget _selectedFileInfo(String? name, int? sizeBytes) {
    if (name == null || sizeBytes == null) return const SizedBox.shrink();
    final sizeInMB = sizeBytes / (1024 * 1024);
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        "$name (${sizeInMB.toStringAsFixed(2)} MB)",
        style: AppTextStyles.centerSubTitle,
      ),
    );
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
                // 🔹 Top Step Heading
                Center(
                  child: Column(
                    children: [
                      Text("Step 4", style: AppTextStyles.bodyStepText),
                      const SizedBox(height: 2),
                      Text(
                        "Bank Account Details",
                        style: AppTextStyles.centerDetailsTopTitle,
                      ),
                      SizedBox(height: 8,),
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
                AppTextField(
                  controller: centerNameController,
                  label: "",
                  hintText: "",
                ),

                const SizedBox(height: 15),
                // Bank Name
                Text("Name of the Bank", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: bankNameController,
                  label: "",
                  hintText: "",
                ),

                const SizedBox(height: 15),
                // Account Number
                Text("Bank Account Number", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: accountNumberController,
                  label: "",
                  hintText: "",
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 15),
                // IFSC
                Text("IFSC Code", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: ifscController,
                  label: "",
                  hintText: "",
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 15),
                // PAN
                Text("PAN Number", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: panController,
                  label: "",
                  hintText: "",
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 15),

                yesNoSelector("Do you have GST number?", hasGST, (val) {
                  setState(() {
                    hasGST = val;
                    if (hasGST == "No") {
                      gstStateController.clear();
                    }
                  });
                }),

                const SizedBox(height: 15),

                if (hasGST == "Yes") ...[
                  Text("GST Number", style: AppTextStyles.centerText),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: gstStateController,
                    label: "",
                    hintText: "",
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 15),
                  Text(
                    "Upload GST Certificate",
                    style: AppTextStyles.centerText,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 8,
                      bottom: 8,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _pickFile(
                              maxSizeMB: 2,
                              allowedExtensions: ['doc', 'docx', 'pdf'],
                              onFilePicked: (file, name, size) {
                                setState(() {
                                  gstCertFile = file;
                                  gstCertFileName = name;
                                  gstCertFileSize = size;
                                });
                              },
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                "Choose File",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.karla(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: Text(
                            gstCertFileName == null ||
                                gstCertFileName!.isEmpty
                                ? "NO file chosen"
                                : gstCertFileName!,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.karla(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),
                  Text("GST Station Code", style: AppTextStyles.centerText),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: gstStateController,
                    label: "",
                    hintText: "",
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 15),
                  Text("UIDAI Number", style: AppTextStyles.centerText),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: udhaiController,
                    label: "",
                    hintText: "",
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Upload Unhandy certificate",
                    style: AppTextStyles.centerText,
                  ),
                  const SizedBox(height: 8),
                  UploadingContainer(
                    buttonText: "Upload File",
                    infoText:
                    "Max Each file size: 2 MB | File type: doc, docx, pdf",
                    onPressed: () async {
                      await _pickFile(
                        maxSizeMB: 2,
                        allowedExtensions: ['doc', 'docx', 'pdf'],
                        onFilePicked: (file, name, size) {
                          setState(() {
                            unhandyCertFile = file;
                            unhandyCertFileName = name;
                            unhandyCertFileSize = size;
                          });
                        },
                      );
                    },
                  ),
                  _selectedFileInfo(unhandyCertFileName, unhandyCertFileSize),
                  const SizedBox(height: 15),
                ],

                const SizedBox(height: 12),
                Text("GST Station Code", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: gstStateController,
                  label: "",
                  hintText: "",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                Text("UIDAI Number", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: udhaiController,
                  label: "",
                  hintText: "",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                yesNoSelector("Do you have MSME number?", hasMSME, (val) {
                  setState(() {
                    hasMSME = val;
                    if (hasMSME == "No") {
                      udhaiController.clear();
                    }
                  });
                }),

                const SizedBox(height: 15),

                if (hasMSME == "Yes") ...[
                  Text("UDHYAM / MSME Number", style: AppTextStyles.centerText),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: udhaiController,
                    label: "",
                    hintText: "",
                  ),
                  const SizedBox(height: 15),
                ],

                /// ✅ Static Uploads (hamesha dikhne wale)
                Text("Upload Canceled Cheque", style: AppTextStyles.centerText),
                const SizedBox(height: 15),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText:
                  "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                      maxSizeMB: 2,
                      allowedExtensions: ['doc', 'docx', 'pdf'],
                      onFilePicked: (file, name, size) {
                        setState(() {
                          cancelledChequeFile = file;
                          cancelledChequeFileName = name;
                          cancelledChequeFileSize = size;
                        });
                      },
                    );
                  },
                ),
                _selectedFileInfo(
                    cancelledChequeFileName, cancelledChequeFileSize),

                const SizedBox(height: 15),
                Text("Upload Agreement", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText:
                  "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                      maxSizeMB: 2,
                      allowedExtensions: ['doc', 'docx', 'pdf'],
                      onFilePicked: (file, name, size) {
                        setState(() {
                          agreementFile = file;
                          agreementFileName = name;
                          agreementFileSize = size;
                        });
                      },
                    );
                  },
                ),
                _selectedFileInfo(agreementFileName, agreementFileSize),

                const SizedBox(height: 15),
                Text("Upload MOU", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText:
                  "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                      maxSizeMB: 2,
                      allowedExtensions: ['doc', 'docx', 'pdf'],
                      onFilePicked: (file, name, size) {
                        setState(() {
                          mouFile = file;
                          mouFileName = name;
                          mouFileSize = size;
                        });
                      },
                    );
                  },
                ),
                _selectedFileInfo(mouFileName, mouFileSize),

                const SizedBox(height: 15),
                Text("Upload GST Certificate", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText:
                  "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                      maxSizeMB: 2,
                      allowedExtensions: ['doc', 'docx', 'pdf'],
                      onFilePicked: (file, name, size) {
                        setState(() {
                          gstCertFile = file;
                          gstCertFileName = name;
                          gstCertFileSize = size;
                        });
                      },
                    );
                  },
                ),
                _selectedFileInfo(gstCertFileName, gstCertFileSize),
                const SizedBox(height: 15),
                Text("Upload Udhayam Certificate", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText:
                  "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                      maxSizeMB: 2,
                      allowedExtensions: ['doc', 'docx', 'pdf'],
                      onFilePicked: (file, name, size) {
                        setState(() {
                          udhayamFile = file;
                          udhayamName = name;
                          udhayamSize = size;
                        });
                      },
                    );
                  },
                ),
                _selectedFileInfo(udhayamName, udhayamSize),
                const SizedBox(height: 15),
                Text("Upload PAN Card", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText:
                  "Max Each file size: 2 MB | File type: doc, docx, pdf",
                  onPressed: () async {
                    await _pickFile(
                      maxSizeMB: 2,
                      allowedExtensions: ['doc', 'docx', 'pdf'],
                      onFilePicked: (file, name, size) {
                        setState(() {
                          panCardFile = file;
                          panCardFileName = name;
                          panCardFileSize = size;
                        });
                      },
                    );
                  },
                ),
                _selectedFileInfo(panCardFileName, panCardFileSize),

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
                        onPressed: _validateAndNext,
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
