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
  // ===== Text Controllers =====
  final TextEditingController totalLabsController = TextEditingController();
  final TextEditingController totalSystemsController = TextEditingController();
  final TextEditingController totalNetworkController = TextEditingController();
  final TextEditingController primaryISPController = TextEditingController();
  final TextEditingController secondaryISPController = TextEditingController();
  final TextEditingController upsBackupController = TextEditingController();

  // Internet speed value controllers
  final TextEditingController primaryInternetController =
  TextEditingController();
  final TextEditingController secondaryInternetController =
  TextEditingController();

  // Generator / Tank etc.
  final TextEditingController generatorCapacityController =
  TextEditingController();
  String? selectedTankCapacity;
  final List<String> tankCapacities = [
    '5 ltr',
    '10 ltr',
    '15 ltr',
    '20 ltr',
    '25 ltr',
    '30 ltr',
    '35 ltr',
    '40 ltr',
    '45 ltr',
    '50 ltr',
  ];

  // ===== Dropdown Selections =====
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
  String? tankCapacityLtrTime;



  // ===== Dropdown Data =====
  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> ispTypes = [
    'Broadband',
    'Lease line',
    'Fibre Optics',
    'Air Fibre'
  ];
  final List<String> speeds = ['Gbps', 'Mbps'];
  final List<String> floors = ['Ground', '1st', '2nd', '3rd','4th','5th','6th','7th','8th','9th','10th',"basement"];
  final List<String> processors = ['Core 2 Duo','i3', 'i5', 'i7', 'i9'];
  final List<String> monitors = ['LCD', 'LED', 'CRT'];
  final List<String> oss = ['Win 7','Win 8', 'Win 10','Win 11','MacOS'];
  final List<String> rams = ['2GB', '4GB','8GB', '16GB','32GB',];
  final List<String> hardDisks = ['80GB', '128GB','160GB','256GB','512GB','1TB','2TB','4TB'];
  final List<String> switchCompanies = ['Cisco','Netgear', 'TP-Link', 'D-Link','Dex','Others'];
  final List<String> switchCategories = ['Unmanaged', 'Smart','Managed L2','Managed L3'];
  final List<String> switchParts = ['8','16','24','32'];
  final List<String> upsBackupTimeOptions = [
    '5 mins',
    '10 mins',
    '15 mins',
    '20 mins',
    '25 mins',
    '30 mins',
    '35 mins',
    '40 mins',
    '50 mins',
    '60 mins',
  ];
  final List<String> tankCapacityLtr = [
    '1 ltr',  '1.5 ltr','2 ltr', '2.5 ltr', '3 ltr', '3.5 ltr', '4 ltr', '4.5 ltr', '5 ltr',
  ];
  List<LabDetail> labs = [LabDetail()];

  @override
  void dispose() {
    totalLabsController.dispose();
    totalSystemsController.dispose();
    totalNetworkController.dispose();
    primaryISPController.dispose();
    secondaryISPController.dispose();
    upsBackupController.dispose();
    primaryInternetController.dispose();
    secondaryInternetController.dispose();
    generatorCapacityController.dispose();
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

  // Total number of labs change hone par dynamic list update
  void _updateLabs() {
    int? totalLabs = int.tryParse(totalLabsController.text);
    if (totalLabs == null || totalLabs <= 0) {
      return;
    }
    setState(() {
      // add new LabDetail till length == totalLabs
      while (labs.length < totalLabs) {
        labs.add(LabDetail());
      }
      // extra labs ko remove karo
      while (labs.length > totalLabs) {
        labs.last.dispose();
        labs.removeLast();
      }
    });
  }

  // void _validateAndNext() {
  //   // ===== General Lab details =====
  //   if (!_isPositiveNumber(totalLabsController.text)) {
  //     AppToast.showError(context, "Please enter valid Total number of labs");
  //     return;
  //   }
  //
  //   if (!_isPositiveNumber(totalSystemsController.text)) {
  //     AppToast.showError(context, "Please enter valid Total number of systems");
  //     return;
  //   }
  //
  //   if (selectedNetwork == null) {
  //     AppToast.showError(
  //         context, "Please select if all labs are on single network");
  //     return;
  //   }
  //
  //   if (totalNetworkController.text.trim().isEmpty) {
  //     AppToast.showError(context, "Please enter Total Network");
  //     return;
  //   }
  //
  //   if (selectedPartition == null) {
  //     AppToast.showError(context,
  //         "Please select if partition is available in each lab/system");
  //     return;
  //   }
  //
  //   if (selectedAC == null) {
  //     AppToast.showError(
  //         context, "Please select if AC is available in each lab");
  //     return;
  //   }
  //
  //   if (selectedPrinter == null) {
  //     AppToast.showError(
  //         context, "Please select if Network Printer is available");
  //     return;
  //   }
  //
  //   if (selectedProjector == null) {
  //     AppToast.showError(
  //         context, "Please select if projector is available in each lab");
  //     return;
  //   }
  //
  //   if (selectedSoundSystem == null) {
  //     AppToast.showError(
  //         context, "Please select if sound system is available in each lab");
  //     return;
  //   }
  //
  //   if (selectedFireExit == null) {
  //     AppToast.showError(context, "Please select number of Fire Extinguisher");
  //     return;
  //   }
  //
  //   if (selectedMemory == null) {
  //     AppToast.showError(
  //         context, "Please select if free baggage space is available");
  //     return;
  //   }
  //
  //   if (selectedDrinkingWater == null) {
  //     AppToast.showError(context,
  //         "Please select if drinking water facility is available");
  //     return;
  //   }
  //
  //   // ===== Lab Infrastructure =====
  //   if (primaryISPController.text.trim().isEmpty) {
  //     AppToast.showError(context, "Please enter Name of the Primary ISP");
  //     return;
  //   }
  //
  //   if (selectedPrimaryISPType == null) {
  //     AppToast.showError(context, "Please select Primary ISP Connected Type");
  //     return;
  //   }
  //
  //   if (!_isPositiveNumber(primaryInternetController.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid Primary Internet Speed value");
  //     return;
  //   }
  //
  //   if (selectedPrimarySpeed == null) {
  //     AppToast.showError(context, "Please select Primary Internet Speed unit");
  //     return;
  //   }
  //
  //   if (secondaryISPController.text.trim().isEmpty) {
  //     AppToast.showError(context, "Please enter Name of the Secondary ISP");
  //     return;
  //   }
  //
  //   if (selectedSecondaryISPType == null) {
  //     AppToast.showError(
  //         context, "Please select Secondary ISP Connected Type");
  //     return;
  //   }
  //
  //   if (!_isPositiveNumber(secondaryInternetController.text)) {
  //     AppToast.showError(
  //         context, "Please enter valid Secondary Internet Speed value");
  //     return;
  //   }
  //
  //   if (selectedSecondarySpeed == null) {
  //     AppToast.showError(
  //         context, "Please select Secondary Internet Speed unit");
  //     return;
  //   }
  //
  //   if (selectedGenerator == null) {
  //     AppToast.showError(context, "Please select if Generator is available");
  //     return;
  //   }
  //
  //   // ✅ Agar generator "Yes" hai tabhi capacity & UPS backup time validate karo
  //   if (selectedGenerator == "Yes") {
  //     if (generatorCapacityController.text.trim().isEmpty) {
  //       AppToast.showError(
  //           context, "Please enter Generator Capacity (in KVA)");
  //       return;
  //     }
  //
  //     if (selectedUPSBackupTime == null) {
  //       AppToast.showError(context, "Please select UPS Backup Time (in mins)");
  //       return;
  //     }
  //   }
  //
  //   if (upsBackupController.text.trim().isEmpty) {
  //     AppToast.showError(context, "Please enter UPS Backup details");
  //     return;
  //   }
  //
  //   // ===== Dynamic Lab Details Validation =====
  //   for (int i = 0; i < labs.length; i++) {
  //     final lab = labs[i];
  //
  //     if (lab.floor == null) {
  //       AppToast.showError(
  //           context, "Please select Floor Number for Lab ${i + 1}");
  //       return;
  //     }
  //
  //     if (!_isPositiveNumber(lab.computersController.text)) {
  //       AppToast.showError(
  //           context, "Please enter valid number of computers for Lab ${i + 1}");
  //       return;
  //     }
  //
  //     if (lab.processor == null) {
  //       AppToast.showError(
  //           context, "Please select System Processor for Lab ${i + 1}");
  //       return;
  //     }
  //
  //     if (lab.monitor == null) {
  //       AppToast.showError(
  //           context, "Please select Monitor Type for Lab ${i + 1}");
  //       return;
  //     }
  //
  //     if (lab.os == null) {
  //       AppToast.showError(
  //           context, "Please select Operating System for Lab ${i + 1}");
  //       return;
  //     }
  //
  //     if (lab.ram == null) {
  //       AppToast.showError(
  //           context, "Please select RAM GB for Lab ${i + 1}");
  //       return;
  //     }
  //
  //     if (lab.hardDisk == null) {
  //       AppToast.showError(
  //           context, "Please select Hard Disk type for Lab ${i + 1}");
  //       return;
  //     }
  //
  //     if (lab.switchCompany == null) {
  //       AppToast.showError(context,
  //           "Please select Ethernet Switch Company for Lab ${i + 1}");
  //       return;
  //     }
  //
  //     if (lab.switchCategory == null) {
  //       AppToast.showError(
  //           context, "Please select Switch Category for Lab ${i + 1}");
  //       return;
  //     }
  //
  //     if (lab.switchParts == null) {
  //       AppToast.showError(context,
  //           "Please select No. of port Ethernet switch for Lab ${i + 1}");
  //       return;
  //     }
  //   }
  //
  //   // ✅ Sab validation pass ho gaya
  //   AppToast.showSuccess(context, "Exam infrastructure details saved");
  //   Get.to(() => const CenterDetailsPage4());
  // }

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
                  child: Text(
                    "Lab number ${index + 1}",
                    style: GoogleFonts.karla(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.floor,
            items: floors,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.floor = v),
            validator: (value) {},
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
          Text("System Processer", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.processor,
            items: processors,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.processor = v),
            validator: (value) {},
          ),

          const SizedBox(height: 15),
          Text("Monitor type", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.monitor,
            items: monitors,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.monitor = v),
            validator: (value) {},
          ),

          const SizedBox(height: 15),
          Text("Operating System", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.os,
            items: oss,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.os = v),
            validator: (value) {},
          ),

          const SizedBox(height: 15),
          Text("RAM (in GB)", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.ram,
            items: rams,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.ram = v),
            validator: (value) {},
          ),

          const SizedBox(height: 15),
          Text("Hard Disk Drive Capacity in GB", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.hardDisk,
            items: hardDisks,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.hardDisk = v),
            validator: (value) {},
          ),

          const SizedBox(height: 15),
          Text("Ethernet Switch Company", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.switchCompany,
            items: switchCompanies,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.switchCompany = v),
            validator: (value) {},
          ),

          const SizedBox(height: 15),
          Text("Switch Category", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.switchCategory,
            items: switchCategories,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.switchCategory = v),
            validator: (value) {},
          ),

          const SizedBox(height: 15),
          Text("No. of part Ethernet switch", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: lab.switchParts,
            items: switchParts,
            itemLabel: (v) => v,
            onChanged: (v) => setState(() => lab.switchParts = v),
            validator: (value) {},
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
                  child: Text("Step 3", style: AppTextStyles.bodyStepText),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Exam Infrastructure details",
                    style: AppTextStyles.centerDetailsTopTitle,
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Please enter the required information",
                    style: AppTextStyles.centerSubTitle,
                  ),
                ),
                const SizedBox(height: 20),

                // ===== General Lab Details =====
                Text(
                  "General Lab details",
                  style: GoogleFonts.karla(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                Text("Total number of systems",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: totalSystemsController,
                  keyboardType: TextInputType.number,
                  label: '',
                ),

                const SizedBox(height: 15),
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
                Text("Total Network", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: totalNetworkController,
                  keyboardType: TextInputType.text,
                  label: '',
                ),

                const SizedBox(height: 15),
                Text("Is there a partition in each System",
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
                Text("Is there a sound system in each lab?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedSoundSystem,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedSoundSystem = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
                Text("How Many Fire Extinguisher in each lab",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedFireExit,
                  items: [
                    '0',
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10'
                  ],
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedFireExit = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 15),
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
                Text("Is there a drinking water facility in/near the labs?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedDrinkingWater,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) => setState(() => selectedDrinkingWater = v),
                  validator: (value) {},
                ),

                const SizedBox(height: 30),

                // ===== Lab Infrastructure =====
                Text(
                  "Lab Infrastructure",
                  style: GoogleFonts.karla(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),
                Text("Name of the Primary ISP",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: primaryISPController,
                  keyboardType: TextInputType.text,
                  label: '',
                ),

                const SizedBox(height: 15),
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
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppTextField(
                        controller: primaryInternetController,
                        keyboardType: TextInputType.number,
                        label: '',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomDropdown<String>(
                        hintText: "Unit",
                        value: selectedPrimarySpeed,
                        items: speeds,
                        itemLabel: (v) => v,
                        onChanged: (v) =>
                            setState(() => selectedPrimarySpeed = v),
                        validator: (value) {},
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                Text("Name of the Secondary ISP",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: secondaryISPController,
                  keyboardType: TextInputType.text,
                  label: '',
                ),

                const SizedBox(height: 15),
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
                Text("Secondary Internet Speed",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppTextField(
                        controller: secondaryInternetController,
                        keyboardType: TextInputType.number,
                        label: '',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomDropdown<String>(
                        hintText: "Unit",
                        value: selectedSecondarySpeed,
                        items: speeds,
                        itemLabel: (v) => v,
                        onChanged: (v) =>
                            setState(() => selectedSecondarySpeed = v),
                        validator: (value) {},
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                Text("Generator Available", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedGenerator,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) {
                    setState(() {
                      selectedGenerator = v;
                      if (selectedGenerator == "No") {
                        generatorCapacityController.clear();
                        selectedUPSBackupTime = null;
                      }
                    });
                  },
                  validator: (value) {},
                ),

                if (selectedGenerator == "Yes") ...[
                  const SizedBox(height: 15),
                  Text("Generator Capacity (in KVA)",
                      style: AppTextStyles.centerText),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: generatorCapacityController,
                    keyboardType: TextInputType.number,
                    label: '',
                  ),

                  const SizedBox(height: 15),
                  Text("Generator full tank Capacity (ltr)",
                      style: AppTextStyles.centerText),
                  const SizedBox(height: 8),
                  CustomDropdown<String>(
                    hintText: "Select",
                    value: tankCapacityLtrTime,
                    items: tankCapacityLtr,
                    itemLabel: (v) => v,
                    onChanged: (v) =>
                        setState(() => tankCapacityLtrTime = v),
                    validator: (value) => null,
                  ),
                ],

                const SizedBox(height: 15),
                Text("UPS Backup", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: upsBackupController,
                  keyboardType: TextInputType.text,
                  label: '',
                ),
                const SizedBox(height: 15),
                Text("Ups Backup time (in mins)",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedUPSBackupTime,
                  items: upsBackupTimeOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) =>
                      setState(() => selectedUPSBackupTime = v),
                  validator: (value) => null,
                ),
                const SizedBox(height: 30),
                Text("Lab Details",
                    style: GoogleFonts.karla(
                        fontSize: 18, fontWeight: FontWeight.bold)),

                // ===== Dynamic Lab Boxes =====
                ...List.generate(labs.length, (index) => _buildLabBox(index)),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(color: const Color(0xffDDDDDD)),
                          ),
                          height: 48,
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Go Back",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.centerText,
                            ),
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
                        onPressed: (){
                          Get.to(() => const CenterDetailsPage4());
                        },
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
