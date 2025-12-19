import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/center_form_controller.dart';
import '../../core/app_colors.dart';
import '../../core/text_style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/custom_dropdown.dart';

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
  }
}

class _CenterDetailsPage3State extends State<CenterDetailsPage3> {


  final ExamCenterController examController = Get.find<ExamCenterController>();

  // Text Controllers for static fields
  final TextEditingController totalLabsController = TextEditingController();
  final TextEditingController totalSystemsController = TextEditingController();
  final TextEditingController totalNetworkController = TextEditingController();
  final TextEditingController primaryISPController = TextEditingController();
  final TextEditingController secondaryISPController = TextEditingController();
  final TextEditingController upsBackupController = TextEditingController();
  final TextEditingController primaryInternetController = TextEditingController();
  final TextEditingController secondaryInternetController = TextEditingController();
  final TextEditingController generatorCapacityController = TextEditingController();

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
  String? tankCapacityLtrTime;

  // Dropdown Data
  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> ispTypes = ['Broadband', 'Lease line', 'Fibre Optics', 'Air Fibre'];
  final List<String> speeds = ['Gbps', 'Mbps'];
  final List<String> floors = ['Ground', '1st', '2nd', '3rd','4th','5th','6th','7th','8th','9th','10th',"Basement"];
  final List<String> processors = ['Core 2 Duo','i3', 'i5', 'i7', 'i9'];
  final List<String> monitors = ['LCD', 'LED', 'CRT'];
  final List<String> oss = ['Win 7','Win 8', 'Win 10','Win 11','MacOS'];
  final List<String> rams = ['2GB', '4GB','8GB', '16GB','32GB',];
  final List<String> hardDisks = ['80GB', '128GB','160GB','256GB','512GB','1TB','2TB','4TB'];
  final List<String> switchCompanies = ['Cisco','Netgear', 'TP-Link', 'D-Link','Dex','Others'];
  final List<String> switchCategories = ['Unmanaged', 'Smart','Managed L2','Managed L3'];
  final List<String> switchParts = ['8','16','24','32'];
  final List<String> upsBackupTimeOptions = ['5 mins','10 mins','15 mins','20 mins','25 mins','30 mins','35 mins','40 mins','50 mins','60 mins',];
  final List<String> tankCapacityLtr = ['1 ltr',  '1.5 ltr','2 ltr', '2.5 ltr', '3 ltr', '3.5 ltr', '4 ltr', '4.5 ltr', '5 ltr',];

  @override
  void dispose() {

    totalSystemsController.dispose();
    totalNetworkController.dispose();
    primaryISPController.dispose();
    secondaryISPController.dispose();
    upsBackupController.dispose();
    primaryInternetController.dispose();
    secondaryInternetController.dispose();
    generatorCapacityController.dispose();
    for (var lab in examController.labs) {
      lab.dispose();
    }
    super.dispose();
  }



