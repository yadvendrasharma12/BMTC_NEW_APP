
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../../widgets/selectabe_tile.dart';
import '../../../widgets/uploading_container.dart';
import '../../add_center_pages/center_details_page2.dart';
import '../../add_center_pages/center_details_page3.dart';

class EditCenterInformationScreen extends StatefulWidget {
  const EditCenterInformationScreen({super.key});


  @override
  State<EditCenterInformationScreen> createState() => _EditCenterInformationScreenState();
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


class _EditCenterInformationScreenState extends State<EditCenterInformationScreen> {
  final TextEditingController centerNameController = TextEditingController();
  final TextEditingController centerDescriptionController =
  TextEditingController();
  final TextEditingController portalAddressController =
  TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController centerCapacityController =
  TextEditingController();
  final TextEditingController localAreaController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController railwayStationNameController =
  TextEditingController();
  final TextEditingController busStationNameController =
  TextEditingController();
  final TextEditingController metroStationNameController =
  TextEditingController();
  final TextEditingController airportNameController = TextEditingController();

  // ✅ Dropdown values
  String? selectedCenterType;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String? selectedTestCenterCategory;
  String? selectedRailwayDistance;
  String? selectedBusDistance;
  String? selectedMetroDistance;
  String? selectedAirportDistance;

  // ✅ Lift availability (Yes/No)
  bool? isLiftAvailable; // null / true / false

  // ✅ Sample dropdown data
  final List<String> centerTypes = [
    'Online'
  ];
  final List<String> countries = ['India', 'USA', 'UK'];
  final List<String> states = ['Karnataka', 'Maharashtra', 'Delhi'];
  final List<String> cities = ['Bangalore', 'Mysore', 'Mumbai', 'Delhi'];
  final List<String> categoryTypes = ['University', 'School', 'ITI Collage','University'];
  final List<String> distanceOptions = [
    '100 Meters', '200 Meters', '300 Meters', '400 Meters', '500 Meters', '600 Meters', '700 Meters', '800 Meters', '900 Meters', '1000 Meters',
    '1.10 km', '1.20 km','1.30 km','1.40 km','1.50 km','1.60 km','1.70 km','1.80 km','1.90 km','2 km',
    '2.10 km', '2.20 km','2.30 km','2.40 km','2.50 km','2.60 km','2.70 km','2.80 km','2.90 km','3 km',
    '3.10 km', '3.20 km','3.30 km','3.40 km','3.50 km','3.60 km','3.70 km','3.80 km','3.90 km','4 km',
    '4.10 km', '4.20 km','4.30 km','4.40 km','4.50 km','4.60 km','4.70 km','4.80 km','4.90 km','5 km',
    '5.10 km', '5.20 km','5.30 km','5.40 km','5.50 km','5.60 km','5.70 km','5.80 km','5.90 km','6 km',
    '6.10 km', '6.20 km','6.30 km','6.40 km','6.50 km','6.60 km','6.70 km','6.80 km','6.90 km','7 km',
    '7.10 km', '7.20 km','7.30 km','7.40 km','7.50 km','7.60 km','7.70 km','7.80 km','7.90 km','8 km',
    '8.10 km', '8.20 km','8.30 km','8.40 km','8.50 km','8.60 km','8.70 km','8.80 km','8.90 km','9 km',
    '9.10 km', '9.20 km','9.30 km','9.40 km','9.50 km','9.60 km','9.70 km','9.80 km','9.90 km','10 km',
    '10.10 km', '10.20 km','`10`.30 km','10.40 km','10.50 km','10.60 km','10.70 km','10.80 km','10.90 km','11 km',
  ];

  File? entranceFile;
  String? entranceFileName;
  int? entranceFileSizeBytes;

  File? labPhotoFile;
  String? labPhotoFileName;
  int? labPhotoFileSizeBytes;

  File? mainGateFile;
  String? mainGateFileName;
  int? mainGateFileSizeBytes;

