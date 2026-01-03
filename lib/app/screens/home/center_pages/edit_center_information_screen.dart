
import 'dart:convert';
import 'dart:io';



import 'package:bmtc_app/app/models/profile_data_model.dart' as api;
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';


import '../../../controllers/profile_data_controller.dart';
import '../../../controllers/profile_update_controller.dart';
import '../../../core/app_colors.dart';
import '../../../models/city_modal.dart';
import '../../../models/country_modal.dart';
import '../../../models/state_modal.dart';
import '../../../services/location_services/location_service.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/selectabe_tile.dart';
import '../../../widgets/uploading_container.dart';
import '../../maps_page/maps_location_screen.dart';

class EditCenterInformationScreen extends StatefulWidget {
  final List<api.Lab> apiLabs;
  EditCenterInformationScreen({super.key, required this.apiLabs});
  @override
  State<EditCenterInformationScreen> createState() => _EditCenterInformationScreenState();
}

class _EditCenterInformationScreenState
    extends State<EditCenterInformationScreen> {


  List<EditableLab> labs = [];
  List<String> floors = [];
  List<String> processors = [];
  List<String> monitors = [];
  List<String> rams = [];
  List<String> hardDisks = [];
  List<String> osList = [];
  List<String> ethernetCompanies = [];
  List<String> switchCategories = [];
  List<String> ethernetPorts = [];

  List<String> floorOptions = ['Ground', '1st', '2nd', '3rd','4th','5th','6th','7th','8th','9th','10th',"Basement"];
  final List<String> processor = ['Core 2 Duo','i3', 'i5', 'i7', 'i9'];
  final List<String> monitor = ['LCD', 'LED', 'CRT'];
  final List<String> oss = ['Win 7','Win 8', 'Win 10','Win 11','MacOS'];
  final List<String> ram = ['2GB', '4GB','8GB', '16GB','32GB',];
  final List<String> hardDisk = ['80GB', '128GB','160GB','256GB','512GB','1TB','2TB','4TB'];
  final List<String> switchCompanies = ['Cisco','Netgear', 'TP-Link', 'D-Link','Dex','Others'];
  final List<String> switchCategorie = ['Unmanaged', 'Smart','Managed L2','Managed L3'];
  final List<String> switchParts = ['8','16','24','32'];


  final controller = Get.find<ProfileDataController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController centerNameCtrl = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController centerType = TextEditingController();
  final TextEditingController centerLat = TextEditingController();
  final TextEditingController centerLong = TextEditingController();
  final TextEditingController capacity = TextEditingController();
  final TextEditingController localAreaName = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController railwayS = TextEditingController();
  final TextEditingController busStop = TextEditingController();
  final TextEditingController metro = TextEditingController();
  final TextEditingController airport = TextEditingController();
  final TextEditingController pointOfContactName = TextEditingController();
  final TextEditingController pointOfContactNumber = TextEditingController();
  final TextEditingController altPointOfContactNumber = TextEditingController();
  final TextEditingController pointOfContactEmail = TextEditingController();
  final TextEditingController csName = TextEditingController();
  final TextEditingController csNumber = TextEditingController();
  final TextEditingController csEmail = TextEditingController();

  final TextEditingController pocName = TextEditingController();
  final TextEditingController pocEmail = TextEditingController();
  final TextEditingController pocNumber = TextEditingController();
  final TextEditingController emergencyNo = TextEditingController();
  final TextEditingController landLineNo = TextEditingController();
  final TextEditingController primaryIsp = TextEditingController();
  final TextEditingController totalSystem = TextEditingController();
  final TextEditingController totalNetwork = TextEditingController();
  final TextEditingController totalLabCtrl = TextEditingController();
  final TextEditingController benifiryName = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController bankAccount = TextEditingController();
  final TextEditingController ifsc = TextEditingController();
  final TextEditingController panno = TextEditingController();
  final TextEditingController gstNo = TextEditingController();
  final TextEditingController gstStateCode = TextEditingController();
  final TextEditingController uidiai = TextEditingController();
  final TextEditingController MsmeNo = TextEditingController();
  final TextEditingController internateSpeedPrimary = TextEditingController();
  final TextEditingController internateSpeedSecondry = TextEditingController();
  final TextEditingController secondryIsp = TextEditingController();
  final TextEditingController generatorCapacity = TextEditingController();
  final TextEditingController upsBackup = TextEditingController();
  final TextEditingController pocController = TextEditingController();

  String? mapDistanceFromApi({
    required String? apiValue,
    required List<String> options,
  }) {
    if (apiValue == null || apiValue.isEmpty) return null;

    for (final option in options) {
      if (option.contains(apiValue)) {
        return option;
      }
    }
    return null;
  }

  List<api.CenterType> _categoryTypes = [];
  api.CenterType? selectedCenterType;



  bool? isLiftAvailable;

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    try {
      // Load reference data asynchronously
      await _loadCountries();
      await _loadCenterTypes();

      final center = controller.profileDataModel.value?.data.center;
      if (center == null) return; // safety check

      final labList = controller.profileDataModel.value?.data.labs ?? [];

      // Populate controllers and variables inside setState
      setState(() {
        // Basic details
        addressCtrl.text = center.address ?? '';
        centerNameCtrl.text = center.centerName ?? '';
        description.text = center.description ?? '';
        centerType.text = center.centerType ?? '';
        setCenterTypeFromApi(center.centerType);

        centerLat.text = center.addressLat ?? '';
        centerLong.text = center.addressLong ?? '';
        capacity.text = center.capacity ?? '';
        pincode.text = center.pinCode ?? '';
        localAreaName.text = center.localArea ?? '';
        airport.text = center.nearestAirport ?? '';
        landmark.text = center.landmark ?? '';
        isLiftAvailable ??= center.isLiftAvailable;
        // Point of contact
        pointOfContactName.text = center.amName ?? '';
        pointOfContactNumber.text = center.amContactNo ?? '';
        altPointOfContactNumber.text = center.amContactNo ?? '';
        pointOfContactEmail.text = center.amEmail ?? '';
        pocName.text = center.pocName ?? '';
        pocEmail.text = center.pocEmail ?? '';
        pocNumber.text = center.pocContactNo ?? '';
        pocController.text = center.pocMobileAlternate ?? '';

        // Center support staff
        csName.text = center.csName ?? '';
        csNumber.text = center.csContactNumber ?? '';
        csEmail.text = center.csEmail ?? '';
        emergencyNo.text = center.emergencyContactNo ?? '';
        landLineNo.text = center.landlineNumber ?? '';

        // Bank & legal info
        bankName.text = center.bankName ?? '';
        bankAccount.text = center.bankAccount ?? '';
        ifsc.text = center.Ifsc ?? '';
        panno.text = center.panNo ?? '';
        gstStateCode.text = center.gstState ?? '';
        gstNo.text = center.gstNo ?? '';
        uidiai.text = center.uidainNo ?? '';
        MsmeNo.text = center.msmeNo ?? '';
        benifiryName.text = center.beneficiaryName ?? '';
        primaryIsp.text = center.primaryIspName ?? '';

        // Network & UPS
        totalSystem.text = center.totalNoSystem ?? '';
        totalNetwork.text = center.howManyNetwork ?? '';
        generatorCapacity.text = center.generatorBackupCapacity ?? '';
        internateSpeedPrimary.text = center.primaryIspSpeed ?? '';
        internateSpeedSecondry.text = center.secondaryIspSpeed ?? '';
        upsBackup.text = center.powerbachup ?? '';
        secondryIsp.text = center.secondaryIspName ?? '';

        // Nearest transport
        railwayS.text = center.nearestRailway ?? '';
        busStop.text = center.nearestBus ?? '';
        metro.text = center.nearestMetroStation ?? '';

        // Parse yes/no fields
        isSingleNetwork = parseYesNo(center.connectedSingleNetwork);
        partition = parseYesNo(center.parttionEachLab);
        networkPrinter = parseYesNo(center.printerLab);
        ac = parseYesNo(center.acInLab);
        projector = parseYesNo(center.projectorLab);
        soundSystem = parseYesNo(center.soundSystem);
        drinking = parseYesNo(center.drinkingWater);
        lockerFacelity = parseYesNo(center.lockerFacelity);

        fireExuter = center.fireExuter;

        // Dropdowns

        // backupMinutes


        selectedBusDistance = matchDropdownValue(
            apiValue: center.distanceBus, options: distanceOptions);
        selectedRailwayDistance = matchDropdownValue(
            apiValue: center.distanceRailw, options: distanceOptions);
        selectedMetroDistance = matchDropdownValue(
            apiValue: center.distanceFromMetro, options: distanceOptions);
        selectedAirportDistance = matchDropdownValue(
            apiValue: center.distanceFromAirport, options: distanceOptions);

        primaryIspType = isp.cast<String?>().firstWhere(
                (e) => e?.toLowerCase() == (center.primaryConnectType ?? '').toLowerCase(),
            orElse: () => null);
        secondaryIsptype = ispTypes.firstWhereOrNull(
              (e) => e.toLowerCase() ==
              (center.secondaryConnectedType ?? '').toLowerCase(),
        );

        generatorFuilTank = matchDropdownValue(
            apiValue: center.fuilTankCapacity, options: tankCapacityLtr);
        upsBackupTimeMinutes = matchDropdownValue(
            apiValue: center.backupMinutes, options: upsBackupTimeOptions);

        primaryUnit = unites.firstWhereOrNull(
                (e) => e.toLowerCase() == (center.primaryinternetspeedunit ?? '').toLowerCase());
        secondryUnit = unites.firstWhereOrNull(
                (e) => e.toLowerCase() == (center.secoundaryUnit ?? '').toLowerCase());

        // Labs
        labs = widget.apiLabs.map((lab) {
          return EditableLab(
            id: lab.id ?? "",
            floor: lab.floorName ?? '',
            computers: lab.noOfComputer ?? '',
            processor: lab.windowGeneration ?? '',
            monitor: lab.monitorType ?? '',
            os: lab.operatingSystem ?? '',
            ram: lab.ram ?? '',
            hardDisk: lab.hardDisk ?? '',
            ethernetSwitchCompany: lab.ehternetSwtchCompany ?? '',
            switchCategory: lab.switchCategory ?? '',
            noOfPorts: lab.noOfPortEthSwitch ?? '',
          );
        }).toList();

        if (labs.isEmpty) labs.add(EditableLab());
        totalLabCtrl.text = labs.length.toString();
      });
    } catch (e) {
      print("Error initializing screen: $e");
    }finally {
      if (mounted) {
        setState(() => isInitializing = false); // ✅ MUST
      }
    }
  }

  final List<String> isp = [
    "Broadband",
    "Base line",
    "lease_line",
    "Fibre Optics",
    "Air Fibre",
  ];
  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> speeds = ['Gbps', 'Mbps'];
  final List<String> upsBackupTimeOptions = [ '0','5','10','15','20','25','30','35','40','50','60',];
  final List<String> tankCapacityLtr = [  '0.0','1',  '1.5','2 ', '2.5 ', '3 ', '3.5', '4 ', '4.5 ', '5 ',];

  bool parseYesNo(dynamic value) {
    if (value == null) return false;

    final v = value.toString().toLowerCase().trim();
    return v == "yes" || v == "1" || v == "true";
  }

  void _onLabCountChanged(String value) {
    final count = int.tryParse(value) ?? 1;
    setState(() {
      if (count > labs.length) {
        labs.addAll(List.generate(count - labs.length, (_) => EditableLab()));
      } else {
        labs = labs.take(count).toList();
      }
    });
  }


  Future<void> _loadCenterTypes() async {
    final data = controller.profileDataModel.value!.data;
    final center = data.center;

    setState(() {
      _categoryTypes = data.centerType;

      final String apiType = center.typeOfCenter ?? ""; // "University"

      selectedCenterType = _categoryTypes.firstWhereOrNull(
            (e) => e.centerType.toLowerCase() == apiType.toLowerCase(),
      );
    });


  }


  Future<void> _loadCountries() async {
    final list = await LocationService.getCountries();
    final center = controller.profileDataModel.value!.data.center;

    setState(() {
      countryList = list;
      selectedCountry = list.firstWhereOrNull(
            (c) => c.id == center.countryId,
      );
    });

    if (selectedCountry != null) {
      await _loadStatesByCountry(selectedCountry!.id);
    }
  }

  Future<void> _loadStatesByCountry(String countryId) async {
    final list = await LocationService.getStates(countryId);
    final center = controller.profileDataModel.value!.data.center;

    setState(() {
      stateList = list;
      selectedState = list.firstWhereOrNull(
            (s) => s.id == center.stateId,
      );
    });

    if (selectedState != null) {
      await _loadCitiesByState(selectedState!.id);
    }
  }

  Future<void> _loadCitiesByState(String stateId) async {
    final list = await LocationService.getCities(stateId);
    final center = controller.profileDataModel.value!.data.center;

    setState(() {
      cityList = list;
      selectedCity = list.firstWhereOrNull(
            (c) => c.id == center.cityId,
      );
    });
  }


  bool isSingleNetwork = false;
  bool partition = false;
  bool ac = false;
  bool networkPrinter = false;
  bool projector = false;
  bool soundSystem = false;
  String? fireExuter;
  bool drinking = false;
  bool lockerFacelity = false;
  String? primaryIspType;
  String? generatorFuilTank;
  String? upsBackupTimeMinutes;
  String? primaryUnit;
  String? secondryUnit;
  String? secondaryIsptype;


  @override
  void dispose() {
    centerNameCtrl.dispose();
    description.dispose();
    addressCtrl.dispose();
    centerType.dispose();
    centerLat.dispose();
    centerLong.dispose();
    capacity.dispose();
    localAreaName.dispose();
    pincode.dispose();
    landmark.dispose();
    railwayS.dispose();
    busStop.dispose();
    metro.dispose();
    airport.dispose();
    pointOfContactName.dispose();
    pointOfContactNumber.dispose();
    altPointOfContactNumber.dispose();
    pointOfContactEmail.dispose();
    csName.dispose();
    csNumber.dispose();
    csEmail.dispose();
    pocName.dispose();
    pocEmail.dispose();
    pocNumber.dispose();
    emergencyNo.dispose();
    landLineNo.dispose();
    primaryIsp.dispose();
    totalSystem.dispose();
    totalNetwork.dispose();
    totalLabCtrl.dispose();
    benifiryName.dispose();
    bankName.dispose();
    bankAccount.dispose();
    ifsc.dispose();
    panno.dispose();
    gstNo.dispose();
    gstStateCode.dispose();
    uidiai.dispose();
    MsmeNo.dispose();
    internateSpeedPrimary.dispose();
    internateSpeedSecondry.dispose();
    secondryIsp.dispose();
    generatorCapacity.dispose();
    upsBackup.dispose();
    pocController.dispose();
    super.dispose();
  }

  final List<String> yesNoList = ["Yes", "No"];


  final List<String> unites = ["Mbps", "Gbps"];
  final List<String> fireCount = ["1", "2","3","4","5","6","7","8","9"];

  final Map<String, String> centerTypeMap = {
    "1": "Online",
    "2": "Offline",
    "3": "Both",
  };
  String? selectedTypeCenter;
  late final List<String> centerTypeOptions = centerTypeMap.values.toList();

  void setCenterTypeFromApi(String? apiValue) {
    if (apiValue == null) return;

    setState(() {
      selectedTypeCenter = centerTypeOptions.firstWhereOrNull(
            (e) => e.toLowerCase().trim() == apiValue.toLowerCase().trim(),
      );
      centerType.text = selectedTypeCenter ?? "";
    });
  }
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
    '1.1',
    '1.2',
    '1.3',
    '1.4',
    '1.5',
    '1.6',
    '1.7',
    '1.8',
    '1.9',
    '2.0',
    '2.1',
    '2.2',
    '2.3',
    '2.4',
    '2.5',
    '2.6',
    '2.7',
    '2.8',
    '2.9',
    '3.0',
    '3.1',
    '3.2',
    '3.3',
    '3.4',
    '3.5',
    '3.6',
    '3.7',
    '3.8',
    '3.9',
    '4.0',
    '4.1',
    '4.2',
    '4.3',
    '4.4',
    '4.5',
    '4.6',
    '4.7',
    '4.8',
    '4.9',
    '5.0',
    '5.1',
    '5.2',
    '5.3',
    '5.4',
    '5.5',
    '5.6',
    '5.7',
    '5.8',
    '5.9',
    '6.0',
    '6.1',
    '6.2',
    '6.3',
    '6.4',
    '6.5',
    '6.6',
    '6.7',
    '6.8',
    '6.9',
    '7.0',
    '7.1',
    '7.2',
    '7.3',
    '7.4',
    '7.5',
    '7.6',
    '7.7',
    '7.8',
    '7.9',
    '8.0',
    '8.1',
    '8.2',
    '8.3',
    '8.4',
    '8.5',
    '8.6',
    '8.7',
    '8.8',
    '8.9',
    '9.0',
    '9.1',
    '9.2',
    '9.3',
    '9.4',
    '9.5',
    '9.6',
    '9.7',
    '9.8',
    '9.9',
    '10.0',
    '10.1',
    '10.2',
    '10.3',
    '10.4',
    '10.5',
    '10.6',
    '10.7',
    '10.8',
    '10.9',
    '11.0',
  ];


  String? matchDropdownValue({
    required String? apiValue,
    required List<String> options,
  }) {
    if (apiValue == null || apiValue.isEmpty) return null;

    return options.firstWhere(
          (e) => e.trim().toLowerCase() == apiValue.trim().toLowerCase(),
      orElse: () => '',
    ).isEmpty
        ? null
        : options.firstWhere(
          (e) => e.trim().toLowerCase() == apiValue.trim().toLowerCase(),
    );
  }

  final List<String> ispTypes = [
    'Broadband',
    'Lease_line',
    'Fibre Optics',
    'Air Fibre',
    "Lease line"
  ];
  bool isGeneratorBackup = false;
  @override
  Widget build(BuildContext context) {
    final images = controller.profileDataModel.value?.data.images ?? [];


    if (isInitializing) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Center Images",
                          style: AppTextStyles.dashBordButton3),

                    ],
                  ),
                ),


                _buildImageGallery(images),

                SizedBox(height: 11,),

                _sectionTitle("Center Details"),
                SizedBox(height: 11,),
                _card(
                  child: Column(
                    children: [
                      _textField(
                        title: "What is the Center name?",
                        hint: "Center Name",
                        controller: centerNameCtrl,
                        validator: (v) =>
                        v!.isEmpty ? "Center name is required" : null,
                      ),
                      _textField(
                        title: "Center Description",
                        hint: "Description",
                        controller: description,
                        validator: (v) =>
                        v!.isEmpty ? "description is required" : null,
                      ),
                      _textField(
                        title: "What is the center’s Postal Address?",
                        hint: "address",
                        controller: addressCtrl,
                        validator: (v) =>
                        v!.isEmpty ? "address is required" : null,
                      ),
                      Align(

                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Center Type",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomDropdown<String>(
                        hintText: "Select Center Type",
                        value: selectedTypeCenter,
                        items: centerTypeOptions,
                        itemLabel: (v) => v,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            selectedTypeCenter = v;
                            centerType.text = v;
                          });
                        },
                        validator: (_) =>
                        selectedTypeCenter == null ? "Please select Center Type" : null,
                      ),





                      const SizedBox(height: 8),
                      _textField(
                        title: "Center's Latitude",
                        hint: "Center's Latitude",
                        controller:centerLat,
                        validator: (v) =>
                        v!.isEmpty ? "Center's Latitude is required" : null,
                      ),
                      _textField(
                        title: "Center's Longitude",
                        hint: "Center's Longitude",
                        controller:centerLong,
                        validator: (v) =>
                        v!.isEmpty ? "Center's Longitude is required" : null,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomContainer(

                              text: "Get Current Location",
                              onTap: () {
                                _getCurrentLocation();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomContainer(

                              text: "Get Location By Map",
                              onTap: () async {
                                final LatLng? result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MapsLocationScreen(),
                                  ),
                                );

                                if (result != null) {
                                  centerLat.text = result.latitude.toString();
                                  centerLong.text = result.longitude.toString();
                                }
                              },

                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12,),
                      Align(
                          alignment:Alignment.topLeft,
                          child: Text("Upload Center Entrance", style: AppTextStyles.centerText)),
                      const SizedBox(height: 10),
                      UploadingContainer(
                        buttonText: "Upload File",
                        infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                        onPressed: _pickEntranceImage,
                      ),
                      _fileInfo(entranceImage),

                      const SizedBox(height: 16),

                      /// 🔹 LAB PHOTOS
                      Align(
                          alignment:Alignment.topLeft,
                          child: Text("Lab Photos", style: AppTextStyles.centerText)),

                      const SizedBox(height: 10),
                      UploadingContainer(
                        buttonText: "Upload File",
                        infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                        onPressed: _pickLabPhoto,
                      ),
                      _fileInfo(labPhoto),

                      const SizedBox(height: 16),


                      Align(
                          alignment:Alignment.topLeft,
                          child: Text("Main Gate / Entrance", style: AppTextStyles.centerText)),
                      const SizedBox(height: 10),
                      UploadingContainer(
                        buttonText: "Upload File",
                        infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                        onPressed: () async {
                          final file = await _pickFile(isVideo: false);
                          if (file != null) setState(() => mainGateImage = file);
                        },
                      ),
                      _fileInfo(mainGateImage),

                      const SizedBox(height: 16),


                      Align(
                          alignment:Alignment.topLeft,
                          child: Text("Server Room", style: AppTextStyles.centerText)),
                      const SizedBox(height: 10),
                      UploadingContainer(
                        buttonText: "Upload File",
                        infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                        onPressed: () async {
                          final file = await _pickFile(isVideo: false);
                          if (file != null) setState(() => serverRoomImage = file);
                        },
                      ),
                      _fileInfo(serverRoomImage),

                      const SizedBox(height: 16),

                      Align(
                          alignment:Alignment.topLeft,
                          child: Text("Observer / Conference Room", style: AppTextStyles.centerText)),
                      const SizedBox(height: 10),
                      UploadingContainer(
                        buttonText: "Upload File",
                        infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                        onPressed: () async {
                          final file = await _pickFile(isVideo: false);
                          if (file != null) setState(() => observerRoomImage = file);
                        },
                      ),
                      _fileInfo(observerRoomImage),

                      const SizedBox(height: 16),

                      Align(
                          alignment:Alignment.topLeft,
                          child: Text("UPS & Generator Photo", style: AppTextStyles.centerText)),
                      const SizedBox(height: 10),
                      UploadingContainer(
                        buttonText: "Upload File",
                        infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg",
                        onPressed: () async {
                          final file = await _pickFile(isVideo: false);
                          if (file != null) setState(() => upsImage = file);
                        },
                      ),
                      _fileInfo(upsImage),

                      const SizedBox(height: 16),

                      /// 🔹 WALKTHROUGH VIDEO


                      Align(
                          alignment:Alignment.topLeft,
                          child: Text("Center Walkthrough Video", style: AppTextStyles.centerText)),
                      const SizedBox(height: 10),
                      UploadingContainer(
                        buttonText: "Upload File",
                        infoText: "Max file size: 5 MB | File type: mp4",
                        onPressed: _pickWalkthroughVideo,
                      ),
                      _fileInfo(walkthroughVideo),
                      SizedBox(height: 12,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Country", style: AppTextStyles.centerText)),
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
                        validator: (_) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("State", style: AppTextStyles.centerText)),
                      const SizedBox(height: 8),

                      CustomDropdown<StateModel>(
                        hintText: "Select State",
                        value: selectedState,
                        items: stateList,
                        itemLabel: (item) => item.name, // ya item.stateName
                        onChanged: (value) {
                          setState(() {
                            selectedState = value;
                          });
                          if (value != null) {
                            _loadCitiesByState(value.id);
                          }
                        },
                        validator: (_) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("City", style: AppTextStyles.centerText)),
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
                        validator: (_) {
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      _textField(
                        title: "Local area Name",
                        hint: "Local Area Name",
                        controller:localAreaName,
                        validator: (v) =>
                        v!.isEmpty ? "local area is required" : null,
                      ),
                      _textField(
                        title: "Pin code",
                        hint: "Pin Code",
                        controller:pincode,
                        validator: (v) =>
                        v!.isEmpty ? "Pin code  is required" : null,
                      ),
                      const SizedBox(height: 10),

                      // 🔹 Center Type
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("What is the Category of your Test Center?", style: AppTextStyles.centerText)),
                      const SizedBox(height: 10),

                      CustomDropdown<api.CenterType>(
                        hintText: "Select Category Center Type",
                        value: selectedCenterType,
                        items: _categoryTypes,
                        itemLabel: (value) => value.centerType ?? "",
                        onChanged: (value) {
                          setState(() {
                            selectedCenterType = value;
                          });

                        },
                        validator: (_) => null,
                      ),

                      SizedBox(height: 10,),
                      _textField(
                        title: "Nearby Landmark",
                        hint: "landmark",
                        controller:landmark,
                        validator: (v) =>
                        v!.isEmpty ? "landmark is required" : null,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Is the Lift available for Physically Handicapped Candidate?",
                            style: AppTextStyles.centerText,
                          ),

                          const SizedBox(height: 10),

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
                        ],
                      ),

                      const SizedBox(height: 10),

                      _textField(
                        title: "Name of Railway Station",
                        hint: "Railway",
                        controller:railwayS,
                        validator: (v) =>
                        v!.isEmpty ? "railway is required" : null,
                      ),
                      const SizedBox(height: 6),

                      Align(

                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Distance from the main Railway Station",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomDropdown<String>(
                        hintText: "Select Distance",
                        value: distanceOptions.contains(selectedRailwayDistance)
                            ? selectedRailwayDistance
                            : null,
                        items: distanceOptions.toSet().toList(), // removes duplicates
                        itemLabel: (value) => value,
                        onChanged: (value) {
                          setState(() {
                            selectedRailwayDistance = value;
                          });
                        },
                        validator: (_) => null,
                      ),
                      SizedBox(height: 9,),
                      _textField(
                        title: "Name of Bus Stop",
                        hint: "bus",
                        controller:busStop,
                        validator: (v) =>
                        v!.isEmpty ? "bus is required" : null,
                      ),
                      Align(

                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Distance from the bus stop",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),

                      CustomDropdown<String>(
                        hintText: "Select Distance",
                        value: distanceOptions.contains(selectedBusDistance)
                            ? selectedBusDistance
                            : null,
                        items: distanceOptions.toSet().toList(), // removes duplicates
                        itemLabel: (value) => value,
                        onChanged: (value) {
                          setState(() {
                            selectedBusDistance = value;
                          });
                        },
                        validator: (_) => null,
                      ),

                      SizedBox(height: 9,),
                      _textField(
                        title: "Name of Metro Station",
                        hint: "metro",
                        controller:metro,
                        validator: (v) =>
                        v!.isEmpty ? "bus is required" : null,
                      ),
                      Align(

                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Distance from the nearby metro station",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomDropdown<String>(
                        hintText: "Select Distance",
                        value: distanceOptions.contains(selectedMetroDistance)
                            ? selectedMetroDistance
                            : null,
                        items: distanceOptions.toSet().toList(), // removes duplicates
                        itemLabel: (value) => value,
                        onChanged: (value) {
                          setState(() {
                            selectedMetroDistance = value;
                          });
                        },
                        validator: (_) => null,
                      ),

                      SizedBox(height: 9,),
                      _textField(
                        title: "Name of Airport",
                        hint: "airport",
                        controller:airport,
                        validator: (v) =>
                        v!.isEmpty ? "bus is required" : null,
                      ),
                      Align(

                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Distance from the main Airport",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomDropdown<String>(
                        hintText: "Distance from the main Airport",
                        value: distanceOptions.contains(selectedAirportDistance)
                            ? selectedAirportDistance
                            : null,
                        items: distanceOptions.toSet().toList(), // removes duplicates
                        itemLabel: (value) => value,
                        onChanged: (value) {
                          setState(() {
                            selectedAirportDistance = value;
                          });
                        },
                        validator: (_) => null,
                      ),



                    ],
                  ),
                ),
                _sectionTitle("Admin Details"),
                _card(child: Column(children: [
                  _textField(
                    title: "Point of Contact",
                    hint: "name",
                    controller: pointOfContactName,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(


                    hint: "number",
                    controller: pointOfContactNumber,
                    validator: (v) =>
                    v!.isEmpty ? "number is required" : null,
                  ),
                  _textField(


                    hint: "number",
                    controller: pocController,
                    validator: (v) =>
                    v!.isEmpty ? "number is required" : null,
                  ),
                  _textField(


                    hint: "Email",
                    controller: pointOfContactEmail,
                    validator: (v) =>
                    v!.isEmpty ? "number is required" : null,
                  ),


                  _textField(
                    title: "Center Superintendent details",
                    hint: "name",
                    controller: csName,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(

                    hint: "number",
                    controller: csNumber,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(

                    hint: "email",
                    controller: csEmail,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),

                  _textField(
                    title: "IT Manager details",
                    hint: "name",
                    controller: pocName,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(

                    hint: "email",
                    controller: pocEmail,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(

                    hint: "number",
                    controller: pocNumber,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(
                    title: "Emergency Contact number of the Center",
                    hint: "number",
                    controller: emergencyNo,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(

                    hint: "number",
                    controller: landLineNo,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),

                ],)),


                _sectionTitle("Infrastructure Details"),
                _card(child: Column(children: [
                  Align(

                    alignment: Alignment.centerLeft,
                    child: Text(
                      "General Lab Details",
                      style: AppTextStyles.grey18,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Align(

                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Total number of labs",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  SizedBox(height: 2,),
                  TextField(

                    controller: totalLabCtrl,
                    keyboardType: TextInputType.number,
                    onChanged: _onLabCountChanged,
                    decoration: _inputDecoration("total lab"),
                  ),
                  // _textField(
                  //
                  //   title:"Total number of labs",
                  //
                  //   hint: "Total number of labs",
                  //   controller: totalLab,
                  //   validator: (v) =>
                  //   v!.isEmpty ? "Center name is required" : null,
                  // ),
                  _textField(

                    title:"Total number of system",

                    hint: "Total number of system",
                    controller: totalSystem,
                    validator: (v) =>
                    v!.isEmpty ? "system name is required" : null,
                  ),


                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Are labs connected to a single network?",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomDropdown<String>(
                    hintText: "Select",
                    value: isSingleNetwork ? "Yes" : "No",
                    items: yesNoList,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        isSingleNetwork = v == "Yes";
                      });
                    },
                    validator: (_) => null,
                  ),
                  SizedBox(height: 8,),
                  _textField(

                    title:"Total Network",

                    hint: "Total number Network",
                    controller: totalNetwork,
                    validator: (v) =>
                    v!.isEmpty ? "system name is required" : null,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Is there a partition in each lab?",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomDropdown<String>(
                    hintText: "Select",
                    value: partition ? "Yes" : "No",
                    items: yesNoList,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        partition = v == "Yes";
                      });
                    },
                    validator: (_) => null,
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Is the Network Printer available?",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomDropdown<String>(
                    hintText: "Select",
                    value: networkPrinter ? "Yes" : "No",
                    items: yesNoList,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        networkPrinter = v == "Yes";
                      });
                    },
                    validator: (_) => null,
                  ),

                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Is there an AC in each lab?",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomDropdown<String>(
                    hintText: "Select",
                    value: ac ? "Yes" : "No",
                    items: yesNoList,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        ac = v == "Yes";
                      });
                    },
                    validator: (_) => null,
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Is there a projector in each lab?",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomDropdown<String>(
                    hintText: "Select",
                    value: projector ? "Yes" : "No",
                    items: yesNoList,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        projector = v == "Yes";
                      });
                    },
                    validator: (_) => null,
                  ),

                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Is there a Sound system each lab?",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomDropdown<String>(
                    hintText: "Select",
                    value: soundSystem ? "Yes" : "No",
                    items: yesNoList,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        soundSystem = v == "Yes";
                      });
                    },
                    validator: (_) => null,
                  ),

                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "How many fire Extinguishers each lab?",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomDropdown<String>(
                    hintText: "Select",
                    value: fireCount.contains(fireExuter) ? fireExuter : null,
                    items: fireCount,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      setState(() {
                        fireExuter = v;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Is there Locker facility each lab?",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomDropdown<String>(
                    hintText: "Select",
                    value: lockerFacelity ? "Yes" : "No",
                    items: yesNoList,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        lockerFacelity = v == "Yes";
                      });
                    },
                    validator: (_) => null,
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Is there a Drinking water facility each lab?",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomDropdown<String>(
                    hintText: "Select",
                    value: drinking ? "Yes" : "No",
                    items: yesNoList,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        drinking = v == "Yes";
                      });
                    },
                    validator: (_) => null,
                  ),

                ],)),
                _sectionTitle("Lab Infrastructure Details"),

                _card(child: Column(children: [
                  _textField(

                    title:"Name of the Primary ISP",

                    hint: "Name of the Primary ISP",
                    controller: primaryIsp,
                    validator: (v) =>
                    v!.isEmpty ? "system name is required" : null,
                  ),


                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Primary ISP Connection Type",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomDropdown<String>(
                    hintText: "Select ISP Type",
                    value: primaryIspType, // ✅ API value show hogi
                    items: ispTypes,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        primaryIspType = v; // ✅ update hoga
                      });
                    },
                    validator: (_) => null,
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(
                        child: _textField(

                          title:"Primary Internal Speed",

                          hint: "Primary Internal Speed",
                          controller: internateSpeedPrimary,
                          validator: (v) =>
                          v!.isEmpty ? "system name is required" : null,
                        ),
                        flex: 2,
                      ),
                      SizedBox(width: 7,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: CustomDropdown<String>(
                            hintText: "Unite",
                            value: primaryUnit, // ✅ API value show hogi
                            items: speeds,
                            itemLabel: (v) => v,
                            onChanged: (v) {
                              if (v == null) return;
                              setState(() {
                                primaryUnit = v; // ✅ update hoga
                              });
                            },
                            validator: (_) => null,
                          ),
                        ),
                      ),
                    ],
                  ),

                  _textField(

                    title:"Name of the Secondary ISP",

                    hint: "Name of the Secondary ISP",
                    controller: secondryIsp,
                    validator: (v) =>
                    v!.isEmpty ? "system name is required" : null,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Secondary ISP Connection Type",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomDropdown<String>(
                    hintText: "Select ISP Type",
                    value: secondaryIsptype, // ✅ API value show hogi
                    items: ispTypes,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        secondaryIsptype = v; // ✅ update hoga
                      });
                    },
                    validator: (_) => null,
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _textField(

                          title:"Secondary ISP Speed",

                          hint: "Secondary ISP Speed",
                          controller: internateSpeedSecondry,
                          validator: (v) =>
                          v!.isEmpty ? "system name is required" : null,
                        ),
                      ),
                      SizedBox(width: 7,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: CustomDropdown<String>(
                            hintText: "Unite",
                            value: secondryUnit, // ✅ API value show hogi
                            items: speeds,
                            itemLabel: (v) => v,
                            onChanged: (v) {
                              if (v == null) return;
                              setState(() {
                                secondryUnit = v; // ✅ update hoga
                              });
                            },
                            validator: (_) => null,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Generator Available", style: AppTextStyles.centerText)),
                  const SizedBox(height: 8),
                  CustomDropdown<String>(
                    hintText: "Select",
                    items: yesNoOptions,
                    itemLabel: (v) => v,
                    value: isGeneratorBackup ? "Yes" : "No",
                    onChanged: (v) {
                      setState(() {
                        isGeneratorBackup = (v == "Yes");
                      });
                    },
                  ),

                  /// SHOW ONLY IF YES
                  if (isGeneratorBackup) ...[
                    const SizedBox(height: 8),

                    _textField(
                      title: "Generator Capacity (in KVA)",
                      hint: "Generator Capacity (in KVA)",
                      controller: generatorCapacity,
                      validator: (v) =>
                      v!.isEmpty ? "Generator capacity is required" : null,
                    ),

                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Generator full tank Capacity (ltr)",
                        style: AppTextStyles.centerText,
                      ),
                    ),

                    const SizedBox(height: 8),

                    CustomDropdown<String>(
                      hintText: "Full Tank Capacity",
                      value: generatorFuilTank,
                      items: tankCapacityLtr,
                      itemLabel: (v) => v,
                      onChanged: (v) {
                        setState(() {
                          generatorFuilTank = v;
                        });
                      },
                      validator: (_) => null,
                    ),
                  ],
                  const SizedBox(height: 14),
                  _textField(
                    title: "UPS Backup (KVA)",
                    hint: "UPS Backup (KVA)",
                    controller: upsBackup,
                    validator: (v) =>
                    v!.isEmpty ? "Generator capacity is required" : null,
                  ),
                  SizedBox(height: 12,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "UPS Backup Time (in mins)",
                      style: AppTextStyles.centerText,
                    ),
                  ),

                  const SizedBox(height: 8),
                  CustomDropdown<String>(
                    hintText: "Full Tank Capacity",
                    value: upsBackupTimeMinutes,
                    items: upsBackupTimeOptions,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      setState(() {
                        upsBackupTimeMinutes = v;
                      });
                    },
                    validator: (_) => null,
                  ),
                ],)),


                _sectionTitle("Lab Details"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: labs.length,
                  itemBuilder: (context, index) => _labCard(index),
                ),


                // _sectionTitle("Lab Infrastructure Details"),
                //
                // _card(child: Column(children: [
                //   _textField(
                //
                //     title:"Name of the Primary ISP",
                //
                //     hint: "Name of the Primary ISP",
                //     controller: primaryIsp,
                //     validator: (v) =>
                //     v!.isEmpty ? "system name is required" : null,
                //   ),
                //
                //
                //   Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       "Primary ISP Connection Type",
                //       style: AppTextStyles.centerText,
                //     ),
                //   ),
                //   const SizedBox(height: 8),
                //   CustomDropdown<String>(
                //     hintText: "Select ISP Type",
                //     value: primaryIspType, // ✅ API value show hogi
                //     items: ispTypes,
                //     itemLabel: (v) => v,
                //     onChanged: (v) {
                //       if (v == null) return;
                //       setState(() {
                //         primaryIspType = v; // ✅ update hoga
                //       });
                //     },
                //     validator: (_) => null,
                //   ),
                //   SizedBox(height: 8,),
                //   Row(
                //     children: [
                //       Expanded(
                //         child: _textField(
                //
                //           title:"Primary Internal Speed",
                //
                //           hint: "Primary Internal Speed",
                //           controller: internateSpeedPrimary,
                //           validator: (v) =>
                //           v!.isEmpty ? "system name is required" : null,
                //         ),
                //         flex: 2,
                //       ),
                //       SizedBox(width: 7,),
                //       Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.only(top: 12.0),
                //           child: CustomDropdown<String>(
                //             hintText: "Unite",
                //             value: primaryUnit, // ✅ API value show hogi
                //             items: speeds,
                //             itemLabel: (v) => v,
                //             onChanged: (v) {
                //               if (v == null) return;
                //               setState(() {
                //                 primaryUnit = v; // ✅ update hoga
                //               });
                //             },
                //             validator: (_) => null,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                //
                //   _textField(
                //
                //     title:"Name of the Secondary ISP",
                //
                //     hint: "Name of the Secondary ISP",
                //     controller: secondryIsp,
                //     validator: (v) =>
                //     v!.isEmpty ? "system name is required" : null,
                //   ),
                //
                //   Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       "Secondary ISP Connection Type",
                //       style: AppTextStyles.centerText,
                //     ),
                //   ),
                //   const SizedBox(height: 8),
                //   CustomDropdown<String>(
                //     hintText: "Select ISP Type",
                //     value: secondaryIsptype, // ✅ API value show hogi
                //     items: ispTypes,
                //     itemLabel: (v) => v,
                //     onChanged: (v) {
                //       if (v == null) return;
                //       setState(() {
                //         secondaryIsptype = v; // ✅ update hoga
                //       });
                //     },
                //     validator: (_) => null,
                //   ),
                //   SizedBox(height: 8,),
                //   Row(
                //     children: [
                //       Expanded(
                //         flex: 2,
                //         child: _textField(
                //
                //           title:"Secondary ISP Speed",
                //
                //           hint: "Secondary ISP Speed",
                //           controller: internateSpeedSecondry,
                //           validator: (v) =>
                //           v!.isEmpty ? "system name is required" : null,
                //         ),
                //       ),
                //       SizedBox(width: 7,),
                //       Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.only(top: 12.0),
                //           child: CustomDropdown<String>(
                //             hintText: "Unite",
                //             value: secondryUnit, // ✅ API value show hogi
                //             items: speeds,
                //             itemLabel: (v) => v,
                //             onChanged: (v) {
                //               if (v == null) return;
                //               setState(() {
                //                 secondryUnit = v; // ✅ update hoga
                //               });
                //             },
                //             validator: (_) => null,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                //
                //   const SizedBox(height: 15),
                //   Align(
                //       alignment: Alignment.centerLeft,
                //       child: Text("Generator Available", style: AppTextStyles.centerText)),
                //   const SizedBox(height: 8),
                //   CustomDropdown<String>(
                //     hintText: "Select",
                //     items: yesNoOptions,
                //     itemLabel: (v) => v,
                //     value: isGeneratorBackup ? "Yes" : "No",
                //     onChanged: (v) {
                //       setState(() {
                //         isGeneratorBackup = (v == "Yes");
                //       });
                //     },
                //   ),
                //
                //   /// SHOW ONLY IF YES
                //   if (isGeneratorBackup) ...[
                //     const SizedBox(height: 8),
                //
                //     _textField(
                //       title: "Generator Capacity (in KVA)",
                //       hint: "Generator Capacity (in KVA)",
                //       controller: generatorCapacity,
                //       validator: (v) =>
                //       v!.isEmpty ? "Generator capacity is required" : null,
                //     ),
                //
                //     const SizedBox(height: 15),
                //
                //     Align(
                //       alignment: Alignment.topLeft,
                //       child: Text(
                //         "Generator full tank Capacity (ltr)",
                //         style: AppTextStyles.centerText,
                //       ),
                //     ),
                //
                //     const SizedBox(height: 8),
                //
                //     CustomDropdown<String>(
                //       hintText: "Full Tank Capacity",
                //       value: generatorFuilTank,
                //       items: tankCapacityLtr,
                //       itemLabel: (v) => v,
                //       onChanged: (v) {
                //         setState(() {
                //           generatorFuilTank = v;
                //         });
                //       },
                //       validator: (_) => null,
                //     ),
                //   ],
                //   const SizedBox(height: 14),
                //   _textField(
                //     title: "UPS Backup (KVA)",
                //     hint: "UPS Backup (KVA)",
                //     controller: upsBackup,
                //     validator: (v) =>
                //     v!.isEmpty ? "Generator capacity is required" : null,
                //   ),
                //   SizedBox(height: 12,),
                //   Align(
                //     alignment: Alignment.topLeft,
                //     child: Text(
                //       "UPS Backup Time (in mins)",
                //       style: AppTextStyles.centerText,
                //     ),
                //   ),
                //
                //   const SizedBox(height: 8),
                //   CustomDropdown<String>(
                //     hintText: "Full Tank Capacity",
                //     value: upsBackupTimeMinutes,
                //     items: upsBackupTimeOptions,
                //     itemLabel: (v) => v,
                //     onChanged: (v) {
                //       setState(() {
                //         upsBackupTimeMinutes = v;
                //       });
                //     },
                //     validator: (_) => null,
                //   ),
                // ],)),

                _sectionTitle("Bank Details"),
                _card(child: Column(children: [

                  _textField(
                    title: "Beneficiary name",
                    hint: "Name",
                    controller: benifiryName,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(
                    title: "Name of the bank",
                    hint: "bank",
                    controller: bankName,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(
                    title: "Bank Account Number",
                    hint: "account",
                    controller: bankAccount,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(
                    title: "bank IFSC Code",
                    hint: "bank",
                    controller: ifsc,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(
                    title: "PAN Number",
                    hint: "panNo",
                    controller: panno,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  // Do you have a GST number?
                  // Yes  No  make
                  yesNoSelector(
                    title: "Do you have GST number?",
                    value: hasGST,
                    yesChild: Column(
                      children: [
                        _textField(
                          title: "GST Number",
                          hint: "gst",
                          controller: gstNo,
                          validator: (v) =>
                          v!.isEmpty ? "Center name is required" : null,
                        ),


                      ],
                    ),
                  ),


                  _textField(
                    title: "GSt State Code",
                    hint: "gst State",
                    controller: gstStateCode,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  _textField(
                    title: "UIDHAI Number",
                    hint: "uidhai",
                    controller: uidiai,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),

                  yesNoSelector(
                    title: "Do you have an MSME number?",
                    value: has_msme,
                    yesChild: Column(
                      children: [
                        _textField(
                          title: "MSME Number",
                          hint: "msm number",
                          controller: MsmeNo,
                          validator: (v) =>
                          v!.isEmpty ? "Center name is required" : null,
                        ),


                      ],
                    ),
                  ),




                  GetBuilder<ProfileUpdateController>(
                    builder: (c) {
                      return Column(
                        children: [
                          uploadSection(
                            title: "Upload Center Entrance",
                            file: c.entranceImage,
                            onTap: () => c.pickFile(type: "entrance", isImage: true),
                          ),
                          uploadSection(
                            title: "Upload Cancelled Cheque",
                            file: c.canceledCheque,
                            onTap: () => c.pickFile(type: "cheque"),
                          ),
                          uploadSection(
                            title: "Upload Agreement",
                            file: c.agreementFile,
                            onTap: () => c.pickFile(type: "agreement"),
                          ),
                          uploadSection(
                            title: "Upload MOU",
                            file: c.mouFile,
                            onTap: () => c.pickFile(type: "mou"),
                          ),
                          uploadSection(
                            title: "Upload GST Certificate",
                            file: c.gstCertFile,
                            onTap: () => c.pickFile(type: "gst_cert"),
                          ),
                          uploadSection(
                            title: "Upload Udyam Certificate",
                            file: c.udyamCertFile,
                            onTap: () => c.pickFile(type: "udyam"),
                          ),
                          uploadSection(
                            title: "Upload PAN Card",
                            file: c.panNumberFile,
                            onTap: () => c.pickFile(type: "pan"),
                          ),
                        ],
                      );
                    },
                  ),


                ],)),




                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed:
                      controller.isLoading.value ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : Text(
                        "Update Center",
                        style: AppTextStyles.button,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? selectedRailwayDistance;
  String? selectedBusDistance;
  String? selectedMetroDistance;
  String? selectedAirportDistance;
  String? selectedUpsMinute;


  Widget _fileInfo(File? file) {
    if (file == null) return const SizedBox();

    final sizeKB = (file.lengthSync() / 1024).toStringAsFixed(1);

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        "${file.path.split('/').last} • $sizeKB KB",
        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
      ),
    );
  }

  File? entranceImage;
  File? canceledCheque;
  File? agreementFile;
  File? mouFile;
  File? gstCertFile;
  File? udyamCertFile;
  File? panNumberFile;

  File? labPhoto;
  File? mainGateImage;
  File? serverRoomImage;
  File? observerRoomImage;
  File? upsImage;
  File? walkthroughVideo;

  String? entranceFileName;
  int? entranceFileSizeBytes;

  Future<File?> _pickFile({required bool isVideo}) async {
    final picker = ImagePicker();

    final picked = isVideo
        ? await picker.pickVideo(source: ImageSource.gallery)
        : await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (picked == null) return null;

    final file = File(picked.path);
    final sizeMB = file.lengthSync() / (1024 * 1024);

    if (!isVideo && sizeMB > 1) {
      Get.snackbar("Error", "Image must be under 1 MB");
      return null;
    }
    if (isVideo && sizeMB > 5) {
      Get.snackbar("Error", "Video must be under 5 MB");
      return null;
    }
    return file;
  }


  Future<void> _pickEntranceImage() async {
    final file = await _pickFile(isVideo: false);
    if (file != null) setState(() => entranceImage = file);
  }

  Future<void> _pickLabPhoto() async {
    final file = await _pickFile(isVideo: false);
    if (file != null) setState(() => labPhoto = file);
  }

  Future<void> _pickWalkthroughVideo() async {
    final file = await _pickFile(isVideo: true);
    if (file != null) setState(() => walkthroughVideo = file);
  }

  String? categoryTypes;

  List<CountryModel> countryList = [];
  List<StateModel> stateList = [];
  List<CityModel> cityList = [];

  CountryModel? selectedCountry;
  StateModel? selectedState;
  CityModel? selectedCity;

  bool isCountryLoading = false;
  bool isStateLoading = false;
  bool isCityLoading = false;



  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: AppTextStyles.dashBordButton3,
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _textField({
    String? title, // 👈 optional
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (title != null && title.trim().isNotEmpty) ...[
            Text(
              title,
              style: AppTextStyles.centerText,
            ),
            const SizedBox(height: 6),
          ],

          /// 🔹 INPUT FIELD
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            validator: validator,
            style: AppTextStyles.inputLabel,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.inputLabel,
              filled: true,
              fillColor: const Color(0xFFF6F7FB),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _submit() async {

    final updateController = Get.put(ProfileUpdateController());

    /// UI → Controller
    updateController.labs = labs.map((lab) => lab.toJson()).toList();
    updateController.totalLab = labs.length.toString();
    print("🧪 LAB COUNT => ${updateController.labs.length}");
    print("🧪 LAB PAYLOAD => ${jsonEncode(updateController.labs)}");
    updateController.centerName = centerNameCtrl.text.trim();
    updateController.capacity = capacity.text.trim();
    updateController.postalAddress = addressCtrl.text.trim();
    updateController.centerDescription = description.text.trim();
    updateController.centerType = centerType.text.trim();
    updateController.addressLong = double.tryParse(centerLong.text.trim()) ?? 0.0;
    updateController.addressLat = double.tryParse(centerLat.text.trim()) ?? 0.0;
    updateController.localArea = localAreaName.text.trim();
    updateController.pincode = pincode.text.trim();
    updateController.landmark = landmark.text.trim();
    updateController.nearestRailway = railwayS.text.trim();
    updateController.nearestBusStop = busStop.text.trim();
    updateController.nearestMetro = metro.text.trim();
    updateController.nearestAirport = airport.text.trim();
    updateController.generatorCapacity = generatorCapacity.text.trim();
    updateController.primaryInternateSpeed = internateSpeedPrimary.text.trim();


    updateController.distaceBus = selectedBusDistance ?? "";
    updateController.distanceRailways = selectedRailwayDistance ?? "";
    updateController.distaceMetro = selectedMetroDistance ?? "";
    updateController.distaceAirport = selectedAirportDistance ?? "";
    // updateController.typeOfCenter = selectedCenterType!.centerType!;
    if (selectedCenterType != null) {
      updateController.typeOfCenter = selectedCenterType!.centerType!;
    }
    updateController.amName = pointOfContactName.text.trim();
    updateController.amNumber = pointOfContactNumber.text.trim();
    updateController.amEmail = pointOfContactEmail.text.trim();
    updateController.pocAltNumber = pocController.text.trim();

    updateController.pocName = pocName.text.trim();
    updateController.pocEmail = pocEmail.text.trim();
    updateController.pocNumber = pocNumber.text.trim();
    updateController.emergencyNo = emergencyNo.text.trim();
    updateController.landLineNo = landLineNo.text.trim();
    updateController.primaaryIsp = primaryIsp.text.trim();
    updateController.totalLab = totalLabCtrl.text.trim();
    updateController.networkTotal = totalNetwork.text.trim();
    updateController.benifiyName = benifiryName.text.trim();
    updateController.bankName = bankName.text.trim();
    updateController.bankAccount = bankAccount.text.trim();
    updateController.iFSC = ifsc.text.trim();
    updateController.panNo = panno.text.trim();
    updateController.gstNo = gstNo.text.trim();
    updateController.gstStateCode = gstStateCode.text.trim();
    updateController.UidiaNo = uidiai.text.trim();
    updateController.mSMENo = MsmeNo.text.trim();


    updateController.secondryIspType = secondryIsp.text.trim();
    updateController.fuilTnak = generatorFuilTank ?? "";
    updateController.upsBackuptimeMinutes =upsBackupTimeMinutes  ?? "";
    updateController.upsBackup = upsBackup.text.trim();

    updateController.csName = csName.text.trim();
    updateController.csEmail = csEmail.text.trim();
    updateController.csNumber = csNumber.text.trim();


    updateController.labs = labs.map((e) => e.toJson()).toList();
    updateController.connectSingle =
    isSingleNetwork ? "yes" : "no";
    updateController.partition = partition ? "yes" : "no";
    updateController.acInLab = ac ? "yes" : "no";
    updateController.networkPrinter = networkPrinter ? "yes" : "no";
    updateController.projectorLab = projector ? "yes" : "no";

    updateController.soundSystem = soundSystem ? "yes" : "no";
    updateController.fireExutter = fireExuter ?? "";
    updateController.lockerFacelity = lockerFacelity ? "yes" : "no";
    updateController.drinkingWater = drinking ? "yes" : "no";
    updateController.primaryIspType = primaryIspType ?? "";
    updateController.primaryInternateUnit = primaryUnit ?? "";
    updateController.secondryInternatetype = secondaryIsptype ?? "";
    updateController.secondryInternateUnit = secondryUnit ?? "";
    updateController.totalSystem = totalSystem.text.trim();

// lab infra

    updateController.primaaryIsp = primaryIsp.text.trim();


    updateController.liftAvailable = liftAvailable ?? "";

    updateController.entranceImage = entranceImage;
    updateController.canceledCheque = canceledCheque;
    updateController.agreementFile = agreementFile;
    updateController.mouFile = mouFile;
    updateController.gstCertFile =gstCertFile;
    updateController.udyamCertFile = udyamCertFile;
    updateController.panNumberFile = panNumberFile;
    updateController.labPhotos = labPhoto != null ? [labPhoto!] : [];
    updateController.mainGateImages = mainGateImage != null ? [mainGateImage!] : [];
    updateController.serverRoomImages =
    serverRoomImage != null ? [serverRoomImage!] : [];
    updateController.observerRoomImages =
    observerRoomImage != null ? [observerRoomImage!] : [];
    updateController.upsGeneratorImages =
    upsImage != null ? [upsImage!] : [];
    updateController.walkthroughVideo = walkthroughVideo;

    if (selectedCountry != null) updateController.countryId = selectedCountry!.id;
    if (selectedState != null) updateController.stateId = selectedState!.id;
    if (selectedCity != null) updateController.cityId = selectedCity!.id;
    if (categoryTypes != null) updateController.typeOfCenter = categoryTypes!;

    /// API CALL
    await updateController.updateCenterProfile(context);

    /// BACK + RESULT
    Get.back(result: true);
  }








  Widget _buildDropdownField({
    required String title,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    String? selectedValue = items.firstWhere(
          (element) => element.toLowerCase() == (value ?? "").toLowerCase().trim(),
      orElse: () => "", // use empty string or first item
    );

    if (selectedValue.isEmpty) selectedValue = null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          CustomDropdown<String>(
            hintText: "Select",
            value: selectedValue, // ✅ normalized value
            items: items,
            itemLabel: (v) => v,
            onChanged: (v) {
              if (v != null) {
                onChanged(v); // update your lab map
              }
            },
            validator: (_) => null,
          ),
        ],
      ),
    );
  }


  Widget _buildImageGallery(List<api.CenterImage> images) {
    if (images.isEmpty) {
      return const Center(child: Text("No Images Available"));
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final img = images[index];

          final imageUrl =
              "http://staging.bookmytestcenter.com/${img.centerImage.replaceFirst('/', '')}";

          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 30,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                  ),
                ),
              ),


              Positioned(
                top: 48,
                right: 75,
                child: GestureDetector(
                  onTap: () {
                    _confirmDelete(context, images, index);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 26,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }  void _confirmDelete(
      BuildContext context,
      List<api.CenterImage> images,
      int index,
      ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Image"),
        content: const Text("Are you sure you want to delete this image?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);

              setState(() {
                images.removeAt(index);
              });


            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }




  Widget uploadSection({
    required String title,
    required VoidCallback onTap,
    File? file,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(title, style: AppTextStyles.centerText),
        ),
        const SizedBox(height: 10),
        UploadingContainer(
          buttonText: file == null ? "Upload File" : "Change File",
          infoText: "Max Each file size: 1 MB | File type: jpg, png, jpeg, pdf",
          onPressed: onTap,
        ),
        if (file != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              file.path.split('/').last,
              style: const TextStyle(fontSize: 12, color: Colors.green),
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF6F7FB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }


  Widget _labCard(int index) {
    final lab = labs[index];

    List<String> _buildDropdownItems(String value, List<String> list) {
      final List<String> tempList = List.from(list);
      if (value.isNotEmpty && !tempList.contains(value)) {
        tempList.insert(0, value); // API value top pe
      }
      return tempList;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Lab Number ${index + 1}",
                  style: AppTextStyles.button,
                ),
              ),

              if (labs.length > 1)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      labs.removeAt(index);
                      totalLabCtrl.text = labs.length.toString();
                    });
                  },
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Floor
          Text("Floor Name", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _dropdown(
            "Select Floor",
            lab.floor,
            _buildDropdownItems(lab.floor, floorOptions),
                (v) => lab.floor = v,
          ),

          // Computers
          Text("Total number of computers?", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _textFields("", lab.computers, (v) => lab.computers = v),

          // Processor
          Text("System Processor", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _dropdown(
            "Select Processor",
            lab.processor,
            _buildDropdownItems(lab.processor, processor),
                (v) => lab.processor = v,
          ),

          // Monitor
          Text("Monitor Type", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _dropdown(
            "Select Monitor",
            lab.monitor,
            _buildDropdownItems(lab.monitor, monitor),
                (v) => lab.monitor = v,
          ),

          // OS
          Text("Operating System", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _dropdown(
            "Select OS",
            lab.os,
            _buildDropdownItems(lab.os, oss),
                (v) => lab.os = v,
          ),

          // RAM
          Text("RAM (in GB)", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _dropdown(
            "Select RAM",
            lab.ram,
            _buildDropdownItems(lab.ram, ram),
                (v) => lab.ram = v,
          ),

          // Hard Disk
          Text("Hard Disk Drive Capacity (in GB)", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _dropdown(
            "Select Hard Disk",
            lab.hardDisk,
            _buildDropdownItems(lab.hardDisk, hardDisk),
                (v) => lab.hardDisk = v,
          ),

          // Ethernet Switch Company
          Text("Ethernet Switch Company", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _dropdown(
            "Select Company",
            lab.ethernetSwitchCompany,
            _buildDropdownItems(lab.ethernetSwitchCompany, switchCompanies),
                (v) => lab.ethernetSwitchCompany = v,
          ),

          // Switch Category
          Text("Switch Category", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _dropdown(
            "Select Category",
            lab.switchCategory,
            _buildDropdownItems(lab.switchCategory, switchCategorie),
                (v) => lab.switchCategory = v,
          ),

          // No. of Ports
          Text("No. of Ports", style: AppTextStyles.centerText),
          SizedBox(height: 5),
          _dropdown(
            "Select Ports",
            lab.noOfPorts,
            _buildDropdownItems(lab.noOfPorts, switchParts),
                (v) => lab.noOfPorts = v,
          ),
        ],
      ),
    );
  }
  Widget _textFields(String label, String value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: value,
        keyboardType: TextInputType.number,
        decoration: _inputDecoration(label),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dropdown(
      String label,
      String value,
      List<String> items,
      Function(String) onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: items.contains(value) ? value : null,
        decoration: _inputDecoration(label),

        /// ✅ iOS-style icon
        icon:  Icon(
          CupertinoIcons.chevron_down,
          size: 18,
          color: Colors.black,
        ),

        items: items
            .map(
              (e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ),
        )
            .toList(),

        onChanged: (v) => onChanged(v ?? ''),
      ),
    );
  }


  // Future<void> _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   print("🔥 Get Current Location tapped");
  //   // 🔹 Check location service
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     AppToast.showError(context, "Location service is disabled");
  //     return;
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       AppToast.showError(context, "Location permission denied");
  //       return;
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     AppToast.showError(context, "Location permission permanently denied");
  //     return;
  //   }
  //
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //
  //   centerLat.text = position.latitude.toString();
  //   centerLong.text = position.longitude.toString();
  //
  //
  //
  //   AppToast.showSuccess(context, "Current location fetched");
  // }
  bool isInitializing = true;

  Future<void> _getCurrentLocation() async {
    await Future.delayed(Duration(milliseconds: 100));
    final pos = await Geolocator.getCurrentPosition();
    if (!mounted) return;
    setState(() {
      centerLat.text = pos.latitude.toString();
      centerLong.text = pos.longitude.toString();
    });
  }
  String? liftAvailable;


  Widget liftOption({
    required String value,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            liftAvailable = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: liftAvailable == value
                  ? Colors.grey.shade600
                  : Colors.grey.shade400,
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                activeColor: AppColors.primaryColor,
                checkColor: AppColors.background,
                value: liftAvailable == value,
                shape: const CircleBorder(),
                onChanged: (val) {
                  setState(() {
                    liftAvailable = value;
                  });
                },
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }



  final RxBool hasGST = false.obs;
  final RxBool has_msme = false.obs;

  Widget yesNoSelector({
    required String title,
    required RxBool value,
    Widget? yesChild, // 👈 Yes par kya dikhana hai
  }) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.centerText),
        const SizedBox(height: 8),

        Row(
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

        /// ✅ Yes par extra fields
        if (value.value == true && yesChild != null) ...[
          const SizedBox(height: 12),
          yesChild,
        ],
      ],
    ));
  }

}

class EditableLab {
  String id;
  String floor;
  String computers;
  String processor;
  String monitor;
  String os;
  String ram;
  String hardDisk;
  String ethernetSwitchCompany;
  String switchCategory;
  String noOfPorts;

  EditableLab({
    this.id = "",
    this.floor = '',
    this.computers = '',
    this.processor = '',
    this.monitor = '',
    this.os = '',
    this.ram = '',
    this.hardDisk = '',
    this.ethernetSwitchCompany = '',
    this.switchCategory = '',
    this.noOfPorts = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "floor_name": floor,
      "no_of_computer": computers,
      "window_generation": processor,
      "monitor_type": monitor,
      "operating_system": os,
      "ram": ram,
      "hard_disk": hardDisk,
      "ehternet_swtch_company": ethernetSwitchCompany,
      "switch_category": switchCategory,
      "no_of_port_eth_switch": noOfPorts,
    };
  }
}



