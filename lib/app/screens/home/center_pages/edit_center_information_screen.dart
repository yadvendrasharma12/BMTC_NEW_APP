
import 'dart:convert';
import 'dart:io';

import 'package:bmtc_app/app/screens/home/center_pages/center_details_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/profile_update_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../models/city_modal.dart';
import '../../../models/country_modal.dart';
import '../../../models/lab_model.dart';
import '../../../models/state_modal.dart';
import '../../../services/center_services.dart';
import '../../../services/location_services/location_service.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../../widgets/selectabe_tile.dart';
import '../../../widgets/uploading_container.dart';


class EditCenterInformationScreen extends StatefulWidget {
  final dynamic centerData;
final List<dynamic>? labsData;

  const EditCenterInformationScreen({super.key, this.centerData, this.labsData});


  @override
  State<EditCenterInformationScreen> createState() => _EditCenterInformationScreenState();
}




class _EditCenterInformationScreenState extends State<EditCenterInformationScreen> {

  List<Map<String, dynamic>> labsPayload = [];
  final ProfileUpdateController updateController = Get.put(ProfileUpdateController());
  final TextEditingController centerNameController = TextEditingController();
  final TextEditingController postalAddressController =
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

  String? selectedTestCenterCategory;
  String? selectedRailwayDistance;
  String? selectedBusDistance;
  String? selectedMetroDistance;
  String? selectedAirportDistance;

  // ✅ Lift availability (Yes/No)
  bool? isLiftAvailable; // null / true / false

  // ✅ Sample dropdown data
  final List<String> centerTypes = [
    'Online',
  ];

