import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/toast_message.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/selectabe_tile.dart';
import '../../widgets/uploading_container.dart';
import '../../widgets/custom_button.dart';
import '../../core/app_colors.dart';
import '../../core/text_style.dart';
import 'center_details_page2.dart';

class CenterDetailsPage1 extends StatefulWidget {
  const CenterDetailsPage1({super.key});

  @override
  State<CenterDetailsPage1> createState() => _CenterDetailsPage1State();
}

class _CenterDetailsPage1State extends State<CenterDetailsPage1> {
  // ✅ Text Controllers
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
  final List<String> centerTypes = ['Online'];
  final List<String> countries = ['India', 'USA', 'UK'];
  final List<String> states = ['Karnataka', 'Maharashtra', 'Delhi'];
  final List<String> cities = ['Bangalore', 'Mysore', 'Mumbai', 'Delhi'];

  // ✅ FIXED: removed duplicate 'University' and fixed typo 'College'
  final List<String> categoryTypes = [
    'University',
    'School',
    'ITI College',
  ];

  // NOTE: distanceOptions cleaned minor backtick typo
  final List<String> distanceOptions = [
    '100 Meters',
    '200 Meters',
    '300 Meters',
    '400 Meters',
    '500 Meters',
    '600 Meters',
    '700 Meters',
    '800 Meters',
    '900 Meters',
    '1000 Meters',
    '1.10 km',
    '1.20 km',
    '1.30 km',
    '1.40 km',
    '1.50 km',
    '1.60 km',
    '1.70 km',
    '1.80 km',
    '1.90 km',
    '2 km',
    '2.10 km',
    '2.20 km',
    '2.30 km',
    '2.40 km',
    '2.50 km',
    '2.60 km',
    '2.70 km',
    '2.80 km',
    '2.90 km',
    '3 km',
    '3.10 km',
    '3.20 km',
    '3.30 km',
    '3.40 km',
    '3.50 km',
    '3.60 km',
    '3.70 km',
    '3.80 km',
    '3.90 km',
    '4 km',
    '4.10 km',
    '4.20 km',
    '4.30 km',
    '4.40 km',
    '4.50 km',
    '4.60 km',
    '4.70 km',
    '4.80 km',
    '4.90 km',
    '5 km',
    '5.10 km',
    '5.20 km',
    '5.30 km',
    '5.40 km',
    '5.50 km',
    '5.60 km',
    '5.70 km',
    '5.80 km',
    '5.90 km',
    '6 km',
    '6.10 km',
    '6.20 km',
    '6.30 km',
    '6.40 km',
    '6.50 km',
    '6.60 km',
    '6.70 km',
    '6.80 km',
    '6.90 km',
    '7 km',
    '7.10 km',
    '7.20 km',
    '7.30 km',
    '7.40 km',
    '7.50 km',
    '7.60 km',
    '7.70 km',
    '7.80 km',
    '7.90 km',
    '8 km',
    '8.10 km',
    '8.20 km',
    '8.30 km',
    '8.40 km',
    '8.50 km',
    '8.60 km',
    '8.70 km',
    '8.80 km',
    '8.90 km',
    '9 km',
    '9.10 km',
    '9.20 km',
    '9.30 km',
    '9.40 km',
    '9.50 km',
    '9.60 km',
    '9.70 km',
    '9.80 km',
    '9.90 km',
    '10 km',
    '10.10 km',
    '10.20 km',
    '10.30 km',
    '10.40 km',
    '10.50 km',
    '10.60 km',
    '10.70 km',
    '10.80 km',
    '10.90 km',
    '11 km',
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
        conferenceRoomFile = file.path != null ? File(file.path!) : null;
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
        walkthroughVideoFile = file.path != null ? File(file.path!) : null;
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

    // ✅ SAB VALID → NEXT PAGE
    AppToast.showSuccess(context, "All details validated");
    Get.to(() => const CenterDetailsPage2());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Top Heading
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text("Step 1", style: AppTextStyles.bodyStepText),
                      const SizedBox(height: 2),
                      Text(
                        "Center details",
                        style: AppTextStyles.centerDetailsTopTitle,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Please enter all the details of the center",
                        style: AppTextStyles.centerSubTitle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Center Name
                Text("Center Name", style: AppTextStyles.centerText),
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
                  "Center Description (About Center)",
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
                const SizedBox(height: 17),

                // 🔹 Portal Address
                Text("Center Portal Address?", style: AppTextStyles.centerText),
                const SizedBox(height: 10),
                AppTextField(
                  controller: portalAddressController,
                  keyboardType: TextInputType.text,
                  label: "",
                  hintText: "",
                ),
                const SizedBox(height: 12),

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
                        text: "Get Current Location",
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomContainer(
                        icon: Icons.location_on_outlined,
                        text: "Get Location By Map",
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 🔹 Capacity
                Text("Center Capacity", style: AppTextStyles.centerText),
                const SizedBox(height: 10),
                AppTextField(
                  label: "",
                  hintText: "",
                  keyboardType: TextInputType.number,
                  controller: centerCapacityController,
                ),
                const SizedBox(height: 12),

                // Entrance
                Text("Upload Center Entrance", style: AppTextStyles.centerText),
                const SizedBox(height: 10),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                  onPressed: _pickEntranceFile,
                ),
                _fileInfoText(entranceFileName, entranceFileSizeBytes),

                const SizedBox(height: 16),

                Text("Lab Photos", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                  onPressed: _pickLabPhotoFile,
                ),
                _fileInfoText(labPhotoFileName, labPhotoFileSizeBytes),
                const SizedBox(height: 16),
                Text("Main Gate/Entrance", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                  onPressed: _pickMainGateFile,
                ),
                _fileInfoText(mainGateFileName, mainGateFileSizeBytes),

                const SizedBox(height: 16),
                Text("Server Room", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                  onPressed: _pickServerRoomFile,
                ),
                _fileInfoText(serverRoomFileName, serverRoomFileSizeBytes),

                const SizedBox(height: 16),
                Text("Observer/Conference room", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                  onPressed: _pickConferenceRoomFile,
                ),
                _fileInfoText(
                    conferenceRoomFileName, conferenceRoomFileSizeBytes),

                const SizedBox(height: 16),
                Text("UPS & Generator photo", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                  onPressed: _pickUpsGeneratorFile,
                ),
                _fileInfoText(upsGeneratorFileName, upsGeneratorFileSizeBytes),

                const SizedBox(height: 16),
                Text("Center Walkthrough video", style: AppTextStyles.centerText),
                const SizedBox(height: 8),
                UploadingContainer(
                  buttonText: "Upload File",
                  infoText: "Max Each file size: 5 MB | File type: mp4, webm",
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
                  validator: (_) {
                    return null;
                  },
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
                Text("Any nearby Landmark", style: AppTextStyles.centerText),
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

                Text("Name of Railway Station", style: AppTextStyles.centerText),
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
                Text("Name of Bus Station", style: AppTextStyles.centerText),
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
                Text("Name of Metro Station", style: AppTextStyles.centerText),
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
                const SizedBox(height: 24),

                // ✅ FINAL NEXT BUTTON
                CustomPrimaryButton(
                  text: "Next",
                  icon: Icons.arrow_right_alt_rounded,
                  onPressed: _validateAndNext,
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
