import 'package:bmtc_app/app/core/text_style.dart';
import 'package:bmtc_app/app/screens/home/center_pages/edit_center_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../add_center_pages/center_details_page4.dart';

class CenterDetailsScreen extends StatefulWidget {
  const CenterDetailsScreen({super.key});

  @override
  State<CenterDetailsScreen> createState() => _CenterDetailsScreenState();
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

class _CenterDetailsScreenState extends State<CenterDetailsScreen> {
  // ===== Controllers for infra section =====
  final TextEditingController totalLabsController = TextEditingController();
  final TextEditingController totalSystemsController = TextEditingController();
  final TextEditingController totalNetworkController = TextEditingController();
  final TextEditingController primaryISPController = TextEditingController();
  final TextEditingController secondaryISPController = TextEditingController();
  final TextEditingController upsBackupController = TextEditingController();

  final TextEditingController primaryInternetController =
  TextEditingController();
  final TextEditingController secondaryInternetController =
  TextEditingController();

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

  // ===== Dropdown Data =====
  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> ispTypes = [
    'Broadband',
    'Lease line',
    'Fibre Optics',
    'Air Fibre'
  ];
  final List<String> speeds = ['Gbps', 'Mbps'];
  final List<String> floors = [
    'Ground',
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th',
    '9th',
    '10th',
    "Basement"
  ];
  final List<String> processors = ['Core 2 Duo', 'i3', 'i5', 'i7', 'i9'];
  final List<String> monitors = ['LCD', 'LED', 'CRT'];
  final List<String> oss = ['Win 7', 'Win 8', 'Win 10', 'Win 11', 'MacOS'];
  final List<String> rams = [
    '2GB',
    '4GB',
    '8GB',
    '16GB',
    '32GB',
  ];
  final List<String> hardDisks = [
    '80GB',
    '128GB',
    '160GB',
    '256GB',
    '512GB',
    '1TB',
    '2TB',
    '4TB'
  ];
  final List<String> switchCompanies = [
    'Cisco',
    'Netgear',
    'TP-Link',
    'D-Link',
    'Dex',
    'Others'
  ];
  final List<String> switchCategories = [
    'Unmanaged',
    'Smart',
    'Managed L2',
    'Managed L3'
  ];
  final List<String> switchParts = ['8', '16', '24', '32'];
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


  List<LabDetail> labs = [LabDetail()];


  final TextEditingController localTownController = TextEditingController();
  final TextEditingController mainCityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController railwayDistanceController =
  TextEditingController();
  final TextEditingController busDistanceController = TextEditingController();


  final TextEditingController pocNameController = TextEditingController();
  final TextEditingController pocDesignationController =
  TextEditingController();
  final TextEditingController pocPhoneController = TextEditingController();
  final TextEditingController pocAltPhoneController = TextEditingController();
  final TextEditingController pocEmailController = TextEditingController();


  final TextEditingController csNameController = TextEditingController();
  final TextEditingController csPhoneController = TextEditingController();
  final TextEditingController csEmailController = TextEditingController();

  final TextEditingController centerPhoneController = TextEditingController();
  final TextEditingController centerLandlineController =
  TextEditingController();


  final TextEditingController labInchargeNameController =
  TextEditingController();
  final TextEditingController labInchargePhoneController =
  TextEditingController();
  final TextEditingController labInchargeEmailController =
  TextEditingController();


  final TextEditingController beneficiaryNameController =
  TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController bankAccountNumberController =
  TextEditingController();
  final TextEditingController bankIfscController = TextEditingController();
  final TextEditingController panNumberController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController gstStateCodeController = TextEditingController();


  String? centerLocationType;
  String? liftAvailable;


  List<String> images = [
    "assets/images/image1.png",
    "assets/images/image2.png",
    "assets/images/image3.png",
    "assets/images/image4.png",
    "assets/images/image5.png",
    "assets/images/image6.png",
  ];

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