  final TextEditingController totalLabsController = TextEditingController();
  int totalLabs = 1; // default 1
  final List<String> countries = ['India', 'USA', 'UK'];
  final List<String> states = ['Karnataka', 'Maharashtra', 'Delhi'];
  final List<String> cities = ['Bangalore', 'Mysore', 'Mumbai', 'Delhi'];
  List<String> _categoryTypes = [];
  String? categoryTypes;
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
    postalAddressController.dispose();
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
    for (var lab in labs) {
      lab.computersController.dispose();
    }
    totalLabsController.dispose();
  }








  _pickEntranceFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "jpeg"],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();

      setState(() {
        entranceFileName = result.files.single.name;
        entranceFileSizeBytes = result.files.single.size;
      });

      updateController.centerEntrances = base64Encode(bytes) as List<String>;
    }
  }


  Future<void> _pickLabPhotoFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "jpeg"],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();

      setState(() {
        labPhotoFileName = result.files.single.name;
        labPhotoFileSizeBytes = result.files.single.size;
      });

      updateController.labPhotos = base64Encode(bytes) as List<File>;
    }
  }

  Future<void> _pickMainGateFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "jpeg"],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();

      setState(() {
        mainGateFileName = result.files.single.name;
        mainGateFileSizeBytes = result.files.single.size;
      });

      updateController.mainGateImages = base64Encode(bytes) as List<String>;
    }
  }

  Future<void> _pickServerRoomFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "jpeg"],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();

      setState(() {
        serverRoomFileName = result.files.single.name;
        serverRoomFileSizeBytes = result.files.single.size;
      });

      updateController.serverRoomImages = base64Encode(bytes) as List<String>;
    }
  }

  Future<void> _pickConferenceRoomFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "jpeg"],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();

      setState(() {
        conferenceRoomFileName = result.files.single.name;
        conferenceRoomFileSizeBytes = result.files.single.size;
      });

      updateController.observerRoomImages = base64Encode(bytes) as List<String>;
    }
  }

  Future<void> _pickUpsGeneratorFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "jpeg"],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();

      setState(() {
        upsGeneratorFileName = result.files.single.name;
        upsGeneratorFileSizeBytes = result.files.single.size;
      });

      updateController.upsGeneratorImages = base64Encode(bytes) as List<String>;
    }
  }

  Future<void> _pickWalkthroughVideoFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "jpeg"],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();

      setState(() {
        walkthroughVideoFileName = result.files.single.name;
        walkthroughVideoFileSizeBytes = result.files.single.size;
      });

      updateController.walkthroughVideo = base64Encode(bytes);
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
  String? selectFueltankTime;

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
  final List<String> fuelTankOption = [
    '5 ltr',
    '10 ltr',
    '15 ltr',
    '20 ltr',
    '25 ltr',
    '30 ltr',
    '35 ltr',
    '40 ltr',
    '50 ltr',
    '60 ltr',
  ];









  final TextEditingController centersNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController gstStateController = TextEditingController();
  final TextEditingController gstNOController = TextEditingController();
  final TextEditingController udhaiController = TextEditingController();
  final TextEditingController udhayamController = TextEditingController();

  String? hasGST;
  String? hasMSME;


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


  final ProfileUpdateController profileController = Get.find<ProfileUpdateController>();

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

    _loadLabsFromApi();

  }
  void _loadLabsFromApi() {
    if (widget.labsData == null || widget.labsData!.isEmpty) return;


    setState(() {});
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

                        onChanged: (val) => updateController.centerName = val,
                        label: '',
                      ),
                      SizedBox(height: 10,),
                      Text("What is the Description?", style: AppTextStyles.centerText),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: designationController,

                        onChanged: (val) => updateController.centerDescription = val,
                        label: '',
                      ),
                      const SizedBox(height: 12),

                      // 🔹 Center Description
                      Text(
                        "What is the Center Postal Address",
                        style: AppTextStyles.centerText,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: postalAddressController,

                        onChanged: (val) => updateController.postalAddress = val, label: '',
                      ),
                      SizedBox(height: 10,),
                      Text("What is Center Capacity", style: AppTextStyles.centerText),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: centerCapacityController,

                      //  onChanged: (val) => updateController.centerName = val,
                        label: '',
                      ),

                      const SizedBox(height: 12),

                      // 🔹 Center Type
                      Text("Center Type", style: AppTextStyles.centerText),
                      const SizedBox(height: 10),
                      CustomDropdown<String>(
                        hintText: "Select Center Type",
                        value: centerTypes.contains(updateController.centerType)
                            ? updateController.centerType
                            : null,  // fallback if current value not in list
                        items: centerTypes,
                        itemLabel: (value) => value,
                        onChanged: (value) {
                          updateController.centerType = value!;
                          setState(() {});
                        },
                        validator: (value) {},
                      ),



                      const SizedBox(height: 16),

                      // 🔹 Latitude
                      Text("Center’s Latitude", style: AppTextStyles.centerText),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: latitudeController,
                        keyboardType: TextInputType.number,
                        onChanged: (val) => updateController.addressLat = double.tryParse(val) ?? 0, label: '',
                      ),
                      const SizedBox(height: 10),

                      // 🔹 Longitude
                      Text("Center’s Longitude", style: AppTextStyles.centerText),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: longitudeController,
                        keyboardType: TextInputType.number,
                        onChanged: (val) => updateController.addressLong = double.tryParse(val) ?? 0, label: '',
                      ),
                      const SizedBox(height: 20),

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

                      const SizedBox(height: 20),



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
                      CustomDropdown<CountryModel>(
                        hintText: "Select Country",
                        value: selectedCountry,
                        items: countryList,
                        itemLabel: (item) => item.name,
                        onChanged: (value) {
                          updateController.countryId = value!.id;
                          setState(() {
                            selectedCountry = value;
                          });
                          _loadStatesByCountry(value.id);
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
                          updateController.stateId = value!.id;
                          setState(() {
                            selectedState = value;
                          });
                          _loadCitiesByState(value.id);
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
                          updateController.cityId = value!.id ;
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
                        controller: localAreaController,

                        onChanged: (val) => updateController.localAreaName = val, label: '',

                        hintText: "",
                        keyboardType: TextInputType.text,

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
                        onChanged: (val) => updateController.pinCode ,
                      ),
                      const SizedBox(height: 16),

                      // 🔹 Test center category
                      Text(
                        "What is the Category of your Test Center?",
                        style: AppTextStyles.centerText,
                      ),
                      const SizedBox(height: 10),
                      CustomDropdown<String>(
                        hintText: "Select Category Center Type",
                        value: _categoryTypes.contains(updateController.typeOfCenter)
                            ? updateController.typeOfCenter
                            : null,
                        items: _categoryTypes,
                        itemLabel: (value) => value,
                        onChanged: (value) {
                          updateController.typeOfCenter = value!;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a center type';
                          }
                          return null;
                        },
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

                        onChanged: (val) => updateController.nearbyLandmark = val,
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
                              value: updateController.isLiftAvailable == true,
                              text: "Yes",
                              onChanged: (val) {
                                updateController.isLiftAvailable = true;
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SelectableTile(
                              value: updateController.isLiftAvailable == false,
                              text: "No",
                              onChanged: (val) {
                                updateController.isLiftAvailable = false;
                                setState(() {});
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
                        onChanged: (val) => updateController.nearestRailwayStation = val,

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
                            updateController.distanceFromStation = value!;   // 👈 MODEL UPDATE
                          });
                        },
                        validator: (_) => null,
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
                        onChanged: (val) => updateController.nearestBusStop = val,
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
                            updateController.distanceFromBusStop = value!;   // 👈 MODEL UPDATE
                          });
                        },
                        validator: (_) => null,
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
                        onChanged: (val) => updateController.nearestMetroStation = val,
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
                            updateController.distanceFromMetro = value!;   // 👈 MODEL UPDATE
                          });
                        },
                        validator: (_) => null,
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
                        onChanged: (val) => updateController.nearestAirport = val,
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
                            updateController.distanceFromAirport = value ?? "";
                          });
                        },
                        validator: (_) => null,
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

                                  onChanged: (val) => updateController.csName = val,
                                ),
                                const SizedBox(height: 14),

                                Text("Phone Number", style: AppTextStyles.centerText),
                                const SizedBox(height: 8),
                                AppTextField(
                                  label: "",
                                  hintText: "",
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,

                                  onChanged: (val) => updateController.amContactNoExtra = val,
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

                                  onChanged: (val) => updateController.amPhoneAlternateExtra = val,
                                ),

                                const SizedBox(height: 14),

                                Text("Email Address", style: AppTextStyles.centerText),
                                const SizedBox(height: 8),
                                AppTextField(
                                  label: "",
                                  hintText: "",
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,

                                  onChanged: (val) => updateController.amEmailExtra = val,
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

                                  onChanged: (val) => updateController.pocName = val,
                                ),

                                const SizedBox(height: 14),
                                Text("Phone Number", style: AppTextStyles.centerText),
                                const SizedBox(height: 8),
                                AppTextField(
                                  label: "",
                                  hintText: "",
                                  keyboardType: TextInputType.number,
                                  controller: phone2Controller
                                    ,
                                  onChanged: (val) => updateController.pocContactNo = val,
                                ),
                                const SizedBox(height: 14),

                                Text("Email Address", style: AppTextStyles.centerText),
                                const SizedBox(height: 8),
                                AppTextField(
                                  label: "",
                                  hintText: "",
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email2Controller
                                    ,
                                  onChanged: (val) => updateController.pocEmail = val,
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
                                  controller: name3Controller
                                    ,
                                  onChanged: (val) => updateController.tdName = val,
                                ),

                                const SizedBox(height: 14),

                                Text("Phone Number", style: AppTextStyles.centerText),
                                const SizedBox(height: 8),
                                AppTextField(
                                  label: "",
                                  hintText: "",
                                  keyboardType: TextInputType.number,
                                  controller: phone3Controller
                                    ,
                                  onChanged: (val) => updateController.tdContactNo = val,
                                ),

                                const SizedBox(height: 14),

                                Text("Email Address", style: AppTextStyles.centerText),
                                const SizedBox(height: 8),
                                AppTextField(
                                  label: "",
                                  hintText: "",
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email3Controller
                                  ,
                                  onChanged: (val) => updateController.tdEmail = val,
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
                                  controller: phone4Controller

                                    ,
                                  onChanged: (val) => updateController.EmergencyNumber = val,
                                ),
                                const SizedBox(height: 14),
                                Text("Alternate Phone Number",
                                    style: AppTextStyles.centerText),
                                const SizedBox(height: 8),
                                AppTextField(
                                  label: "",
                                  hintText: "",
                                  keyboardType: TextInputType.number,
                                  controller: phone5Controller
                                    ,
                                  onChanged: (val) => updateController.EmergencyAlt = val,
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
                                    // Total labs
                                    AppTextField(
                                      controller: totalLabsController,
                                      keyboardType: TextInputType.number,
                                      label: '',
                                      onChanged: (value) {
                                        int count = int.tryParse(value) ?? 1;
                                        if (count < 1) count = 1;

                                        setState(() {
                                          if (count > labs.length) {
                                            labs.addAll(
                                              List.generate(count - labs.length, (_) => LabModel()),
                                            );
                                          } else if (count < labs.length) {
                                            labs.removeRange(count, labs.length);
                                          }
                                        });
                                      },
                                    ),



                                    const SizedBox(height: 15),
                                    Text("Total number of systems",
                                        style: AppTextStyles.centerText),
                                    const SizedBox(height: 8),
                                    AppTextField(
                                      controller: totalLabsController,
                                      keyboardType: TextInputType.number,
                                      label: '',
                                      onChanged: (val) => updateController.totalNumberOfSystem ,

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
                                      onChanged: (v) {
                                        setState(() => selectedNetwork = v);
                                        updateController.connectedSingleNetwork ;
                                      }, validator: (value) {  },
                                    ),

                                    const SizedBox(height: 15),
                                    Text("Total Network", style: AppTextStyles.centerText),
                                    const SizedBox(height: 8),
                                    AppTextField(
                                      controller: totalNetworkController,
                                      keyboardType: TextInputType.text,
                                      label: '',
                                      onChanged: (value) {
                                        // Update controller variable
                                        updateController.totalNetwork = int.tryParse(value) ?? 0;
                                      },
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
                                      onChanged: (v) {
                                        setState(() => selectedPartition = v);
                                        // Update your controller property
                                        updateController.partitionInEachLab = (v == "Yes") ? 1 : 0;
                                      },
                                      validator: (value) => null,
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
                                      onChanged: (v) {
                                        setState(() => selectedAC = v);
                                        // Update the controller field
                                        updateController.acInEachLabExtra = v ?? "";
                                      },
                                      validator: (value) => null,
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
                                      onChanged: (v) {
                                        setState(() => selectedPrinter = v);
                                        updateController.networkPrinterExtra ;
                                      },
                                      validator: (value) => null,
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
                                      onChanged: (v) {
                                        setState(() => selectedProjector = v);
                                        updateController.projectorEachLab ;
                                      },
                                      validator: (value) => null,
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
                                      onChanged: (v) {
                                        setState(() => selectedSoundSystem = v);
                                        updateController.isThereSoundSystemInEachLab = v == "Yes";
                                      },
                                      validator: (value) => null,
                                    ),


                                    const SizedBox(height: 15),
                                    Text("How Many Fire Extinguisher in each lab",
                                        style: AppTextStyles.centerText),
                                    const SizedBox(height: 8),
                                    CustomDropdown<String>(
                                      hintText: "Select",
                                      value: selectedFireExit,
                                      items: [
                                        '0','1','2','3','4','5','6','7','8','9','10'
                                      ],
                                      itemLabel: (v) => v,
                                      onChanged: (v) {
                                        setState(() => selectedFireExit = v);
                                        updateController.fireExtinguisherExtra = int.tryParse(v ?? "0") ?? 0;
                                      },
                                      validator: (value) => null,
                                    ),


                                    const SizedBox(height: 15),
                                    Text("Is there Locker facility?",
                                        style: AppTextStyles.centerText),
                                    const SizedBox(height: 8),
                                    CustomDropdown<String>(
                                      hintText: "Select",
                                      value: selectedMemory,
                                      items: yesNoOptions,
                                      itemLabel: (v) => v,
                                      onChanged: (v) {
                                        setState(() => selectedMemory = v);
                                        updateController.lockerFacility ;
                                      },
                                      validator: (value) => null,
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
                                        updateController.drinkingWaterFacilityExtra ;
                                      },
                                      validator: (value) => null,
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
                                      onChanged: (value) => updateController.primaryISPName = value,
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
                                      onChanged: (v) {
                                        setState(() => selectedPrimaryISPType = v);
                                        updateController.primaryIspConnectType = v ?? "";
                                      },
                                      validator: (value) {
                                        return null;
                                      },
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
                                            onChanged: (value) {
                                              updateController.primaryIspSpeed = double.tryParse(value) ?? 0.0;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: CustomDropdown<String>(
                                            hintText: "Unit",
                                            value: selectedPrimarySpeed,
                                            items: speeds,
                                            itemLabel: (v) => v,
                                            onChanged: (v) {
                                              setState(() => selectedPrimarySpeed = v);
                                              updateController.primaryInternetSpeedUnit = v ?? "";
                                            },
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
                                      onChanged: (value) {
                                        updateController.secondaryISPName = value;
                                      },
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
                                      onChanged: (v) {
                                        setState(() => selectedSecondaryISPType = v);
                                        updateController.secondaryIspConnectType = v ?? "";
                                      },
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
                                            onChanged: (value) {
                                              updateController.secondaryIspSpeed =
                                                  double.tryParse(value) ?? 0.0;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: CustomDropdown<String>(
                                            hintText: "Unit",
                                            value: selectedSecondarySpeed,
                                            items: speeds,
                                            itemLabel: (v) => v,
                                            onChanged: (v) {
                                              setState(() => selectedSecondarySpeed = v);
                                              updateController.secondaryInternetSpeedUnit = v ?? "";
                                            },
                                            validator: (value) {
                                              return null;
                                            },
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
                                          updateController.isGeneratorBackup = v == "Yes";
                                          // Agar "No" select kare to values clear kar do
                                          if (selectedGenerator == "No") {
                                            generatorCapacityController.clear();
                                            selectFueltankTime = null;
                                          }
                                        });
                                      },
                                      validator: (value) {},
                                    ),

                                    if (selectedGenerator == "Yes") ...[
                                      const SizedBox(height: 15),
                                      Text("Generator Capacity (in KVA)", style: AppTextStyles.centerText),
                                      const SizedBox(height: 8),
                                      AppTextField(
                                        controller: generatorCapacityController,
                                        keyboardType: TextInputType.number,
                                        label: '',
                                        onChanged: (value) {
                                          updateController.generatorBackupCapacity = double.tryParse(value) ?? 0.0;
                                        },
                                      ),

                                      const SizedBox(height: 15),
                                      Text("Generator fuel tank (ltr)", style: AppTextStyles.centerText),
                                      const SizedBox(height: 8),
                                      CustomDropdown<String>(
                                        hintText: "Select",
                                        value: selectFueltankTime,
                                        items: fuelTankOption,
                                        itemLabel: (v) => v,
                                        onChanged: (v) {
                                          setState(() => selectFueltankTime = v);
                                          updateController.generatorFuelTankCapacity = double.tryParse(v ?? "0") ?? 0.0;
                                        },
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
                                      onChanged: (value) {
                                        updateController.backupHours ;
                                      },
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
                                      onChanged: (v) {
                                        setState(() => selectedUPSBackupTime = v);
                                        updateController.backupMinutes ;
                                      },
                                      validator: (value) => null,
                                    ),

                                    const SizedBox(height: 30),
                                    Text("Lab Details",
                                        style: GoogleFonts.karla(
                                            fontSize: 18, fontWeight: FontWeight.bold)),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: labs.length,
                                      itemBuilder: (context, index) {
                                        return _buildLabBox(index);
                                      },
                                    ),




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
                                          controller: centersNameController,
                                          onChanged: (val) => updateController.beneficiaryName = val,
                                          label: "",
                                          hintText: "",
                                        ),


                                        const SizedBox(height: 15),
                                        // Bank Name
                                        Text("Name of the Bank", style: AppTextStyles.centerText),
                                         SizedBox(height: 8),
                                        AppTextField(
                                          controller:bankNameController,
                                            onChanged: (val) => updateController.bankName = val,
                                          label: "",
                                          hintText: "",
                                        ),

                                        const SizedBox(height: 15),
                                        // Account Number
                                        Text("Bank Account Number", style: AppTextStyles.centerText),
                                        const SizedBox(height: 8),
                                        AppTextField(
                                          controller: accountNumberController
                                            ,
                                          onChanged: (val) => updateController.bankAccountNumber = val,
                                          label: "",
                                          hintText: "",
                                          keyboardType: TextInputType.number,
                                        ),

                                        const SizedBox(height: 15),
                                        // IFSC
                                        Text("Bank IFSC code", style: AppTextStyles.centerText),
                                        const SizedBox(height: 8),
                                        AppTextField(
                                          controller: ifscController
                                            ,
                                          onChanged: (val) => updateController.bankIfsc = val,
                                          label: "",
                                          hintText: "",
                                          keyboardType: TextInputType.text,
                                        ),

                                        const SizedBox(height: 15),
                                        // PAN
                                        Text("PAN Number", style: AppTextStyles.centerText),
                                        const SizedBox(height: 8),
                                        AppTextField(
                                          controller: panController
                                            ,
                                          onChanged: (val) => updateController.pannumber = val,
                                          label: "",
                                          hintText: "",
                                          keyboardType: TextInputType.text,
                                        ),

                                        const SizedBox(height: 15),

                                        yesNoSelector(
                                          "Do you have GST number?",
                                          hasGST,
                                              (val) {
                                            setState(() {
                                              hasGST = val;

                                              updateController.hasGst = (val == "Yes");

                                              if (hasGST == "No") {
                                                gstNOController.clear();
                                                updateController.gstNumber = "";
                                                updateController.gstCertFile = null;
                                              }
                                            });
                                          },
                                        ),

                                        const SizedBox(height: 15),

                                        if (hasGST == "Yes") ...[
                                          Text("GST Number", style: AppTextStyles.centerText),
                                          const SizedBox(height: 8),

                                          AppTextField(
                                            controller: gstNOController,
                                            keyboardType: TextInputType.number,
                                            label: "",
                                            hintText: "",
                                            onChanged: (val) => updateController.gstNumber = val,
                                          ),

                                          const SizedBox(height: 15),

                                          Text("Upload GST Certificate", style: AppTextStyles.centerText),
                                          const SizedBox(height: 8),

                                          Container(
                                            height: 48,
                                            padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 5),
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

                                                          /// **UPDATE CONTROLLER**
                                                          updateController.gstCertFile = file;
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
                                                        style: GoogleFonts.karla(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(width: 15),

                                                Expanded(
                                                  child: Text(
                                                    gstCertFileName == null || gstCertFileName!.isEmpty
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
                                        ],


                                        const SizedBox(height: 12),
                                        Text("GST Station Code", style: AppTextStyles.centerText),
                                        const SizedBox(height: 8),
                                        AppTextField(
                                          controller: gstStateController
                                            ,
                                          onChanged: (val) => updateController.gstStateCode,
                                          label: "",
                                          hintText: "",
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 15),
                                        Text("UIDAI Number", style: AppTextStyles.centerText),
                                        const SizedBox(height: 8),
                                        AppTextField(
                                          controller: udhaiController
                                            ,
                                          onChanged: (val) => updateController.uidaiNumber = val,
                                          label: "",
                                          hintText: "",
                                          keyboardType: TextInputType.text,
                                        ),
                                        const SizedBox(height: 15),

                                        yesNoSelector("Do you have MSME number?", hasMSME, (val) {
                                          setState(() {
                                            hasMSME = val;
                                            if (hasMSME == "No") {
                                              udhayamController.clear();
                                            }
                                          });
                                        }),

                                        const SizedBox(height: 15),

                                        if (hasMSME == "Yes") ...[
                                          Text("MSME Number", style: AppTextStyles.centerText),
                                          const SizedBox(height: 8),

                                          AppTextField(
                                            controller: udhayamController,
                                            onChanged: (val) => updateController.msmeNumber = val,
                                            label: "",
                                            hintText: "",
                                          ),

                                          const SizedBox(height: 15),
                                        ],


                                        Text("Upload Canceled Cheque", style: AppTextStyles.centerText),
                                        const SizedBox(height: 15),
                                        UploadingContainer(
                                          buttonText: "Upload File",
                                          infoText: "Max Each file size: 2 MB | File type: doc, docx, pdf",
                                          onPressed: () async {
                                            await _pickFile(
                                              maxSizeMB: 2,
                                              allowedExtensions: ['doc', 'docx', 'pdf'],
                                              onFilePicked: (file, name, size) {
                                                setState(() {
                                                  cancelledChequeFile = file;
                                                  cancelledChequeFileName = name;
                                                  cancelledChequeFileSize = size;

                                                  updateController.canceledCheque;
                                                });
                                              },
                                            );
                                          },
                                        ),

                                        _selectedFileInfo(cancelledChequeFileName, cancelledChequeFileSize),


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

                                                  updateController.agreementFile;
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

                                                  updateController.mouFile;
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
                                                  updateController.gstCertFile;
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
                                                  updateController.udyamCertFile;
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
                                                  updateController.panNumberFile;
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
                                        child: Obx(() {
                                          if (updateController.isLoading.value) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }

                                          return CustomPrimaryButton(
                                            icon: Icons.arrow_right_alt_rounded,
                                            text: "Save",
                                            onPressed: () async {
                                              await updateController.updateCenterProfile(context);
                                              Get.to(CenterDetailsScreen());
                                            },
                                          );
                                        }),
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
  List<LabModel> labs = [LabModel()]; // default 1 lab




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

          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
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
                      labs.removeAt(index);
                      totalLabsController.text = labs.length.toString();
                    });
                  },
                ),
            ],
          ),

          const SizedBox(height: 15),

          /// FLOOR
          Text("Floor Number", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: floors.contains(lab.floor) ? lab.floor : null,
            items: floors,
            itemLabel: (v) => v,
            onChanged: (v) => lab.floor = v ?? '', validator: (value) {  },
          ),

          const SizedBox(height: 15),

          /// COMPUTERS
          Text("Total Number of computers", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          AppTextField(
            controller: lab.computersController,
            keyboardType: TextInputType.number,
            label: '',
          ),

          const SizedBox(height: 15),

          /// PROCESSOR
          Text("System Processor", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: processors.contains(lab.processor) ? lab.processor : null,
            items: processors,
            itemLabel: (v) => v,
            onChanged: (v) => lab.processor = v ?? '', validator: (value) {  },
          ),

          const SizedBox(height: 15),

          /// MONITOR
          Text("Monitor type", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: monitors.contains(lab.monitor) ? lab.monitor : null,
            items: monitors,
            itemLabel: (v) => v,
            onChanged: (v) => lab.monitor = v ?? '', validator: (value) {  },
          ),

          const SizedBox(height: 15),

          /// OS
          Text("Operating System", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: oss.contains(lab.os) ? lab.os : null,
            items: oss,
            itemLabel: (v) => v,
            onChanged: (v) => lab.os = v ?? '', validator: (value) {  },
          ),

          const SizedBox(height: 15),

          /// RAM
          Text("RAM (in GB)", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: rams.contains(lab.ram) ? lab.ram : null,
            items: rams,
            itemLabel: (v) => v,
            onChanged: (v) => lab.ram = v ?? '', validator: (value) {  },
          ),

          const SizedBox(height: 15),

          /// HDD
          Text("Hard Disk Drive Capacity in GB", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: hardDisks.contains(lab.hdd) ? lab.hdd : null,
            items: hardDisks,
            itemLabel: (v) => v,
            onChanged: (v) => lab.hdd = v ?? '', validator: (value) {  },
          ),

          const SizedBox(height: 15),

          /// SWITCH COMPANY
          Text("Ethernet Switch Company", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: switchCompanies.contains(lab.ethernetCompany)
                ? lab.ethernetCompany
                : null,
            items: switchCompanies,
            itemLabel: (v) => v,
            onChanged: (v) => lab.ethernetCompany = v ?? '', validator: (value) {  },
          ),

          const SizedBox(height: 15),

          /// SWITCH CATEGORY
          Text("Switch Category", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: switchCategories.contains(lab.switchCategory)
                ? lab.switchCategory
                : null,
            items: switchCategories,
            itemLabel: (v) => v,
            onChanged: (v) => lab.switchCategory = v ?? '', validator: (value) {  },
          ),

          const SizedBox(height: 15),

          /// PORTS
          Text("No. of port Ethernet switch", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          CustomDropdown<String>(
            hintText: "Select",
            value: switchParts.contains(lab.ethernetPorts)
                ? lab.ethernetPorts
                : null,
            items: switchParts,
            itemLabel: (v) => v,
            onChanged: (v) => lab.ethernetPorts = v ?? '', validator: (value) {  },
          ),
        ],
      ),
    );
  }

}



