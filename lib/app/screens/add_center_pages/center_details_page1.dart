import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/center_form_controller.dart';
import '../../models/city_modal.dart';
import '../../models/country_modal.dart';
import '../../models/state_modal.dart';
import '../../services/center_services.dart';
import '../../services/location_services/location_service.dart';
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
  final ExamCenterController examController = Get.find<ExamCenterController>();

  // ✅ Text Controllers
  final TextEditingController centerNameController = TextEditingController();
  final TextEditingController centerDescriptionController = TextEditingController();
  final TextEditingController portalAddressController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController centerCapacityController = TextEditingController();
  final TextEditingController localAreaController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController railwayStationNameController = TextEditingController();
  final TextEditingController busStationNameController = TextEditingController();
  final TextEditingController metroStationNameController = TextEditingController();
  final TextEditingController airportNameController = TextEditingController();

  String? selectedCenterType;

  String? selectedTestCenterCategory;
  String? selectedRailwayDistance;
  String? selectedBusDistance;
  String? selectedMetroDistance;
  String? selectedAirportDistance;

  bool? isLiftAvailable;

  // ✅ Sample dropdown data
  final List<String> centerTypes = ['Online'];
  final List<String> countries = ['India', 'USA', 'UK'];
  final List<String> states = ['Karnataka', 'Maharashtra', 'Delhi'];
  final List<String> cities = ['Bangalore', 'Mysore', 'Mumbai', 'Delhi'];




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


  String? categoryTypes;
  List<String> _categoryTypes = [];
  bool _isCenterTypeLoading = false;


  List<CountryModel> countryList = [];
  List<StateModel> stateList = [];
  List<CityModel> cityList = [];

  CountryModel? selectedCountry;
  StateModel? selectedState;
  CityModel? selectedCity;

  bool isCountryLoading = false;
  bool isStateLoading = false;
  bool isCityLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCenterTypes();
    _loadCountries();

  }

  Future<void> _fetchCenterTypes() async {
    setState(() {
      _isCenterTypeLoading = true;
    });

    final list = await CenterService.getCenterTypes();
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _categoryTypes = list.map((e) => e.centerType).toList();
      _isCenterTypeLoading = false;
    });

    if (list.isEmpty) {
      AppToast.showError(context, "Failed to load Center Types");
    }
  }

  Future<void> _loadCountries() async {
    setState(() => isCountryLoading = true);
    final list = await LocationService.getCountries();
    setState(() {
      countryList = list;
      isCountryLoading = false;
    });
  }
  Future<void> _loadStatesByCountry(String countryId) async {
    setState(() {
      isStateLoading = true;
      stateList = [];
      selectedState = null;
      cityList = [];
      selectedCity = null;
    });

    final list = await LocationService.getStates(countryId);
    setState(() {
      stateList = list;
      isStateLoading = false;
    });
  }
  Future<void> _loadCitiesByState(String stateId) async {
    setState(() {
      isCityLoading = true;
      cityList = [];
      selectedCity = null;
    });

    final list = await LocationService.getCities(stateId);
    setState(() {
      cityList = list;
      isCityLoading = false;
    });
  }

  double _convertDistanceToDouble(String? value) {
    if (value == null) return 0.0;

    final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }
  void _saveAndNext() {

    /// ✅ 1. TEXTFIELDS
    examController.centerName.value = centerNameController.text.trim();
    examController.centerDescription.value = centerDescriptionController.text.trim();
    examController.postalAddress.value = portalAddressController.text.trim();

    if (latitudeController.text.trim().isNotEmpty) {
      examController.addressLat.value =
          double.parse(latitudeController.text.trim());
    }

    if (longitudeController.text.trim().isNotEmpty) {
      examController.addressLong.value =
          double.parse(longitudeController.text.trim());
    }

    examController.capacity.value =
        int.tryParse(centerCapacityController.text.trim()) ?? 0;

    examController.localAreaName.value = localAreaController.text.trim();


    examController.nearbyLandmark.value = landmarkController.text.trim();

    examController.nearestRailwayStation.value =
        railwayStationNameController.text.trim();

    examController.nearestBusStop.value =
        busStationNameController.text.trim();

    examController.nearestMetroStation.value =
        metroStationNameController.text.trim();

    examController.nearestAirport.value =
        airportNameController.text.trim();

    /// ✅ 2. LIFT
    examController.isLiftAvailable.value = isLiftAvailable ?? false;

    /// ✅ 3. CENTER TYPE (ONLY API TYPE)
    examController.centerType.value = categoryTypes ?? "";

    /// ✅ 4. DISTANCES
    examController.distanceFromRailwayStation.value =
        _convertDistanceToDouble(selectedRailwayDistance);

    examController.distanceFromBusStop.value =
        _convertDistanceToDouble(selectedBusDistance);

    examController.distanceFromMetroStation.value =
        _convertDistanceToDouble(selectedMetroDistance);

    examController.distanceFromAirport.value =
        _convertDistanceToDouble(selectedAirportDistance);

    /// ✅ 5. LOCATION IDS (API SAFE)


    /// ✅ 6. FILES
    if (entranceFile != null) {
      examController.entranceFile.value = entranceFile;
    }
    if (labPhotoFile != null) {
      examController.labPhotoFile.value = labPhotoFile;
    }
    if (mainGateFile != null) {
      examController.mainGateFile.value = mainGateFile;
    }
    if (serverRoomFile != null) {
      examController.serverRoomFile.value = serverRoomFile;
    }
    if (conferenceRoomFile != null) {
      examController.conferenceRoomFile.value = conferenceRoomFile;
    }
    if (upsGeneratorFile != null) {
      examController.upsGeneratorFile.value = upsGeneratorFile;
    }
    if (walkthroughVideoFile != null) {
      examController.walkthroughVideoFile.value = walkthroughVideoFile;
    }

    /// ✅ 7. NEXT PAGE
    Get.to(() => const CenterDetailsPage2());
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
                const SizedBox(height: 22),
                Text("Where is your Center Located?", style: AppTextStyles.dashBordButton2),
                const SizedBox(height: 15),

                Text("Country", style: AppTextStyles.centerText),
                const SizedBox(height: 8),

                CustomDropdown<CountryModel>(
                  hintText: "Select Country",
                  value: selectedCountry,
                  items: countryList,
                  itemLabel: (item) => item.name,
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value;
                    });
                    if (value != null) {
                      _loadStatesByCountry(value.id);
                    }
                  },
                  validator: (_) {},
                ),
                const SizedBox(height: 16),

                Text("State", style: AppTextStyles.centerText),
                const SizedBox(height: 8),

                CustomDropdown<StateModel>(
                  hintText: "Select State",
                  value: selectedState,
                  items: stateList,
                  itemLabel: (item) => item.name,   // ya item.stateName
                  onChanged: (value) {
                    setState(() {
                      selectedState = value;
                    });
                    if (value != null) {
                      _loadCitiesByState(value.id);
                    }
                  },
                  validator: (_) {},
                ),
                const SizedBox(height: 16),


                Text("City", style: AppTextStyles.centerText),
                const SizedBox(height: 8),

                CustomDropdown<CityModel>(
                  hintText: "Select City",
                  value: selectedCity,
                  items: cityList,
                  itemLabel: (item) => item.name,
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

                // 🔹 Center Type
                Text("Center Type", style: AppTextStyles.centerText),
                const SizedBox(height: 10),

                CustomDropdown<String>(
                  hintText: "Select Category Center Type",
                  value: categoryTypes,
                  items: _categoryTypes,
                  itemLabel: (value) => value,
                  onChanged: (value) {
                    setState(() {
                      categoryTypes = value;
                    });
                  },
                  validator: (_) {},
                ),

                const SizedBox(height: 17),

                const SizedBox(height: 16),

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
                  onPressed: _saveAndNext,
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