
import 'dart:io';


import 'package:bmtc_app/app/models/profile_data_model.dart' as api;
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';


import '../../../controllers/profile_data_controller.dart';
import '../../../controllers/profile_update_controller.dart';
import '../../../core/app_colors.dart';
import '../../../models/city_modal.dart';
import '../../../models/country_modal.dart';
import '../../../models/state_modal.dart';
import '../../../services/center_services.dart';
import '../../../services/location_services/location_service.dart';
import '../../../utils/toast_message.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../../widgets/uploading_container.dart';

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
  List<String> ethernetCompanies = []; // populate from API dynamically
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
  final TextEditingController totalLab = TextEditingController();
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




  @override
  void initState() {
    super.initState();

    _loadCountries();
    _fetchCenterTypes();





    final center = controller.profileDataModel.value!.data.center;
    Get.put(ProfileUpdateController());
    final labList = controller.profileDataModel.value?.data.labs ?? [];
    addressCtrl.text = center.address ?? '';
    description.text = center.description ?? '';
    centerType.text = center.centerType ?? '';
    centerLat.text = center.addressLat?? '';
    centerLong.text = center.addressLong ?? '';
    capacity.text = center.capacity ?? '';
    pincode.text = center.pinCode ?? '';
    localAreaName.text = center.localArea ?? '';
    airport.text = center.nearestAirport ?? '';
    pointOfContactEmail.text = center.amEmail ?? '';
    pocName.text = center.pocName ?? '';
    pocEmail.text = center.pocEmail ?? '';
    pocNumber.text = center.pocContactNo ?? '';
    emergencyNo.text = center.emergencyContactNo ?? '';
    landLineNo.text = center.landlineNumber ?? '';
    primaryIsp.text = center.primaryIspName ?? '';
    totalLab.text = center.totalNoLab ?? '';
    totalSystem.text = center.totalNoSystem ?? '';
    totalNetwork.text = center.howManyNetwork ?? '';
    bankName.text = center.bankName ?? '';
    bankAccount.text = center.bankAccount ?? '';
    ifsc.text = center.Ifsc ?? '';
    panno.text = center.panNo ?? '';
    gstStateCode.text = center.gstState ?? '';
    uidiai.text = center.uidainNo ?? '';
    MsmeNo.text = center.msmeNo ?? '';

    generatorCapacity.text = center.generatorBackupCapacity ?? '';
    internateSpeedPrimary.text = center.primaryIspSpeed ?? '';
    internateSpeedSecondry.text = center.secondaryIspSpeed ?? '';

    gstNo.text = center.gstNo ?? '';
    upsBackup.text = center.powerbachup ?? '';
    secondryIsp.text = center.secondaryIspName ?? '';



    csName.text = center.csName ?? '';
    csNumber.text = center.csContactNumber ?? '';
    csEmail.text = center.csEmail ?? '';



    labs = widget.apiLabs.map((lab) {
      // Floor, processor, etc.
      if (lab.floorName.isNotEmpty && !floors.contains(lab.floorName)) floors.add(lab.floorName);
      if (lab.processer.isNotEmpty && !processors.contains(lab.processer)) processors.add(lab.processer);
      if (lab.monitorType.isNotEmpty && !monitors.contains(lab.monitorType)) monitors.add(lab.monitorType);
      if (lab.ram.isNotEmpty && !rams.contains(lab.ram)) rams.add(lab.ram);
      if (lab.hardDisk.isNotEmpty && !hardDisks.contains(lab.hardDisk)) hardDisks.add(lab.hardDisk);
      if (lab.operatingSystem.isNotEmpty && !osList.contains(lab.operatingSystem)) osList.add(lab.operatingSystem);

      // ⚡ Ethernet fields
      if (lab.ehternetSwtchCompany.isNotEmpty && !ethernetCompanies.contains(lab.ehternetSwtchCompany)) {
        ethernetCompanies.add(lab.ehternetSwtchCompany);
      }
      if (lab.switchCategory.isNotEmpty && !switchCategories.contains(lab.switchCategory)) {
        switchCategories.add(lab.switchCategory);
      }
      if (lab.noOfPortEthSwitch.isNotEmpty && !ethernetPorts.contains(lab.noOfPortEthSwitch)) {
        ethernetPorts.add(lab.noOfPortEthSwitch);
      }

      return EditableLab(
        floor: lab.floorName ?? '',
        computers: lab.noOfComputer ?? '',
        processor: lab.processer ?? '',
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


    landmark.text = center.landmark ?? '';
    railwayS.text = center.nearestRailway ?? '';
    busStop.text = center.nearestBus ?? '';
    metro.text = center.nearestMetroStation ?? '';
    pointOfContactName.text = center.amName ?? '';
    pointOfContactNumber.text = center.amContactNo ?? '';
    altPointOfContactNumber.text = center.amContactNo ?? '';
    benifiryName.text = center.beneficiaryName ?? '';

    isSingleNetwork = parseYesNo(center.connectedSingleNetwork);
    partition       = parseYesNo(center.parttionEachLab);
    networkPrinter  = parseYesNo(center.printerLab);
    ac              = parseYesNo(center.acInLab);
    projector       = parseYesNo(center.projectorLab);
    soundSystem     = parseYesNo(center.soundSystem);
    drinking        = parseYesNo(center.drinkingWater);
    lockerFacelity  = parseYesNo(center.lockerFacelity);

    fireExuter = center.fireExuter;
    selectedRailwayDistance = center.distanceRailw.isNotEmpty ? center.distanceRailw : '';
    selectedBusDistance = center.distanceBus.isNotEmpty ? center.distanceBus : '';
    primaryUnit = unites.cast<String?>().firstWhere(
          (e) => e?.toLowerCase() == (center.primaryConnectType ?? '').toLowerCase(),
      orElse: () => null,
    );


    upsBackupTimeMinutes = unites.cast<String?>().firstWhere(
          (e) => e?.toLowerCase() == (center.upsBackupKua ?? '').toLowerCase(),
      orElse: () => null,
    );
    primaryUnit = unites.firstWhereOrNull(
          (e) => e.toLowerCase() == (center.primaryinternetspeedunit ?? '').toLowerCase(),
    );
    secondryUnit = unites.firstWhereOrNull(
          (e) => e.toLowerCase() == (center.secoundaryUnit ?? '').toLowerCase(),
    );
  }
  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> ispTypes = ['Broadband', 'Lease line', 'Fibre Optics', 'Air Fibre'];
  final List<String> speeds = ['Gbps', 'Mbps'];
  final List<String> upsBackupTimeOptions = ['5 mins','10 mins','15 mins','20 mins','25 mins','30 mins','35 mins','40 mins','50 mins','60 mins',];
  final List<String> tankCapacityLtr = ['1 ltr',  '1.5 ltr','2 ltr', '2.5 ltr', '3 ltr', '3.5 ltr', '4 ltr', '4.5 ltr', '5 ltr',];

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
  String? secondryType;
  String? generatorFuilTank;
  String? upsBackupTimeMinutes;
  String? primaryUnit;
  String? secondryUnit;

  final List<String> yesNoList = ["Yes", "No"];

  final List<String> isp = ["BrodCast", "BaseLine"];
  final List<String> unites = ["Mbps", "Gbps"];
  final List<String> fireCount = ["1", "2","3","4","5"];



  @override
  Widget build(BuildContext context) {
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


                _sectionTitle("Center Details"),
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
                      _textField(
                        title: "Center Type",
                        hint: "center Type",
                        controller:centerType,
                        validator: (v) =>
                        v!.isEmpty ? "center type is required" : null,
                      ),
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

                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomContainer(

                              text: "Get Location By Map",
                              onTap: () {

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
                          child: Text("Type Center Type", style: AppTextStyles.centerText)),
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
                    controller: pointOfContactNumber,
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
                    value: fireExuter,
                    items: fireCount,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        fireExuter = v;
                      });
                    },
                    validator: (_) => null,
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

                    hint: "primary isp",
                    controller: primaryIsp,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Primary ISP Connection Type",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdown<String>(
                          hintText: "Select Primary ISP",
                          value: primaryIspType, // must be null or exist in isp
                          items: isp,
                          itemLabel: (v) => v,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              primaryIspType = v;
                            });
                          },
                          validator: (_) => primaryIspType == null ? "Please select ISP" : null,
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex:2,
                        child: _textField(

                          title:"Primary Internate Speed",

                          hint: "primary speed",
                          controller: internateSpeedPrimary,
                          validator: (v) =>
                          v!.isEmpty ? "Center name is required" : null,
                        ),
                      ),
                      SizedBox(width: 6,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 9.0),
                          child: CustomDropdown<String>(
                            hintText: "select",
                            value: primaryUnit, // must be null or exist in isp
                            items: unites,
                            itemLabel: (v) => v,
                            onChanged: (v) {
                              if (v == null) return;
                              setState(() {
                                primaryUnit = v;
                              });
                            },
                            validator: (_) => primaryUnit == null ? "Please select ISP" : null,
                          ),
                        ),
                      ),
                    ],

                  ),
                  SizedBox(height: 8,),
                  _textField(

                    title:"Name of the Secondry ISP",

                    hint: "secondry isp",
                    controller: secondryIsp,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Secondary ISP Connection Type",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdown<String>(
                          hintText: "Select Secondary type",
                          value: generatorFuilTank, // must be null or exist in isp
                          items: isp,
                          itemLabel: (v) => v,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              generatorFuilTank = v;
                            });
                          },
                          validator: (_) => generatorFuilTank == null ? "Please select ISP" : null,
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex:2,
                        child: _textField(

                          title:"Secondary Internal Speed",

                          hint: "secondry speed",
                          controller: internateSpeedSecondry,
                          validator: (v) =>
                          v!.isEmpty ? "Center name is required" : null,
                        ),
                      ),
                      SizedBox(width: 6,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 9.0),
                          child: CustomDropdown<String>(
                            hintText: "select",
                            value: secondryUnit,
                            items: unites,
                            itemLabel: (v) => v,
                            onChanged: (v) {
                              if (v == null) return;
                              setState(() {
                                secondryUnit = v;
                              });
                            },
                            validator: (_) => secondryUnit == null ? "Please select ISP" : null,
                          ),
                        ),
                      ),

                    ],

                  ),

                  SizedBox(height: 8,),
                  _textField(

                    title:"Generator Capacity (in KVA)",

                    hint: "capacity",
                    controller: generatorCapacity,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Generator Fuel Tank Capacity (in Ltr.)",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  SizedBox(height: 7,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdown<String>(
                          hintText: "Select Secondary type",
                          value: secondryType, // must be null or exist in isp
                          items: tankCapacityLtr,
                          itemLabel: (v) => v,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              secondryType = v;
                            });
                          },
                          validator: (_) => secondryType == null ? "Please select ISP" : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  _textField(

                    title:"UPS Backup (KVA)",

                    hint: "capacity",
                    controller: upsBackup,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),

                  SizedBox(height: 7,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "UPS Backup Time (in mins)",
                      style: AppTextStyles.centerText,
                    ),
                  ),
                  SizedBox(height: 7,),
                  CustomDropdown<String>(
                    hintText: "select",
                    value: upsBackupTimeMinutes,
                    items: upsBackupTimeOptions,
                    itemLabel: (v) => v,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        upsBackupTimeMinutes = v;
                      });
                    },
                    validator: (_) => upsBackupTimeMinutes == null ? "Please select ISP" : null,
                  ),
                ],)),

                _sectionTitle("Lab Details"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: labs.length,
                  itemBuilder: (context, index) => _labCard(index),
                ),
                const SizedBox(height: 20),

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
                    title: "Pan Number",
                    hint: "panNo",
                    controller: panno,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
                  ),
                  // Do you have a GST number?
                  // Yes  No  make

                  _textField(
                    title: "GST Number",
                    hint: "gst",
                    controller: gstNo,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
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
                  _textField(
                    title: "MSME Number",
                    hint: "msm number",
                    controller: MsmeNo,
                    validator: (v) =>
                    v!.isEmpty ? "Center name is required" : null,
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
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Center(
                      child: Text(
                        "Update Center",
                        style:AppTextStyles.button ,
                      ),
                    ),
                  ),
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

          /// 🔹 SHOW TITLE ONLY IF NOT NULL & NOT EMPTY
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




  // ================= LOGIC =================

  void _submit() async {
    final updateController = Get.put(ProfileUpdateController());

    /// UI → Controller
    updateController.centerName = centerNameCtrl.text.trim();
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


    updateController.amName = pointOfContactName.text.trim();
    updateController.amNumber = pointOfContactNumber.text.trim();
    updateController.amEmail = pointOfContactEmail.text.trim();
    if (selectedCountry != null) {
      updateController.countryId = selectedCountry!.id;
    }
    if (selectedState != null) {
      updateController.stateId = selectedState!.id;
    }

    if (selectedCity != null) {
      updateController.cityId = selectedCity!.id;
    }
    updateController.pocName = pocName.text.trim();
    updateController.pocEmail = pocEmail.text.trim();
    updateController.pocNumber = pocNumber.text.trim();
    updateController.emergencyNo = emergencyNo.text.trim();
    updateController.landLineNo = landLineNo.text.trim();
    updateController.primaaryIsp = primaryIsp.text.trim();
    updateController.totalLab = totalLab.text.trim();
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
    updateController.secondryIsp = secondryIsp.text.trim();
    updateController.fuilTnak = generatorFuilTank ?? "";
    updateController.upsBackuptimeMinutes =upsBackupTimeMinutes  ?? "";
    updateController.upsBackup = upsBackup.text.trim();


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
    updateController.secondryInternatetype = secondryType ?? "";
    updateController.secondryInternateUnit = secondryUnit ?? "";







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

    if (selectedCountry != null) updateController.centerType = selectedCountry!.id;
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

    if (selectedValue.isEmpty) selectedValue = null; // convert empty back to null

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
          Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lab Number ${index + 1}", style: AppTextStyles.button),
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
  Widget _dropdown(String label, String value, List<String> items, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: items.contains(value) ? value : null,
        decoration: _inputDecoration(label),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => onChanged(v ?? ''),
      ),
    );
  }

}

class EditableLab {
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
      "floor_name": floor,
      "no_of_computer": computers,
      "window_generation": processor,
      "monitor_type": monitor,
      "operating_system": os,
      "ram": ram,
      "hard_disk": hardDisk,
      "ethernet_swtch_company": ethernetSwitchCompany,
      "switch_category": switchCategory,
      "no_of_ethernet_switch": noOfPorts,
    };
  }
}