  Widget _buildLabBox(int index) {
    final lab = examController.labs[index];
    return Obx(() => Container(
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
                    examController.labs[index].dispose();
                    examController.labs.removeAt(index);
                  },
                ),
            ],
          ),
          const SizedBox(height: 15),
          Text("Floor Number", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: floors.contains(lab.floor.value) ? lab.floor.value : null,
            items: floors,
            itemLabel: (v) => v,
            onChanged: (v) => lab.floor.value = v ?? '',
            validator: (value) {
              return null;
            },
          ),
          const SizedBox(height: 15),
          Text("Total Number of computers", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          AppTextField(
            controller: lab.computersController,
            keyboardType: TextInputType.number,
            label: '',
            onChanged: (v) {},
          ),
          const SizedBox(height: 15),
          Text("System Processor", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: processors.contains(lab.processor.value)
                ? lab.processor.value
                : null,
            items: processors,
            itemLabel: (v) => v,
            onChanged: (v) => lab.processor.value = v ?? '',
            validator: (value) {},
          ),
          const SizedBox(height: 15),
          Text("Monitor type", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: monitors.contains(lab.monitor.value)
                ? lab.monitor.value
                : null,
            items: monitors,
            itemLabel: (v) => v,
            onChanged: (v) => lab.monitor.value = v ?? '',
            validator: (value) {},
          ),
          const SizedBox(height: 15),
          Text("Operating System", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: oss.contains(lab.os.value)
                ? lab.os.value
                : null,
            items: oss,
            itemLabel: (v) => v,
            onChanged: (v) => lab.os.value = v ?? '',
            validator: (value) {},
          ),
          const SizedBox(height: 15),
          Text("RAM (in GB)", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: rams.contains(lab.ram.value)
                ? lab.ram.value
                : null,
            items: rams,
            itemLabel: (v) => v,
            onChanged: (v) => lab.ram.value = v ?? '',
            validator: (value) {},
          ),
          const SizedBox(height: 15),
          Text("Hard Disk Drive Capacity in GB", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: hardDisks.contains(lab.hdd.value)
                ? lab.hdd.value
                : null,
            items: hardDisks,
            itemLabel: (v) => v,
            onChanged: (v) => lab.hdd.value = v ?? '',
            validator: (value) {},
          ),
          const SizedBox(height: 15),
          Text("Ethernet Switch Company", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: switchCompanies.contains(lab.ethernetCompany.value)
                ? lab.ethernetCompany.value
                : null,
            items: switchCompanies,
            itemLabel: (v) => v,
            onChanged: (v) => lab.ethernetCompany.value = v ?? '',
            validator: (value) {},
          ),
          const SizedBox(height: 15),
          Text("Switch Category", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: switchCategories.contains(lab.switchCategory.value)
                ? lab.switchCategory.value
                : null,
            items: switchCategories,
            itemLabel: (v) => v,
            onChanged: (v) => lab.switchCategory.value = v ?? '',
            validator: (value) {},
          ),
          const SizedBox(height: 15),
          Text("No. of part Ethernet switch", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: switchParts.contains(lab.ethernetPorts.value)
                ? lab.ethernetPorts.value
                : null,
            items: switchParts,
            itemLabel: (v) => v,
            onChanged: (v) => lab.ethernetPorts.value = v ?? '',
            validator: (value) {},
          ),
        ],
      ),
    ));
  }


  @override
  void initState() {
    super.initState();

    // ✅ Always keep at least 1 lab
    if (examController.labs.isEmpty) {
      examController.updateLabs(1);
      totalLabsController.text = "1";
      examController.totalNumberOfLab.value = 1;
    }
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
                  onChanged: (v) {
                    int count = int.tryParse(v) ?? 1;
                    if (count < 1) count = 1; // minimum 1 lab
                    totalLabsController.text = count.toString();
                    examController.totalNumberOfLab.value = count;
                    examController.updateLabs(count); // <-- this updates the lab list
                  },
                ),


                const SizedBox(height: 15),
                Text("Total number of systems",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: totalSystemsController,
                  keyboardType: TextInputType.number,
                  label: '',
                  onChanged: (v) => examController.totalNumberOfSystem.value = int.tryParse(v) ?? 0,
                ),

                const SizedBox(height: 15),
                Text("Are all labs connected through a single network?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                Obx(() => CustomDropdown<String>(
                  hintText: "Select",
                  items: yesNoOptions, // ['Yes', 'No']
                  itemLabel: (v) => v,

                  // ✅ IMPORTANT PART
                  value: examController.labAreConnectToSingleNetwork.value ? "Yes" : "No",

                  onChanged: (v) {
                    examController.labAreConnectToSingleNetwork.value =
                    (v == 'Yes');
                  },

                  validator: (value) {
                    if (value == null) {
                      return "Please select an option";
                    }
                    return null;
                  },
                )),

                const SizedBox(height: 15),
                Text("Total Network", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: totalNetworkController,
                  keyboardType: TextInputType.number,
                  label: '',
                  onChanged: (v) => examController.totalNetwork.value = int.tryParse(v) ?? 0,
                ),




                const SizedBox(height: 15),
                Text("Is there a partition in each lab",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),


                Obx(() => CustomDropdown<String>(
                  hintText: "Select",
                  items: yesNoOptions, // ['Yes','No']
                  itemLabel: (v) => v,
                  value: examController.partitionInEachLab.value ? "Yes" : "No",
                  onChanged: (v) {
                    examController.partitionInEachLab.value = (v == "Yes");
                  },
                  validator: (value) {
                    return null;
                  },
                )),


                const SizedBox(height: 15),
                Text("Is there an AC in each lab?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                Obx(() => CustomDropdown<String>(
                  hintText: "Select",
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  value: examController.acInEachLab.value ? "Yes" : "No",
                  onChanged: (v) {
                    examController.acInEachLab.value = (v == "Yes");
                  },
                  validator: (value) {},
                )),



                const SizedBox(height: 15),
                Text("Is the Network Printer available?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),

                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedPrinter,
                  items: yesNoOptions,
                  itemLabel: (v) => v,

                  onChanged: (v) {
                    setState(() => selectedPrinter = v);
                    examController.isNetworkPrinterAvailabel.value = (v == 'Yes');
                  },
                  validator: (value) {
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                Text("Is there a projector in each lab?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                Obx(() => CustomDropdown<String>(
                  hintText: "Select",
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  value: examController.isThereProjectorInEachLab.value ? "Yes" : "No",
                  onChanged: (v) {
                    examController.isThereProjectorInEachLab.value = (v == "Yes");
                  }, validator: (value) {  },
                )),

                const SizedBox(height: 15),
                Text("Is there a sound system in each lab?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedSoundSystem,
                  items: yesNoOptions,
                  itemLabel: (v) => v,
                  onChanged: (v) {
                    setState(() => selectedSoundSystem = v);
                    examController.isThereSoundSystemInEachLab.value = (v == 'Yes');
                  },
                  validator: (value) {
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                Text("How Many Fire Extinguisher in each lab",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                Obx(() => CustomDropdown<String>(
                  hintText: "Select",
                  items: List.generate(11, (index) => index.toString()),
                  itemLabel: (v) => v,
                  value: examController.fireExtinguisherInEachLab.value == 0
                      ? null
                      : examController.fireExtinguisherInEachLab.value.toString(),
                  onChanged: (v) {
                    examController.fireExtinguisherInEachLab.value =
                        int.tryParse(v ?? '0') ?? 0;
                  },
                  validator: (value) {
                    return null;
                  },
                )),

                const SizedBox(height: 15),
                Text("Is there a Locker facility?",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                CustomDropdown<String>(
                  hintText: "Select",
                  value: selectedMemory,
                  items: yesNoOptions,
                  itemLabel: (v) => v,

                  onChanged: (v) {
                    setState(() => selectedMemory = v);
                    examController.isThereALockerFacilityInLab.value = (v == 'Yes');
                  },
                  validator: (value) {
                    return null;
                  },
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

                  onChanged: (v) {
                    setState(() => selectedDrinkingWater = v);
                    examController.isThereADrinkingWaterFacilityInLab.value = (v == 'Yes');
                  },
                  validator: (value) {
                    return null;
                  },
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
                  onChanged: (v) => examController.primaryInfrastructure.value = v,

                ),

                const SizedBox(height: 15),
                Text("Primary ISP Connected Type",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                Obx(() => CustomDropdown<String>(
                  hintText: "Select",
                  items: ['Broadband', 'Lease line', 'Fibre Optics', 'Air Fibre'],
                  itemLabel: (v) => v,
                  value: examController.primaryIspConnectType.value.isNotEmpty
                      ? examController.primaryIspConnectType.value
                      : null,
                  onChanged: (v) {
                    examController.primaryIspConnectType.value = v ?? '';
                  },
                  validator: (value) {},
                )),



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
                        onChanged: (v) =>
                        examController.primaryIspSpeed.value = double.tryParse(v) ?? 0,
                      ),
                    ),
                    const SizedBox(width: 10),
              Expanded(
                child: Obx(() => CustomDropdown<String>(
                  hintText: "Unit",
                  items: speeds,
                  itemLabel: (v) => v,
                  value: examController.primaryInternetSpeedUnit.value.isNotEmpty
                      ? examController.primaryInternetSpeedUnit.value
                      : null,
                  onChanged: (v) {
                    examController.primaryInternetSpeedUnit.value = v ?? '';
                  },
                  validator: (value) {},
                )),
              )


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
                  onChanged: (v) => examController.secondaryInfrastructure.value = v,

                ),

                const SizedBox(height: 15),
                Text("Secondary ISP Connected Type",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                Obx(() => CustomDropdown<String>(
                  hintText: "Select",
                  items: ispTypes,
                  itemLabel: (v) => v,
                  value: examController.secondaryIspConnectType.value.isNotEmpty
                      ? examController.secondaryIspConnectType.value
                      : null,
                  onChanged: (v) {
                    examController.secondaryIspConnectType.value = v ?? '';
                  },
                  validator: (value) {},
                )),


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
                        onChanged: (v) =>
                        examController.secondaryIspSpeed.value = double.tryParse(v) ?? 0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() => CustomDropdown<String>(
                        hintText: "Unit",
                        items: speeds,
                        itemLabel: (v) => v,
                        value: examController.secondaryInternetSpeedUnit.value.isNotEmpty
                            ? examController.secondaryInternetSpeedUnit.value
                            : null,
                        onChanged: (v) {
                          examController.secondaryInternetSpeedUnit.value = v ?? '';
                        },
                        validator: (value) {},
                      )),
                    )

                  ],
                ),

                const SizedBox(height: 15),
                Text("Generator Available", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                Obx(() => Column(
                  children: [
                    CustomDropdown<String>(
                      hintText: "Select",
                      items: yesNoOptions,
                      itemLabel: (v) => v,
                      value: examController.isGeneratorBackup.value ? "Yes" : "No",
                      onChanged: (v) {
                        examController.isGeneratorBackup.value = (v == "Yes");
                      },
                      validator: (value) {},
                    ),

                    // Show generator fields only if Yes
                    if (examController.isGeneratorBackup.value) ...[
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Generator Capacity (in KVA)",
                            style: AppTextStyles.centerText),
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        controller: generatorCapacityController,
                        keyboardType: TextInputType.number,
                        label: '',
                        onChanged: (v) =>
                        examController.generatorBackupCapacity.value = double.tryParse(v) ?? 0,
                      ),

                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Generator full tank Capacity (ltr)",
                            style: AppTextStyles.centerText),
                      ),
                      const SizedBox(height: 8),
                      CustomDropdown<String>(
                        hintText: "Select",
                        items: tankCapacityLtr,
                        itemLabel: (v) => v,
                        value: examController.generatorFuelTankCapacity.value > 0
                            ? "${examController.generatorFuelTankCapacity.value % 1 == 0
                            ? examController.generatorFuelTankCapacity.value.toInt()
                            : examController.generatorFuelTankCapacity.value} ltr"
                            : null,
                        onChanged: (v) {
                          examController.generatorFuelTankCapacity.value =
                              double.tryParse(v?.replaceAll(" ltr", "") ?? "0") ?? 0;
                        },
                        validator: (value) => null,
                      )
                    ],
                  ],
                )),


                const SizedBox(height: 15),
                Text("UPS Backup", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                AppTextField(
                  controller: upsBackupController,
                  keyboardType: TextInputType.number,
                  label: '',
                  onChanged: (v) {
                    examController.upsBackup.value = v.toLowerCase() == "yes";
                  },
                ),
                const SizedBox(height: 15),
                Text("Ups Backup time (in mins)",
                    style: AppTextStyles.centerText),
                const SizedBox(height: 8),
              Obx(() => CustomDropdown<String>(
                hintText: "Select",
                items: upsBackupTimeOptions,
                itemLabel: (v) => v,
                value: examController.upsBackupTime.value > 0
                    ? "${examController.upsBackupTime.value.toInt()} mins"
                    : null,
                onChanged: (v) {
                  examController.upsBackupTime.value =
                      double.tryParse(v?.replaceAll(" mins", "") ?? "0") ?? 0;
                },
                validator: (value) => null,
              )),

              const SizedBox(height: 30),
                Text("Lab Details",
                    style: GoogleFonts.karla(
                        fontSize: 18, fontWeight: FontWeight.bold)),


                Obx(() => Column(
                  children: List.generate(
                    examController.labs.length,
                        (index) => _buildLabBox(index),
                  ),
                )),
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
                          _printStep3Data();
                          Get.to(() =>  CenterDetailsPage4());
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
  void _printStep3Data() {
    print("========== STEP 3 DATA DEBUG START ==========");

    print("Total Labs: ${examController.totalNumberOfLab.value}");
    print("Total Systems: ${examController.totalNumberOfSystem.value}");
    print("Total Network: ${examController.totalNetwork.value}");
    print("Single Network: ${examController.labAreConnectToSingleNetwork.value}");

    print("Partition In Each Lab: ${examController.partitionInEachLab}");
    print("Partition In Each Lab: ${examController.acInEachLab}");
    print("Fire Extinguisher In Each Lab: ${examController.fireExtinguisherInEachLab.value}");

    print("Network Printer: ${examController.isNetworkPrinterAvailabel.value}");
    print("Projector: ${examController.isThereProjectorInEachLab.value}");
    print("Sound System: ${examController.isThereSoundSystemInEachLab.value}");
    print("Locker Facility: ${examController.isThereALockerFacilityInLab.value}");
    print("Drinking Water: ${examController.isThereADrinkingWaterFacilityInLab.value}");

    print("------ INTERNET DETAILS ------");
    print("Primary ISP Name: ${examController.primaryInfrastructure.value}");
    print("Primary ISP Type: ${examController.primaryIspConnectType.value}");
    print("Primary Speed: ${examController.primaryIspSpeed.value} ${examController.primaryInternetSpeedUnit.value}");

    print("Secondary ISP Name: ${examController.secondaryInfrastructure.value}");
    print("Secondary ISP Type: ${examController.secondaryIspConnectType.value}");
    print("Secondary Speed: ${examController.secondaryIspSpeed.value} ${examController.secondaryInternetSpeedUnit.value}");

    print("------ POWER BACKUP ------");
    print("Generator Available: ${examController.isGeneratorBackup.value}");
    print("Generator Capacity: ${examController.generatorBackupCapacity.value}");
    print("Generator Tank Capacity: ${examController.generatorFuelTankCapacity.value}");

    print("UPS Backup: ${examController.upsBackup.value}");
    print("UPS Backup Time: ${examController.upsBackupTime.value}");

    print("------ LAB DETAILS ------");
    for (int i = 0; i < examController.labs.length; i++) {
      final lab = examController.labs[i];
      print("---- LAB ${i + 1} ----");
      print("Floor: ${lab.floor.value}");
      print("Total Computers: ${lab.computersController.text}");
      print("Processor: ${lab.processor.value}");
      print("Monitor: ${lab.monitor.value}");
      print("OS: ${lab.os.value}");
      print("RAM: ${lab.ram.value}");
      print("HDD: ${lab.hdd.value}");
      print("Ethernet Company: ${lab.ethernetCompany.value}");
      print("Switch Category: ${lab.switchCategory.value}");
      print("Ethernet Ports: ${lab.ethernetPorts.value}");
    }

    print("========== STEP 3 DATA DEBUG END ==========");
  }

}