  File? serverRoomFile;
  String? serverRoomFileName;
  int? serverRoomFileSizeBytes;

  File? conferenceRoomFile;
  String? conferenceRoomFileName;
  int? conferenceRoomFileSizeBytes;

  File? upsGeneratorFile;
  String? upsGeneratorFileName;
  int? upsGeneratorFileSizeBytes;

  File? walkthroughVideoFile;
  String? walkthroughVideoFileName;
  int? walkthroughVideoFileSizeBytes;

  @override
  void dispose() {
    // ✅ Dispose controllers
    centerNameController.dispose();
    centerDescriptionController.dispose();
    portalAddressController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    centerCapacityController.dispose();
    localAreaController.dispose();
    pinCodeController.dispose();
    landmarkController.dispose();
    railwayStationNameController.dispose();
    busStationNameController.dispose();
    metroStationNameController.dispose();
    airportNameController.dispose();
    super.dispose();
  }

  bool _isNumeric(String value) {
    return double.tryParse(value) != null;
  }


  Future<PlatformFile?> _pickImageFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return null;

    final file = result.files.first;
    final sizeInMB = file.size / (1024 * 1024);

    if (sizeInMB > 1) {
      AppToast.showError(Get.context!, "File size must be less than 1 MB");
      return null;
    }

    return file;
  }


  Future<PlatformFile?> _pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'webm'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return null;

    final file = result.files.first;
    final sizeInMB = file.size / (1024 * 1024);

    if (sizeInMB > 5) {
      AppToast.showError(Get.context!, "Video size must be less than 5 MB");
      return null;
    }

