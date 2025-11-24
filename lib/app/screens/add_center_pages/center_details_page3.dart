// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../core/app_colors.dart';
// import '../../core/text_style.dart';
// import '../../widgets/custom_button.dart';
// import '../../widgets/custom_textformfield.dart';
// import '../../widgets/custom_dropdown.dart';
// import '../../utils/toast_message.dart';
// import 'center_details_page4.dart';
//
// class CenterDetailsPage3 extends StatefulWidget {
//   const CenterDetailsPage3({super.key});
//
//   @override
//   State<CenterDetailsPage3> createState() => _CenterDetailsPage3State();
// }
//
// class _CenterDetailsPage3State extends State<CenterDetailsPage3> {
//   // ===== Text Controllers =====
//   final TextEditingController totalLabsController = TextEditingController();
//   final TextEditingController totalSystemsController = TextEditingController();
//   final TextEditingController totalNetworkController = TextEditingController();
//   final TextEditingController primaryISPController = TextEditingController();
//   final TextEditingController secondaryISPController = TextEditingController();
//   final TextEditingController upsBackupController = TextEditingController();
//   final TextEditingController computersController = TextEditingController();
//
//   // ===== Dropdown Selections =====
//   String? selectedNetwork;
//   String? selectedPartition;
//   String? selectedAC;
//   String? selectedPrinter;
//   String? selectedProjector;
//   String? selectedSoundSystem;
//   String? selectedFireExit;
//   String? selectedMemory;
//   String? selectedDrinkingWater;
//   String? selectedPrimaryISPType;
//   String? selectedPrimarySpeed;
//   String? selectedSecondaryISPType;
//   String? selectedSecondarySpeed;
//   String? selectedGenerator;
//   String? selectedUPSBackupTime;
//   String? selectedFloor;
//   String? selectedProcessor;
//   String? selectedMonitor;
//   String? selectedOS;
//   String? selectedRAM;
//   String? selectedHardDisk;
//   String? selectedSwitchCompany;
//   String? selectedSwitchCategory;
//   String? selectedSwitchParts;
//
//   /// Sample dropdown data
//   final List<String> yesNoOptions = ['Yes', 'No'];
//   final List<String> ispTypes = ['Fiber', 'DSL', 'Cable'];
//   final List<String> speeds = ['50 Mbps', '100 Mbps', '200 Mbps'];
//   final List<String> floors = ['Ground', '1st', '2nd', '3rd'];
//   final List<String> processors = ['i3', 'i5', 'i7', 'i9'];
//   final List<String> monitors = ['LCD', 'LED', 'CRT'];
//   final List<String> oss = ['Windows', 'Linux', 'MacOS'];
//   final List<String> rams = ['4GB', '8GB', '16GB'];
//   final List<String> hardDisks = ['HDD', 'SSD'];
//   final List<String> switchCompanies = ['Cisco', 'TP-Link', 'D-Link'];
//   final List<String> switchCategories = ['Layer 2', 'Layer 3'];
//   final List<String> switchParts = ['2 Ports', '4 Ports', '8 Ports'];
//
//   @override
//   void dispose() {
//     totalLabsController.dispose();
//     totalSystemsController.dispose();
//     totalNetworkController.dispose();
//     primaryISPController.dispose();
//     secondaryISPController.dispose();
//     upsBackupController.dispose();
//     computersController.dispose();
//     super.dispose();
//   }
//
//   bool _isPositiveNumber(String value) {
//     final trimmed = value.trim();
//     if (trimmed.isEmpty) return false;
//     final num? n = num.tryParse(trimmed);
//     return n != null && n > 0;
//   }
//
//   void _validateAndNext() {
//     // ===== General Lab details =====
//     if (!_isPositiveNumber(totalLabsController.text)) {
//       AppToast.showError(context, "Please enter valid Total number of labs");
//       return;
//     }
//
//     if (!_isPositiveNumber(totalSystemsController.text)) {
//       AppToast.showError(context, "Please enter valid Total number of systems");
//       return;
//     }
//
//     if (selectedNetwork == null) {
//       AppToast.showError(
//           context, "Please select if all labs are on single network");
//       return;
//     }
//
//     if (totalNetworkController.text.trim().isEmpty) {
//       AppToast.showError(context, "Please enter Total Network");
//       return;
//     }
//
//     if (selectedPartition == null) {
//       AppToast.showError(
//           context, "Please select if partition is available in each lab");
//       return;
//     }
//
//     if (selectedAC == null) {
//       AppToast.showError(
//           context, "Please select if AC is available in each lab");
//       return;
//     }
//
//     if (selectedPrinter == null) {
//       AppToast.showError(
//           context, "Please select if Network Printer is available");
//       return;
//     }
//
//     if (selectedProjector == null) {
//       AppToast.showError(
//           context, "Please select if projector is available in each lab");
//       return;
//     }
//
//     if (selectedSoundSystem == null) {
//       AppToast.showError(
//           context, "Please select if sound system is available in each lab");
//       return;
//     }
//
//     if (selectedFireExit == null) {
//       AppToast.showError(context, "Please select number of fire exits");
//       return;
//     }
//
//     if (selectedMemory == null) {
//       AppToast.showError(
//           context, "Please select if free memory space is available");
//       return;
//     }
//
//     if (selectedDrinkingWater == null) {
//       AppToast.showError(
//           context, "Please select if drinking water facility is available");
//       return;
//     }
//
//     // ===== Lab Infrastructure =====
//     if (primaryISPController.text.trim().isEmpty) {
//       AppToast.showError(context, "Please enter Name of the Primary ISP");
//       return;
//     }
//
//     if (selectedPrimaryISPType == null) {
//       AppToast.showError(context, "Please select Primary ISP Connected Type");
//       return;
//     }
//
//     if (selectedPrimarySpeed == null) {
//       AppToast.showError(context, "Please select Primary Internet Speed");
//       return;
//     }
//
//     if (secondaryISPController.text.trim().isEmpty) {
//       AppToast.showError(context, "Please enter Name of the Secondary ISP");
//       return;
//     }
//
//     if (selectedSecondaryISPType == null) {
//       AppToast.showError(context, "Please select Secondary ISP Connected Type");
//       return;
//     }
//
//     if (selectedSecondarySpeed == null) {
//       AppToast.showError(context, "Please select Secondary Internet Speed");
//       return;
//     }
//
//     if (selectedGenerator == null) {
//       AppToast.showError(context, "Please select if Generator is available");
//       return;
//     }
//
//     if (upsBackupController.text.trim().isEmpty) {
//       AppToast.showError(context, "Please enter UPS Backup details");
//       return;
//     }
//
//     if (selectedUPSBackupTime == null) {
//       AppToast.showError(context, "Please select UPS Backup Time");
//       return;
//     }
//
//     // ===== Lab Details (Lab number 1) =====
//     if (selectedFloor == null) {
//       AppToast.showError(context, "Please select Floor Number");
//       return;
//     }
//
//     if (!_isPositiveNumber(computersController.text)) {
//       AppToast.showError(
//           context, "Please enter valid Total Number of computers");
//       return;
//     }
//
//     if (selectedProcessor == null) {
//       AppToast.showError(context, "Please select System Processor");
//       return;
//     }
//
//     if (selectedMonitor == null) {
//       AppToast.showError(context, "Please select Monitor Type");
//       return;
//     }
//
//     if (selectedOS == null) {
//       AppToast.showError(context, "Please select Operating System");
//       return;
//     }
//
//     if (selectedRAM == null) {
//       AppToast.showError(context, "Please select RAM GB");
//       return;
//     }
//
//     if (selectedHardDisk == null) {
//       AppToast.showError(context, "Please select Hard Disk type");
//       return;
//     }
//
//     if (selectedSwitchCompany == null) {
//       AppToast.showError(context, "Please select Ethernet Switch Company");
//       return;
//     }
//
//     if (selectedSwitchCategory == null) {
//       AppToast.showError(context, "Please select Switch Category");
//       return;
//     }
//
//     if (selectedSwitchParts == null) {
//       AppToast.showError(context, "Please select No. of port Ethernet switch");
//       return;
//     }
//
//     // ✅ Sab validation pass ho gaya
//     AppToast.showSuccess(context, "Exam infrastructure details saved");
//     Get.to(() => const CenterDetailsPage4());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Align(
//                     alignment: Alignment.center,
//                     child: Text("Step 3", style: AppTextStyles.bodyStepText)),
//                 const SizedBox(height: 4),
//                 Align(
//                     alignment: Alignment.center,
//                     child: Text("Exam Infrastructure details",
//                         style: AppTextStyles.centerDetailsTopTitle)),
//                 const SizedBox(height: 10),
//                 Align(
//                     alignment: Alignment.center,
//                     child: Text("Please enter the required information",
//                         style: AppTextStyles.centerSubTitle)),
//
//                 const SizedBox(height: 20),
//                 Text("General Lab details",
//                     style: GoogleFonts.karla(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//
//                 // Total Labs
//                 Text("Total number of labs", style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 AppTextField(
//                   controller: totalLabsController,
//                   keyboardType: TextInputType.number,
//                   label: '',
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Total Systems
//                 Text("Total number of systems",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 AppTextField(
//                   controller: totalSystemsController,
//                   keyboardType: TextInputType.number,
//                   label: '',
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Network
//                 Text("Are all labs connected through a single network?",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedNetwork,
//                   items: yesNoOptions,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedNetwork = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Total Network
//                 Text("Total Network", style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 AppTextField(
//                   controller: totalNetworkController,
//                   keyboardType: TextInputType.text,
//                   label: '',
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Partition
//                 Text("Is there a partition in each lab?",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedPartition,
//                   items: yesNoOptions,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedPartition = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // AC
//                 Text("Is there an AC in each lab?",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedAC,
//                   items: yesNoOptions,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedAC = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Printer
//                 Text("Is the Network Printer available?",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedPrinter,
//                   items: yesNoOptions,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedPrinter = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Projector
//                 Text("Is there a projector in each lab?",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedProjector,
//                   items: yesNoOptions,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedProjector = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Sound System
//                 Text("Is there a sound system in each lab?",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedSoundSystem,
//                   items: yesNoOptions,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedSoundSystem = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Fire Exit
//                 Text("How many fire exit in lab",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedFireExit,
//                   items: ['1', '2', '3', 'More'],
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedFireExit = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Memory
//                 Text("Is there free memory space?",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedMemory,
//                   items: yesNoOptions,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedMemory = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Drinking Water
//                 Text("Is there drinking water facility in lab?",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedDrinkingWater,
//                   items: yesNoOptions,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedDrinkingWater = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 20),
//                 Text("Lab Infrastructure",
//                     style: GoogleFonts.karla(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//
//                 const SizedBox(height: 10),
//                 // Primary ISP Name
//                 Text("Name of the Primary ISP",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 AppTextField(
//                   controller: primaryISPController,
//                   keyboardType: TextInputType.text,
//                   label: '',
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Primary ISP Type
//                 Text("Primary ISP Connected Type",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedPrimaryISPType,
//                   items: ispTypes,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedPrimaryISPType = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Primary Speed
//                 Text("Primary Internet Speed",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedPrimarySpeed,
//                   items: speeds,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedPrimarySpeed = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Secondary ISP Name
//                 Text("Name of the Secondary ISP",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 AppTextField(
//                   controller: secondaryISPController,
//                   keyboardType: TextInputType.text,
//                   label: '',
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Secondary ISP Type
//                 Text("Secondary ISP Connected Type",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedSecondaryISPType,
//                   items: ispTypes,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedSecondaryISPType = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Secondary Speed
//                 Text("Secondary Internet Speed",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedSecondarySpeed,
//                   items: speeds,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedSecondarySpeed = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Generator
//                 Text("Generator Available",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedGenerator,
//                   items: yesNoOptions,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedGenerator = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // UPS Backup
//                 Text("UPS Backup", style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 AppTextField(
//                   controller: upsBackupController,
//                   keyboardType: TextInputType.text,
//                   label: '',
//                 ),
//
//                 const SizedBox(height: 10),
//                 // UPS Backup Time
//                 Text("UPS Backup Time",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedUPSBackupTime,
//                   items: ['30 mins', '1 hour', '2 hours'],
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedUPSBackupTime = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 20),
//                 Text("Lab Details",
//                     style: GoogleFonts.karla(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//
//                 const SizedBox(height: 10),
//                 // Lab Number 1 Container
//                 Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   height: 40,
//                   width: 130,
//                   child: Center(
//                     child: Text("Lab number 1",
//                         style: GoogleFonts.karla(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Floor Number
//                 Text("Floor Number", style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedFloor,
//                   items: floors,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedFloor = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Total Number of Computers
//                 Text("Total Number of computers",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 AppTextField(
//                   controller: computersController,
//                   keyboardType: TextInputType.number,
//                   label: '',
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Processor
//                 Text("System Processor",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedProcessor,
//                   items: processors,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedProcessor = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Monitor
//                 Text("Monitor Type", style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedMonitor,
//                   items: monitors,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedMonitor = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // OS
//                 Text("Operating System",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedOS,
//                   items: oss,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedOS = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // RAM
//                 Text("RAM GB", style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedRAM,
//                   items: rams,
//                   itemLabel: (v) => v,
//                   onChanged: (v) => setState(() => selectedRAM = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Hard Disk
//                 Text("Hard Disk", style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedHardDisk,
//                   items: hardDisks,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedHardDisk = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Switch Company
//                 Text("Ethernet Switch Company",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedSwitchCompany,
//                   items: switchCompanies,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedSwitchCompany = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // Switch Category
//                 Text("Switch Category",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedSwitchCategory,
//                   items: switchCategories,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedSwitchCategory = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 10),
//                 // No. of parts
//                 Text("No. of part Ethernet switch",
//                     style: AppTextStyles.centerText),
//                 const SizedBox(height: 5),
//                 CustomDropdown<String>(
//                   hintText: "Select",
//                   value: selectedSwitchParts,
//                   items: switchParts,
//                   itemLabel: (v) => v,
//                   onChanged: (v) =>
//                       setState(() => selectedSwitchParts = v),
//                   validator: (value) {},
//                 ),
//
//                 const SizedBox(height: 20),
//                 CustomPrimaryButton(
//                   text: "Add lab",
//                   icon: Icons.add,
//                   onPressed: () {
//                     // yahan baad me dynamic labs add kar sakte ho
//                     AppToast.showInfo(
//                         context, "Add lab functionality to be implemented");
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 CustomPrimaryButton(
//                   text: "Next",
//                   // icon: Icons.arrow_right_alt_rounded,
//                   onPressed: _validateAndNext,
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_colors.dart';
import '../../core/text_style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/custom_dropdown.dart';
import '../../utils/toast_message.dart';
import 'center_details_page4.dart';

class CenterDetailsPage3 extends StatefulWidget {
  const CenterDetailsPage3({super.key});

  @override
  State<CenterDetailsPage3> createState() => _CenterDetailsPage3State();
}

class LabDetail {
  String? floor;
  String? processor;
  String? monitor;
  String? os;
  String? ram;
  String? hardDisk;
  String? switchCompany;
  String? switchCategory;
  String? switchParts;
  final TextEditingController computersController = TextEditingController();

  void dispose() {
    computersController.dispose();
  }
}

class _CenterDetailsPage3State extends State<CenterDetailsPage3> {
  // Controllers
  final TextEditingController totalLabsController = TextEditingController();
  final TextEditingController totalSystemsController = TextEditingController();
  final TextEditingController totalNetworkController = TextEditingController();
  final TextEditingController primaryISPController = TextEditingController();
  final TextEditingController secondaryISPController = TextEditingController();
  final TextEditingController upsBackupController = TextEditingController();

  // Dropdown selections
  String? selectedNetwork;
  String? selectedPartition;
  String? selectedAC;
  String? selectedPrinter;
  String? selectedProjector;
  String? selectedSoundSystem;
  String? selectedFireExit;
  String? selectedMemory;
  String? selectedDrinkingWater;
  String? selectedPrimaryISPType;
  String? selectedPrimarySpeed;
  String? selectedSecondaryISPType;
  String? selectedSecondarySpeed;
  String? selectedGenerator;
  String? selectedUPSBackupTime;

  // Dropdown Data
  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> ispTypes = ['Fiber', 'DSL', 'Cable'];
  final List<String> speeds = ['50 Mbps', '100 Mbps', '200 Mbps'];
  final List<String> floors = ['Ground', '1st', '2nd', '3rd'];
  final List<String> processors = ['i3', 'i5', 'i7', 'i9'];
  final List<String> monitors = ['LCD', 'LED', 'CRT'];
  final List<String> oss = ['Windows', 'Linux', 'MacOS'];
  final List<String> rams = ['4GB', '8GB', '16GB'];
  final List<String> hardDisks = ['HDD', 'SSD'];
  final List<String> switchCompanies = ['Cisco', 'TP-Link', 'D-Link'];
  final List<String> switchCategories = ['Layer 2', 'Layer 3'];
  final List<String> switchParts = ['2 Ports', '4 Ports', '8 Ports'];

  // Labs
  List<LabDetail> labs = [LabDetail()];

  @override
  void dispose() {
    totalLabsController.dispose();
    totalSystemsController.dispose();
    totalNetworkController.dispose();
    primaryISPController.dispose();
    secondaryISPController.dispose();
    upsBackupController.dispose();
    for (var lab in labs) {
      lab.dispose();
    }
    super.dispose();
  }

  bool _isPositiveNumber(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    final num? n = num.tryParse(trimmed);
    return n != null && n > 0;
  }

  void _updateLabs() {
    int? totalLabs = int.tryParse(totalLabsController.text);
    if (totalLabs == null || totalLabs <= 0) {
      return;
    }
    setState(() {
      while (labs.length < totalLabs) labs.add(LabDetail());
      while (labs.length > totalLabs) {
        labs.last.dispose();
        labs.removeLast();
      }
    });
  }

  void _validateAndNext() {
    if (!_isPositiveNumber(totalLabsController.text)) {
      AppToast.showError(context, "Please enter valid Total number of labs");
      return;
    }
    if (!_isPositiveNumber(totalSystemsController.text)) {
      AppToast.showError(context, "Please enter valid Total number of systems");
      return;
    }
    if (selectedNetwork == null) {
      AppToast.showError(context, "Please select if all labs are on single network");
      return;
    }
    if (totalNetworkController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Total Network");
      return;
    }
    if (selectedPartition == null) {
      AppToast.showError(context, "Please select if partition is available in each lab");
      return;
    }
    if (selectedAC == null) {
      AppToast.showError(context, "Please select if AC is available in each lab");
      return;
    }
    if (selectedPrinter == null) {
      AppToast.showError(context, "Please select if Network Printer is available");
      return;
    }
    if (selectedProjector == null) {
      AppToast.showError(context, "Please select if projector is available in each lab");
      return;
    }
    if (selectedSoundSystem == null) {
      AppToast.showError(context, "Please select if sound system is available in each lab");
      return;
    }
    if (selectedFireExit == null) {
      AppToast.showError(context, "Please select number of fire exits");
      return;
    }
    if (selectedMemory == null) {
      AppToast.showError(context, "Please select if free memory space is available");
      return;
    }
    if (selectedDrinkingWater == null) {
      AppToast.showError(context, "Please select if drinking water facility is available");
      return;
    }
    if (primaryISPController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Name of the Primary ISP");
      return;
    }
    if (selectedPrimaryISPType == null) {
      AppToast.showError(context, "Please select Primary ISP Connected Type");
      return;
    }
    if (selectedPrimarySpeed == null) {
      AppToast.showError(context, "Please select Primary Internet Speed");
      return;
    }
    if (secondaryISPController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Name of the Secondary ISP");
      return;
    }
    if (selectedSecondaryISPType == null) {
      AppToast.showError(context, "Please select Secondary ISP Connected Type");
      return;
    }
    if (selectedSecondarySpeed == null) {
      AppToast.showError(context, "Please select Secondary Internet Speed");
      return;
    }
    if (selectedGenerator == null) {
      AppToast.showError(context, "Please select if Generator is available");
      return;
    }
    if (upsBackupController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter UPS Backup details");
      return;
    }
    if (selectedUPSBackupTime == null) {
      AppToast.showError(context, "Please select UPS Backup Time");
      return;
    }

    for (int i = 0; i < labs.length; i++) {
      final lab = labs[i];
      if (lab.floor == null) {
        AppToast.showError(context, "Select floor for Lab ${i + 1}");
        return;
      }
      if (!_isPositiveNumber(lab.computersController.text)) {
        AppToast.showError(context, "Enter valid number of computers for Lab ${i + 1}");
        return;
      }
      if (lab.processor == null) {
        AppToast.showError(context, "Select processor for Lab ${i + 1}");
        return;
      }
      if (lab.monitor == null) {
        AppToast.showError(context, "Select monitor for Lab ${i + 1}");
        return;
      }
      if (lab.os == null) {
        AppToast.showError(context, "Select OS for Lab ${i + 1}");
        return;
      }
      if (lab.ram == null) {
        AppToast.showError(context, "Select RAM for Lab ${i + 1}");
        return;
      }
      if (lab.hardDisk == null) {
        AppToast.showError(context, "Select Hard Disk for Lab ${i + 1}");
        return;
      }
      if (lab.switchCompany == null) {
        AppToast.showError(context, "Select Switch Company for Lab ${i + 1}");
        return;
      }
      if (lab.switchCategory == null) {
        AppToast.showError(context, "Select Switch Category for Lab ${i + 1}");
        return;
      }
      if (lab.switchParts == null) {
        AppToast.showError(context, "Select Switch Parts for Lab ${i + 1}");
        return;
      }
    }

    AppToast.showSuccess(context, "All lab details saved");
    Get.to(() => const CenterDetailsPage4());
  }

  Widget _buildLabBox(int index) {
    final lab = labs[index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 40,
                width: 130,
                child: Center(
                  child: Text("Lab number ${index + 1}",
                      style: GoogleFonts.karla(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              if (index != 0)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      labs[index].dispose();
                      labs.removeAt(index);
                      totalLabsController.text = labs.length.toString();
                    });
                  },
                ),
            ],
          ),
          const SizedBox(height: 15),
          Text("Floor Number", style: AppTextStyles.centerText),
          const SizedBox(height:8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.floor,
            items: floors,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.floor = v), validator: (value) {  },
          ),
          const SizedBox(height: 15),
          Text("Total Number of computers", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          AppTextField(
            controller: lab.computersController,
            keyboardType: TextInputType.number,
            label: '',
          ),
          const SizedBox(height: 15),
          Text("Processor", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.processor,
            items: processors,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.processor = v), validator: (value) {  },
          ),
          const SizedBox(height: 15),
          Text("Monitor", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.monitor,
            items: monitors,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.monitor = v), validator: (value) {  },
          ),
          const SizedBox(height: 15),
          Text("Operating System", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.os,
            items: oss,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.os = v), validator: (value) {  },
          ),
          const SizedBox(height: 15),
          Text("RAM", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.ram,
            items: rams,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.ram = v), validator: (value) {  },
          ),
          const SizedBox(height: 15),
          Text("Hard Disk", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.hardDisk,
            items: hardDisks,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.hardDisk = v), validator: (value) {  },
          ),
          const SizedBox(height: 15),
          Text("Ethernet Switch Company", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.switchCompany,
            items: switchCompanies,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.switchCompany = v), validator: (value) {  },
          ),
          const SizedBox(height: 15),
          Text("Switch Category", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.switchCategory,
            items: switchCategories,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.switchCategory = v), validator: (value) {  },
          ),
          const SizedBox(height: 15),
          Text("No. of part Ethernet switch", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.switchParts,
            items: switchParts,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.switchParts = v), validator: (value) {  },
          ),
        ],
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text("Step 3", style: AppTextStyles.bodyStepText)),
                const SizedBox(height: 4),
                Align(
                    alignment: Alignment.center,
                    child: Text("Exam Infrastructure details",
                        style: AppTextStyles.centerDetailsTopTitle)),
                const SizedBox(height: 6),
                Align(
                    alignment: Alignment.center,
                    child: Text("Please enter the required information",
                        style: AppTextStyles.centerSubTitle)),
                const SizedBox(height: 20),

                Text("General Lab details",
                    style: GoogleFonts.karla(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Text("Total number of labs", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: totalLabsController,
                  keyboardType: TextInputType.number,
                  label: '',
                  onChanged: (_) => _updateLabs(),
                ),
                const SizedBox(height: 15),
                // Total Systems
                Text("Total number of systems",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: totalSystemsController,
                  keyboardType: TextInputType.number,
                  label: '',
                ),

                const SizedBox(height: 15),
                // Network
                Text("Are all labs connected through a single network?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedNetwork,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedNetwork = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Total Network
                Text("Total Network", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: totalNetworkController,
                  keyboardType: TextInputType.text,
                  label: '',
                ),

                const SizedBox(height: 15),
                // Partition
                Text("Is there a partition in each lab?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedPartition,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedPartition = v),
                  validator: (value) {},
                ),
                const SizedBox(height: 15),
                // AC
                Text("Is there an AC in each lab?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedAC,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedAC = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Printer
                Text("Is the Network Printer available?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedPrinter,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedPrinter = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Projector
                Text("Is there a projector in each lab?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedProjector,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedProjector = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Sound System
                Text("Is there a sound system in each lab?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedSoundSystem,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) =>
                      setState(() => selectedSoundSystem = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Fire Exit
                Text("How Many Fire Extinguisher in each lab",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedFireExit,
                  items: ['1', '2', '3', 'More'],
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedFireExit = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Memory
                Text("Is there a Free Baggage Space?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedMemory,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedMemory = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Drinking Water
                Text("Is there a drinking water facility in/near the labs?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedDrinkingWater,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) =>
                      setState(() => selectedDrinkingWater = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 30),
                Text("Lab Infrastructure",
                    style: GoogleFonts.karla(
                        fontSize: 18, fontWeight: FontWeight.bold)),

                const SizedBox(height: 15),
                // Primary ISP Name
                Text("Name of the Primary ISP",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: primaryISPController,
                  keyboardType: TextInputType.text,
                  label: '',
                ),

                const SizedBox(height: 15),
                // Primary ISP Type
                Text("Primary ISP Connected Type",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedPrimaryISPType,
                  items: ispTypes,
                  itemLabel: (v) => v,
                  onChanged: (v) =>
                      setState(() => selectedPrimaryISPType = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),

                Text("Primary Internet Speed",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedPrimarySpeed,
                  items: speeds,
                  itemLabel: (v) => v,
                  onChanged: (v) =>
                      setState(() => selectedPrimarySpeed = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Secondary ISP Name
                Text("Name of the Secondary ISP",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: secondaryISPController,
                  keyboardType: TextInputType.text,
                  label: '',
                ),

                const SizedBox(height: 15),
                // Secondary ISP Type
                Text("Secondary ISP Connected Type",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedSecondaryISPType,
                  items: ispTypes,
                  itemLabel: (v) => v,
                  onChanged: (v) =>
                      setState(() => selectedSecondaryISPType = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Secondary Speed
                Text("Secondary Internet Speed",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedSecondarySpeed,
                  items: speeds,
                  itemLabel: (v) => v,
                  onChanged: (v) =>
                      setState(() => selectedSecondarySpeed = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // Generator
                Text("Generator Available",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedGenerator,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) =>
                      setState(() => selectedGenerator = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                // UPS Backup
                Text("UPS Backup", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: upsBackupController,
                  keyboardType: TextInputType.text,
                  label: '',
                ),

                const SizedBox(height: 15),
                // UPS Backup Time
                Text("UPS Backup Time",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedUPSBackupTime,
                  items: ['30 mins', '1 hour', '2 hours'],
                  itemLabel: (v) => v,
                  onChanged: (v) =>
                      setState(() => selectedUPSBackupTime = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                Text("Lab Details",
                    style: GoogleFonts.karla(
                        fontSize: 18, fontWeight: FontWeight.bold)),


                ...List.generate(labs.length, (index) => _buildLabBox(index)),

                const SizedBox(height: 20),
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