    localTownController.dispose();
    mainCityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    landmarkController.dispose();
    railwayDistanceController.dispose();
    busDistanceController.dispose();

    pocNameController.dispose();
    pocDesignationController.dispose();
    pocPhoneController.dispose();
    pocAltPhoneController.dispose();
    pocEmailController.dispose();

    csNameController.dispose();
    csPhoneController.dispose();
    csEmailController.dispose();

    centerPhoneController.dispose();
    centerLandlineController.dispose();

    labInchargeNameController.dispose();
    labInchargePhoneController.dispose();
    labInchargeEmailController.dispose();

    beneficiaryNameController.dispose();
    bankNameController.dispose();
    bankAccountNumberController.dispose();
    bankIfscController.dispose();
    panNumberController.dispose();
    gstNumberController.dispose();
    gstStateCodeController.dispose();

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
      while (labs.length < totalLabs) {
        labs.add(LabDetail());
      }
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
      AppToast.showError(
          context, "Please select if all labs are on single network");
      return;
    }

    if (totalNetworkController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Total Network");
      return;
    }

    if (selectedPartition == null) {
      AppToast.showError(context,
          "Please select if partition is available in each lab/system");
      return;
    }

    if (selectedAC == null) {
      AppToast.showError(
          context, "Please select if AC is available in each lab");
      return;
    }

    if (selectedPrinter == null) {
      AppToast.showError(
          context, "Please select if Network Printer is available");
      return;
    }

    if (selectedProjector == null) {
      AppToast.showError(
          context, "Please select if projector is available in each lab");
      return;
    }

    if (selectedSoundSystem == null) {
      AppToast.showError(
          context, "Please select if sound system is available in each lab");
      return;
    }

    if (selectedFireExit == null) {
      AppToast.showError(context, "Please select number of Fire Extinguisher");
      return;
    }

    if (selectedMemory == null) {
      AppToast.showError(
          context, "Please select if free baggage space is available");
      return;
    }