class LabModel {
  String? id;            // lab id (for update)
  String? centerId;      // center_id

  String floor;
  TextEditingController computersController;

  String processor;
  String monitor;
  String os;
  String ram;
  String hdd;
  String ethernetCompany;
  String switchCategory;
  String ethernetPorts;

  LabModel({
    this.id,
    this.centerId,
    this.floor = '',
    TextEditingController? computersController,
    this.processor = '',
    this.monitor = '',
    this.os = '',
    this.ram = '',
    this.hdd = '',
    this.ethernetCompany = '',
    this.switchCategory = '',
    this.ethernetPorts = '',
  }) : computersController = computersController ?? TextEditingController();
}
LabModel fromJson(Map<String, dynamic> json) {
  return LabModel(
    id: json['id'],
    centerId: json['center_id'],
    floor: json['floor_name'] ?? '',
    computersController:
    TextEditingController(text: json['no_of_computer'] ?? ''),
    processor: json['processor'] ?? '',
    monitor: json['monitor_type'] ?? '',
    os: json['operating_system'] ?? '',
    ram: json['ram'] ?? '',
    hdd: json['hard_disk'] ?? '',
    ethernetCompany: json['ehternet_swtch_company'] ?? '',
    switchCategory: json['switch_category'] ?? '',
    ethernetPorts: json['no_of_port_eth_switch'] ?? '',
  );
}