    return file;
  }



  Future<void> _pickEntranceFile() async {
    try {
      final file = await _pickImageFile();
      if (file == null) return;

      setState(() {
        entranceFileName = file.name;
        entranceFileSizeBytes = file.size;
        entranceFile = file.path != null ? File(file.path!) : null;
      });

      AppToast.showSuccess(context, "Entrance file selected");
    } catch (e) {
      AppToast.showError(context, "Failed to pick Entrance file");
    }
  }

  Future<void> _pickLabPhotoFile() async {
    try {
      final file = await _pickImageFile();
      if (file == null) return;

      setState(() {
        labPhotoFileName = file.name;
        labPhotoFileSizeBytes = file.size;
        labPhotoFile = file.path != null ? File(file.path!) : null;
      });

      AppToast.showSuccess(context, "Lab photo selected");
    } catch (e) {
      AppToast.showError(context, "Failed to pick Lab photo");
    }
  }

  Future<void> _pickMainGateFile() async {
    try {
      final file = await _pickImageFile();
      if (file == null) return;

      setState(() {
        mainGateFileName = file.name;
        mainGateFileSizeBytes = file.size;
        mainGateFile = file.path != null ? File(file.path!) : null;
      });

      AppToast.showSuccess(context, "Main Gate photo selected");
    } catch (e) {
      AppToast.showError(context, "Failed to pick Main Gate photo");
    }
  }

  Future<void> _pickServerRoomFile() async {
    try {
      final file = await _pickImageFile();
      if (file == null) return;

      setState(() {
        serverRoomFileName = file.name;
        serverRoomFileSizeBytes = file.size;
        serverRoomFile = file.path != null ? File(file.path!) : null;
      });

      AppToast.showSuccess(context, "Server Room photo selected");
    } catch (e) {
      AppToast.showError(context, "Failed to pick Server Room photo");
    }
  }

  Future<void> _pickConferenceRoomFile() async {
    try {
      final file = await _pickImageFile();
      if (file == null) return;

      setState(() {
        conferenceRoomFileName = file.name;
        conferenceRoomFileSizeBytes = file.size;
        conferenceRoomFile =
        file.path != null ? File(file.path!) : null;
      });

      AppToast.showSuccess(context, "Conference room photo selected");
    } catch (e) {
      AppToast.showError(context, "Failed to pick Conference room photo");
    }
  }

  Future<void> _pickUpsGeneratorFile() async {
    try {
      final file = await _pickImageFile();
      if (file == null) return;

      setState(() {
        upsGeneratorFileName = file.name;
        upsGeneratorFileSizeBytes = file.size;
        upsGeneratorFile = file.path != null ? File(file.path!) : null;
      });

      AppToast.showSuccess(context, "UPS/Generator photo selected");
    } catch (e) {
      AppToast.showError(context, "Failed to pick UPS/Generator photo");
    }
  }

  Future<void> _pickWalkthroughVideoFile() async {
    try {
      final file = await _pickVideoFile();
      if (file == null) return;

      setState(() {
        walkthroughVideoFileName = file.name;
        walkthroughVideoFileSizeBytes = file.size;
        walkthroughVideoFile =
        file.path != null ? File(file.path!) : null;
      });

      AppToast.showSuccess(context, "Walkthrough video selected");
    } catch (e) {
      AppToast.showError(context, "Failed to pick walkthrough video");
    }
  }

  void _validateAndNext() {
    // 🟥 BASIC TEXT FIELDS
    if (centerNameController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Center Name");
      return;
    }

    if (centerDescriptionController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Center Description");
      return;
    }

    if (selectedCenterType == null) {
      AppToast.showError(context, "Please select Center Type");
      return;
    }

    if (portalAddressController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Portal Address");
      return;
    }

    // 🟥 LAT / LONG
    if (latitudeController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Center Latitude");
      return;
    }
    if (!_isNumeric(latitudeController.text.trim())) {
      AppToast.showError(context, "Latitude must be a valid number");
      return;
    }

    if (longitudeController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Center Longitude");
      return;
    }
    if (!_isNumeric(longitudeController.text.trim())) {
      AppToast.showError(context, "Longitude must be a valid number");
      return;
    }

    // 🟥 CAPACITY
    if (centerCapacityController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Center Capacity");
      return;
    }
    if (!_isNumeric(centerCapacityController.text.trim())) {
      AppToast.showError(context, "Center Capacity must be a valid number");
      return;
    }

    // 🟥 COUNTRY / STATE / CITY / AREA / PINCODE
    if (selectedCountry == null) {
      AppToast.showError(context, "Please select Country");
      return;
    }
    if (selectedState == null) {
      AppToast.showError(context, "Please select State");
      return;
    }
    if (selectedCity == null) {
      AppToast.showError(context, "Please select City");
      return;
    }

    if (localAreaController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Area Name");
      return;
    }

    if (pinCodeController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Pincode");
      return;
    }
    if (!_isNumeric(pinCodeController.text.trim()) ||
        pinCodeController.text.trim().length != 6) {
      AppToast.showError(context, "Please enter valid 6 digit Pincode");
      return;
    }

    // 🟥 CATEGORY + LANDMARK
    if (selectedTestCenterCategory == null) {
      AppToast.showError(context, "Please select Test Center Category");
      return;
    }

    if (landmarkController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter nearby Landmark");
      return;
    }

    // 🟥 LIFT AVAILABILITY
    if (isLiftAvailable == null) {
      AppToast.showError(
        context,
        "Please select if Lift is available for PH candidate",
      );
      return;
    }

    // 🟥 RAILWAY
    if (railwayStationNameController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Railway Station Name");
      return;
    }
    if (selectedRailwayDistance == null) {
      AppToast.showError(
        context,
        "Please select Distance from main Railway Station",
      );
      return;
    }

    // 🟥 BUS
    if (busStationNameController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Bus Station Name");
      return;
    }
    if (selectedBusDistance == null) {
      AppToast.showError(
        context,
        "Please select Distance from Bus Station",
      );
      return;
    }

    // 🟥 METRO
    if (metroStationNameController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Metro Station Name");
      return;
    }
    if (selectedMetroDistance == null) {
      AppToast.showError(
        context,
        "Please select Distance from Metro Station",
      );
      return;
    }

    // 🟥 AIRPORT
    if (airportNameController.text.trim().isEmpty) {
      AppToast.showError(context, "Please enter Airport Name");
      return;
    }
    if (selectedAirportDistance == null) {
      AppToast.showError(
        context,
        "Please select Distance from main Airport",
      );
      return;
    }


    AppToast.showSuccess(context, "All details validated");

  }

  Widget _fileInfoText(String? name, int? sizeBytes) {
    if (name == null || sizeBytes == null) return const SizedBox.shrink();
    final sizeInKB = sizeBytes / 1024;
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8),
      child: Text(
        "Selected: $name (${sizeInKB.toStringAsFixed(2)} KB)",
        style: AppTextStyles.centerSubTitle,
      ),
    );
  }
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


  List<LabDetail> labs = [LabDetail()];
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
  final TextEditingController centersNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController gstStateController = TextEditingController();
  final TextEditingController udhaiController = TextEditingController();
  final TextEditingController udhayamController = TextEditingController();

  // ✅ Yes/No selections
  String? hasGST; // "Yes" or "No"
  String? hasMSME; // "Yes" or "No"


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
            padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                    "Center details",
                    style: AppTextStyles.heading2
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    Text("What is the Center Name?", style: AppTextStyles.centerText),
                    const SizedBox(height: 10),
                    AppTextField(
                      controller: centerNameController,
                      keyboardType: TextInputType.text,
                      label: "",
                      hintText: "",
                    ),
                    const SizedBox(height: 12),

                    // 🔹 Center Description
                    Text(
                      "What is the Center Postal Address",
                      style: AppTextStyles.centerText,
                    ),
                    const SizedBox(height: 10),
                    AppTextField(
                      controller: centerDescriptionController,
                      keyboardType: TextInputType.text,
                      label: "",
                      hintText: "",
                    ),
                    const SizedBox(height: 12),

                    // 🔹 Center Type
                    Text("Center Type", style: AppTextStyles.centerText),
                    const SizedBox(height: 10),
                    CustomDropdown<String>(
                      hintText: "Select Center Type",
                      value: selectedCenterType,
                      items: centerTypes,
                      itemLabel: (value) => value,
                      onChanged: (value) {
                        setState(() {
                          selectedCenterType = value;
                        });
                      },
                      validator: (_) {},
                    ),

                    const SizedBox(height: 16),

                    // 🔹 Latitude
                    Text("Center’s Latitude", style: AppTextStyles.centerText),
                    const SizedBox(height: 10),
                    AppTextField(
                      label: "",
                      hintText: "",
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      controller: latitudeController,
                    ),
                    const SizedBox(height: 10),

                    // 🔹 Longitude
                    Text("Center’s Longitude", style: AppTextStyles.centerText),
                    const SizedBox(height: 10),
                    AppTextField(
                      label: "",
                      hintText: "",
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      controller: longitudeController,
                    ),
                    const SizedBox(height: 10),

                    // 🔹 Location buttons
                    Row(
                      children: [
                        Expanded(
                          child: CustomContainer(
                            icon: Icons.my_location,
                            text: "Current Location",
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomContainer(
                            icon: Icons.location_on_outlined,
                            text: "Location By Map",
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),



                    // Entrance
                    Text("Upload Center Entrance",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 10),
                    UploadingContainer(
                      buttonText: "Upload File",
                      infoText:
                      "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                      onPressed: _pickEntranceFile,
                    ),
                    _fileInfoText(entranceFileName, entranceFileSizeBytes),

                    SizedBox(height: 16,),

                    Text("Lab Photos", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    UploadingContainer(
                      buttonText: "Upload File",
                      infoText:
                      "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                      onPressed: _pickLabPhotoFile,
                    ),
                    _fileInfoText(labPhotoFileName, labPhotoFileSizeBytes),
                    SizedBox(height: 16,),
                    Text("Main Gate/Entrance",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    UploadingContainer(
                      buttonText: "Upload File",
                      infoText:
                      "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                      onPressed: _pickMainGateFile,
                    ),
                    _fileInfoText(mainGateFileName, mainGateFileSizeBytes),

                    SizedBox(height: 16,),
                    Text("Server Room", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    UploadingContainer(
                      buttonText: "Upload File",
                      infoText:
                      "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                      onPressed: _pickServerRoomFile,
                    ),
                    _fileInfoText(serverRoomFileName, serverRoomFileSizeBytes),

                    SizedBox(height: 16,),
                    Text("Observer/Conference room",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    UploadingContainer(
                      buttonText: "Upload File",
                      infoText:
                      "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                      onPressed: _pickConferenceRoomFile,
                    ),
                    _fileInfoText(
                        conferenceRoomFileName, conferenceRoomFileSizeBytes),

                    SizedBox(height: 16,),
                    Text("UPS & Generator photo",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    UploadingContainer(
                      buttonText: "Upload File",
                      infoText:
                      "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                      onPressed: _pickUpsGeneratorFile,
                    ),
                    _fileInfoText(upsGeneratorFileName, upsGeneratorFileSizeBytes),

                    SizedBox(height: 16,),
                    Text("Center Walkthrough video",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    UploadingContainer(
                      buttonText: "Upload File",
                      infoText:
                      "Max Each file size: 5 MB | File type: mp4, webm",
                      onPressed: _pickWalkthroughVideoFile,
                    ),
                    _fileInfoText(
                        walkthroughVideoFileName, walkthroughVideoFileSizeBytes),
                    const SizedBox(height: 16),

                    // 🔹 Country / State / City
                    Text("Country", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    CustomDropdown<String>(
                      hintText: "Select Country",
                      value: selectedCountry,
                      items: countries,
                      itemLabel: (value) => value,
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                      validator: (_) {},
                    ),
                    const SizedBox(height: 16),

                    Text("State", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    CustomDropdown<String>(
                      hintText: "Select State",
                      value: selectedState,
                      items: states,
                      itemLabel: (value) => value,
                      onChanged: (value) {
                        setState(() {
                          selectedState = value;
                        });
                      },
                      validator: (_) {},
                    ),
                    const SizedBox(height: 16),

                    Text("City", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    CustomDropdown<String>(
                      hintText: "Select City",
                      value: selectedCity,
                      items: cities,
                      itemLabel: (value) => value,
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                      validator: (_) {},
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Area Name
                    Text("Area Name", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      label: "",
                      hintText: "",
                      keyboardType: TextInputType.text,
                      controller: localAreaController,
                    ),
                    const SizedBox(height: 16),

                    // 🔹 PinCode
                    Text("PinCode", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      label: "",
                      hintText: "",
                      keyboardType: TextInputType.number,
                      controller: pinCodeController,
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Test center category
                    Text(
                      "What is the Category of your Test Center?",
                      style: AppTextStyles.centerText,
                    ),
                    const SizedBox(height: 8),
                    CustomDropdown<String>(
                      hintText: "Select Category",
                      value: selectedTestCenterCategory,
                      items: categoryTypes,
                      itemLabel: (value) => value,
                      onChanged: (value) {
                        setState(() {
                          selectedTestCenterCategory = value;
                        });
                      },
                      validator: (_) {},
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Landmark
                    Text("Any nearby Landmark",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      label: "",
                      hintText: "",
                      keyboardType: TextInputType.text,
                      controller: landmarkController,
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Lift availability Yes/No
                    Text(
                      "Is the Lift available for Physically Handicapped Candidate?",
                      style: AppTextStyles.centerText,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: SelectableTile(
                            value: isLiftAvailable == true,
                            text: "Yes",
                            onChanged: (val) {
                              setState(() {
                                isLiftAvailable = true;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SelectableTile(
                            value: isLiftAvailable == false,
                            text: "No",
                            onChanged: (val) {
                              setState(() {
                                isLiftAvailable = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),


                    Text("Name of Railway Station",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      label: "",
                      hintText: "",
                      keyboardType: TextInputType.text,
                      controller: railwayStationNameController,
                    ),
                    const SizedBox(height: 16),

                    Text("Distance from the main Railway Station",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    CustomDropdown<String>(
                      hintText: "Select Distance",
                      value: selectedRailwayDistance,
                      items: distanceOptions,
                      itemLabel: (value) => value,
                      onChanged: (value) {
                        setState(() {
                          selectedRailwayDistance = value;
                        });
                      },
                      validator: (_) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Bus
                    Text("Name of Bus Station",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      label: "",
                      hintText: "",
                      keyboardType: TextInputType.text,
                      controller: busStationNameController,
                    ),
                    const SizedBox(height: 16),

                    Text("Distance from the nearby Bus Station",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    CustomDropdown<String>(
                      hintText: "Select Distance",
                      value: selectedBusDistance,
                      items: distanceOptions,
                      itemLabel: (value) => value,
                      onChanged: (value) {
                        setState(() {
                          selectedBusDistance = value;
                        });
                      },
                      validator: (_) {},
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Metro
                    Text("Name of Metro Station",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      label: "",
                      hintText: "",
                      keyboardType: TextInputType.text,
                      controller: metroStationNameController,
                    ),
                    const SizedBox(height: 16),

                    Text("Distance from the main Metro Station",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    CustomDropdown<String>(
                      hintText: "Select Distance",
                      value: selectedMetroDistance,
                      items: distanceOptions,
                      itemLabel: (value) => value,
                      onChanged: (value) {
                        setState(() {
                          selectedMetroDistance = value;
                        });
                      },
                      validator: (_) {},
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Airport
                    Text("Name of Airport", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    AppTextField(
                      label: "",
                      hintText: "",
                      keyboardType: TextInputType.text,
                      controller: airportNameController,
                    ),
                    const SizedBox(height: 16),

                    Text("Distance from the main Airport",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    CustomDropdown<String>(
                      hintText: "Select Distance",
                      value: selectedAirportDistance,
                      items: distanceOptions,
                      itemLabel: (value) => value,
                      onChanged: (value) {
                        setState(() {
                          selectedAirportDistance = value;
                        });
                      },
                      validator: (_) {},
                    ),

                  ],),
                ),
                const SizedBox(height: 24),
                Column(
                  children: [


                    const SizedBox(height: 21),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Admin Details",
                            style: GoogleFonts.karla(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 14),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.borderColor),
                                borderRadius: BorderRadius.circular(10)
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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


                            ],),
                          ),
                          const SizedBox(height: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const SizedBox(height: 20),


                              Text(
                                "Infrastructure details",
                                  style: AppTextStyles.heading2
                              ),
                              const SizedBox(height: 6),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "General lab details",
                                        style: AppTextStyles.dashBordButton3
                                    ),
                                    const SizedBox(height: 14),
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
                                          // Agar No select kare to values clear kar do
                                          if (selectedGenerator == "No") {
                                            generatorCapacityController.clear();
                                            selectedUPSBackupTime = null;
                                          }
                                        });
                                      },
                                      validator: (value) {},
                                    ),

                                    // ==== Generator Yes hone par hi yeh fields dikhenge ====
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


                                  ],),
                              ),

                              const SizedBox(height: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Bank details",
                                      style: AppTextStyles.heading2
                                  ),
                                  const SizedBox(height: 15),

                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.borderColor),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                        Text("Bank IFSC code", style: AppTextStyles.centerText),
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
                                            controller: udhayamController,
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
                                    ],),
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
                                          text: "Save",
                                          onPressed: _validateAndNext,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