    if (selectedDrinkingWater == null) {
      AppToast.showError(context,
          "Please select if drinking water facility is available");
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

    if (!_isPositiveNumber(primaryInternetController.text)) {
      AppToast.showError(
          context, "Please enter valid Primary Internet Speed value");
      return;
    }

    if (selectedPrimarySpeed == null) {
      AppToast.showError(context, "Please select Primary Internet Speed unit");
      return;
    }

    if (secondaryISPController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Name of the Secondary ISP");
      return;
    }

    if (selectedSecondaryISPType == null) {
      AppToast.showError(
          context, "Please select Secondary ISP Connected Type");
      return;
    }

    if (!_isPositiveNumber(secondaryInternetController.text)) {
      AppToast.showError(
          context, "Please enter valid Secondary Internet Speed value");
      return;
    }

    if (selectedSecondarySpeed == null) {
      AppToast.showError(
          context, "Please select Secondary Internet Speed unit");
      return;
    }

    if (selectedGenerator == null) {
      AppToast.showError(context, "Please select if Generator is available");
      return;
    }

    if (selectedGenerator == "Yes") {
      if (generatorCapacityController.text.trim().isEmpty) {
        AppToast.showError(
            context, "Please enter Generator Capacity (in KVA)");
        return;
      }

      if (selectedUPSBackupTime == null) {
        AppToast.showError(context, "Please select UPS Backup Time (in mins)");
        return;
      }
    }

    if (upsBackupController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter UPS Backup details");
      return;
    }

    for (int i = 0; i < labs.length; i++) {
      final lab = labs[i];

      if (lab.floor == null) {
        AppToast.showError(
            context, "Please select Floor Number for Lab ${i + 1}");
        return;
      }

      if (!_isPositiveNumber(lab.computersController.text)) {
        AppToast.showError(context,
            "Please enter valid number of computers for Lab ${i + 1}");
        return;
      }

      if (lab.processor == null) {
        AppToast.showError(
            context, "Please select System Processor for Lab ${i + 1}");
        return;
      }

      if (lab.monitor == null) {
        AppToast.showError(
            context, "Please select Monitor Type for Lab ${i + 1}");
        return;
      }

      if (lab.os == null) {
        AppToast.showError(
            context, "Please select Operating System for Lab ${i + 1}");
        return;
      }

      if (lab.ram == null) {
        AppToast.showError(context, "Please select RAM GB for Lab ${i + 1}");
        return;
      }

      if (lab.hardDisk == null) {
        AppToast.showError(
            context, "Please select Hard Disk type for Lab ${i + 1}");
        return;
      }

      if (lab.switchCompany == null) {
        AppToast.showError(context,
            "Please select Ethernet Switch Company for Lab ${i + 1}");
        return;
      }

      if (lab.switchCategory == null) {
        AppToast.showError(
            context, "Please select Switch Category for Lab ${i + 1}");
        return;
      }

      if (lab.switchParts == null) {
        AppToast.showError(context,
            "Please select No. of port Ethernet switch for Lab ${i + 1}");
        return;
      }
    }


    AppToast.showSuccess(context, "Exam infrastructure details saved");
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
          // Header row
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
          Text("System Processor", style: AppTextStyles.centerText),
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
          Text("Hard Disk Drive Capacity in GB",
              style: AppTextStyles.centerText),
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
          Text("No. of port Ethernet switch", style: AppTextStyles.centerText),
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

  Widget _buildLocationRadio(String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4), // outer gap
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          color: Colors.white,
        ),
        child: RadioListTile<String>(
          value: label,
          groupValue: centerLocationType,
          dense: true,
          visualDensity: const VisualDensity(
            horizontal: -4, // thoda compact
            vertical: -4,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          onChanged: (val) {
            setState(() {
              centerLocationType = val;
            });
          },
          title: Text(
            label,
            style: AppTextStyles.centerText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }


  Widget _buildYesNoRadio(
      String groupValue,
      ValueChanged<String?> onChanged,
      ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 42, // 👈 overall box ki height control
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              color: Colors.white,
            ),
            child: RadioListTile<String>(
              value: "Yes",
              groupValue: groupValue,
              dense: true,
              visualDensity: const VisualDensity(
                horizontal: -4,
                vertical: -1.5,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 6),
              onChanged: onChanged,
              title: Text(
                "Yes",
                style: AppTextStyles.centerText.copyWith(fontSize: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              color: Colors.white,
            ),
            child: RadioListTile<String>(
              value: "No",
              groupValue: groupValue,
              dense: true,
              visualDensity: const VisualDensity(
                horizontal: -4,
                vertical: -1.5,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 6),
              onChanged: onChanged,
              title: Text(
                "No",
                style: AppTextStyles.centerText.copyWith(fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Center Images",
                      style: AppTextStyles.topHeading3,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(EditCenterInformationScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: AppColors.blackColor
                        ),
                        height: 36,
                        width: 130,
                        child: Row(children: [
                          Icon(Icons.edit_note_outlined,color: AppColors.background,),
                          SizedBox(width: 6,),
                          Text("Edit Center",style: AppTextStyles.button,)
                        ],)
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 22, right: 22, bottom: 12, top: 0),
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
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade100,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 17),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Last updated on 05/03/2025",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.caption,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Text(
                      "Center Details",
                      style: AppTextStyles.topHeading3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: 22, right: 22, bottom: 12, top: 0),
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Basic Details",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text("What is the Center Name?", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: localTownController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Center Description (about center)", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: mainCityController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Centers Postal Address", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: stateController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Center Latitude", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: pinCodeController,
                      keyboardType: TextInputType.number,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Center Longitude", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: pinCodeController,
                      keyboardType: TextInputType.number,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Center Capacity", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: pinCodeController,
                      keyboardType: TextInputType.number,
                      label: '',
                    ),
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Where is your Center Located",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        _buildLocationRadio("Private "),
                        const SizedBox(width: 10),
                        _buildLocationRadio("College"),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        _buildLocationRadio("School"),
                        const SizedBox(width: 10),
                        _buildLocationRadio("University"),
                      ],
                    ),
                    const SizedBox(height: 14),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Any Nearby Landmark",
                        style: AppTextStyles.centerText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: landmarkController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),

                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Is the Lift available for Physically Handicapped Candidate?",
                        style: AppTextStyles.centerText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildYesNoRadio(liftAvailable ?? "", (val) {
                      setState(() {
                        liftAvailable = val;
                      });
                    }),

                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Distance from the main Railway Station & the Name of the respective station?",
                        style: AppTextStyles.centerText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: railwayDistanceController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),

                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Distance from the nearby Bus Station & the Name of the Bus station?",
                        style: AppTextStyles.centerText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: busDistanceController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                  ],
                ),
              ),

              // ===== Admin Details =====
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Admin Details",
                      style: AppTextStyles.topHeading3,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: 22, right: 22, bottom: 12, top: 0),
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Point of contact Name",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text("Name", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: pocNameController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Designation", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: pocDesignationController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Phone number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: pocPhoneController,
                      keyboardType: TextInputType.phone,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Alternate Phone number",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: pocAltPhoneController,
                      keyboardType: TextInputType.phone,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Email", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: pocEmailController,
                      keyboardType: TextInputType.emailAddress,
                      label: '',
                    ),
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Center Superintendent details",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text("Name", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: csNameController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Phone", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: csPhoneController,
                      keyboardType: TextInputType.phone,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Email", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: csEmailController,
                      keyboardType: TextInputType.emailAddress,
                      label: '',
                    ),
                    const SizedBox(height: 18),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Center Contact Details",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text("Phone number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: centerPhoneController,
                      keyboardType: TextInputType.phone,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Landline phone number",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: centerLandlineController,
                      keyboardType: TextInputType.phone,
                      label: '',
                    ),
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Lab in charge",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text("Name", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: labInchargeNameController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Phone", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: labInchargePhoneController,
                      keyboardType: TextInputType.phone,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Email", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: labInchargeEmailController,
                      keyboardType: TextInputType.emailAddress,
                      label: '',
                    ),
                  ],
                ),
              ),

              // ===== Infrastructure details =====
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Infrastructure details",
                      style: AppTextStyles.topHeading3,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: 22, right: 22, bottom: 12, top: 0),
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
                      "General Lab details",
                      style: GoogleFonts.karla(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    Text("Total number of labs",
                        style: AppTextStyles.centerText),
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
                      onChanged: (v) =>
                          setState(() => selectedSoundSystem = v),
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
                      onChanged: (v) =>
                          setState(() => selectedDrinkingWater = v),
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
                    Text("Generator Available",
                        style: AppTextStyles.centerText),
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
                      Text("UPS Backup Time (in mins)",
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
                    ],

                    const SizedBox(height: 15),
                    Text("UPS Backup", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: upsBackupController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),

                    const SizedBox(height: 30),
                    Text("Lab Details",
                        style: GoogleFonts.karla(
                            fontSize: 18, fontWeight: FontWeight.bold)),

                    ...List.generate(labs.length, (index) => _buildLabBox(index)),


                    const SizedBox(height: 30),
                  ],
                ),
              ),

              // ===== Bank Details =====
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bank Details",
                      style: AppTextStyles.topHeading3,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: 22, right: 22, bottom: 12, top: 0),
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
                    Text("Beneficiary Name", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: beneficiaryNameController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Name of the bank", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: bankNameController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Bank account number",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: bankAccountNumberController,
                      keyboardType: TextInputType.number,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("Bank IFSC code", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: bankIfscController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("PAN Number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: panNumberController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("GST Number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: gstNumberController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
                    const SizedBox(height: 15),

                    Text("GST State Code", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: gstStateCodeController,
                      keyboardType: TextInputType.text,
                      label: '',
                    ),
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
                            onPressed: _validateAndNext,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
