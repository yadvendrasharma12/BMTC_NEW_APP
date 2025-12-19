import 'package:bmtc_app/app/screens/home/center_pages/edit_center_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_data_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../models/profile_data_model.dart' as api;

class CenterDetailsScreen extends StatefulWidget {
  const CenterDetailsScreen({super.key});

  @override
  State<CenterDetailsScreen> createState() => _CenterDetailsScreenState();
}

class _CenterDetailsScreenState extends State<CenterDetailsScreen> {
  final profileController = Get.put(ProfileDataController());
  String formatBooleanField(String? value) {
    if (value == null || value.isEmpty) return "N/A";
    if (value.toLowerCase() == "true") return "Yes";
    if (value.toLowerCase() == "false") return "No";
    return value; // For any other value, show as-is
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = profileController.profileDataModel.value?.data;
        if (data == null) {
          return const Center(child: Text("No data found"));
        }

        final api.Center center = data.center;
        final List<api.Lab> labs = data.labs ?? [];
        final List<api.CenterImage> images = data.images ?? [];
        final List<api.Country> countries = data.countries ?? [];
        final List<api.State> states = data.states ?? [];
        final List<api.City> cities = data.cities ?? [];
        final List<api.CenterType> centerTypes = data.centerType ?? [];
        final List<api.Document> documents = data.documents ?? [];

        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.05),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  const SizedBox(height: 20),

                  Padding(
                    padding:  EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Center Images", style: AppTextStyles.dashBordButton3),
                        Row(
                          children: [

                            GestureDetector(
                              onTap: (){
                                Get.to(EditCenterInformationScreen(apiLabs: labs));
                              },
                              child: Container(
                                height: 40,
                                width: 135,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit_note_outlined,color: Colors.white,),
                                    SizedBox(width: 7,),
                                    Text("Edit Center",style: AppTextStyles.button,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  _buildImageGallery(images),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Last updated on 05/03/2025", style: AppTextStyles.caption),
                        SizedBox(height: 7,),
                        Divider()
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text("Center Details", style: AppTextStyles.dashBordButton3),
                  ),

                  _buildCenterInfo(center, countries, states, cities, centerTypes),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text("Admin / Contact Details", style: AppTextStyles.topHeading3),
                  ),
                  _buildAdminDetails(center),
                  const SizedBox(height: 20),
                  _buildInfrastructureDetails(center),
                  const SizedBox(height: 20),

                  // ===== Lab Details =====
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text("Lab Details", style: AppTextStyles.topHeading3),
                  ),
                  if (labs.isNotEmpty)
                    ...labs.asMap().entries.map((entry) {
                      final lab = entry.value;
                      return _buildLabCard(lab, entry.key);
                    }).toList()
                  else
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("No Lab data available", style: AppTextStyles.centerText),
                    ),

                  const SizedBox(height: 20),
                  _buildBankDetails(center),



                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text("Upload Documents", style: AppTextStyles.dashBordButton3),
                  ),
                  _buildDocumentsSection(documents),
                  // ===== Admin Details =====

                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // ===== Center Info Section =====
  Widget _buildCenterInfo(
      api.Center center,
      List<api.Country> countries,
      List<api.State> states,      // add states list
      List<api.City> cities,       // add cities list
      List<api.CenterType> centerTypes,
      ) {
    // Map countryId → countryName
    String countryName = countries
        .firstWhere((c) => c.id == center.countryId, orElse: () => api.Country(id: '', name: 'N/A'))
        .name;

    // Map stateId → stateName
    String stateName = states
        .firstWhere((s) => s.id == center.stateId, orElse: () => api.State(id: '', name: 'N/A'))
        .name;

    // Map cityId → cityName
    String cityName = cities
        .firstWhere((c) => c.id == center.cityId, orElse: () => api.City(id: '', name: 'N/A'))
        .name;

    // Map centerType id → centerTypeName
    String centerTypeName = centerTypes
        .firstWhere((ct) => ct.id == center.centerType, orElse: () => api.CenterType(id: '', centerType: center.centerType))
        .centerType;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField("Center Name", center.centerName),
          _buildField("Address", center.address),
          _buildField("Center's Latitude", center.addressLat),
          _buildField("Center's Longitude", center.addressLong),
          _buildField("Center Capacity", center.capacity),
          _buildField("Country", countryName),
          _buildField("State", stateName),
          _buildField("City", cityName),
          _buildField("Local Area Name", center.localArea),
          _buildField("Pin Code", center.pinCode),
          _buildField("Center Type", centerTypeName),
          _buildField("Center Description", center.description.isNotEmpty ? center.description : "No Description"),
          _buildField("Center nearby landmark", center.landmark),
          _buildField("Nearest Railway Station", center.nearestRailway),
          _buildField("Distance from Railway Station", center.distanceRailw),
          _buildField("Nearest Bus Station", center.nearestBus),
          _buildField("Distance from Bus Station", center.distanceBus),
          _buildField("Nearest Metro Station", center.nearestMetroStation),
          _buildField("Distance from Metro Station", center.distanceFromMetro),
          _buildField("Nearest Airport", center.nearestAirport),
          _buildField("Distance from Airport", center.distanceFromAirport),
        ],
      ),
    );
  }

  // ===== Admin Details =====
  Widget _buildAdminDetails(api.Center center) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16),
            child: Text("Point of Contact",style: AppTextStyles.centerText,),
          ),
          _buildField("", center.pocName,showTitle: false),
          _buildField("", center.pocContactNo,showTitle: false),
          _buildField("", center.pocMobileAlternate,showTitle: false),
          _buildField("", center.pocEmail,showTitle: false),
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16),
            child: Text("Center Superintendent details",style: AppTextStyles.centerText,),
          ),
          _buildField("AM Name", center.csName,showTitle: false),
          _buildField("AM Contact", center.csContactNumber,showTitle: false),
          _buildField("AM Email", center.csEmail),
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16),
            child: Text("IT Manager Details",style: AppTextStyles.centerText,),
          ),
          _buildField("POC Name", center.amName,showTitle: false),
          _buildField("POC Contact", center.amContactNo,showTitle: false),
          _buildField("POC Mobile Alternate", center.amEmail),
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16),
            child: Text("Emergency Contact number of the Center",style: AppTextStyles.centerText,),
          ),
          _buildField("POC Name", center.emergencyContactNo,showTitle: false),
          _buildField("POC Contact", center.landlineNumber,showTitle: false),
        //  _buildField("POC Email", center.pocEmail),
        ],
      ),
    );
  }
  // ===== Infrastructure Details =====
  Widget _buildInfrastructureDetails(api.Center center) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 16),
            child: Text("Infrastructure Details", style: AppTextStyles.centerText),
          ),
          _buildField("Total Computers", center.totalNoSystem),
          _buildField("Total Labs", center.totalNoLab),
          _buildField(
            "Are all labs connected through a single network?",
            formatBooleanField(center.connectedSingleNetwork),
          ),
          _buildField("Total Network", center.howManyNetwork),
          _buildField(
            "Is There a Partition in each System",
            formatBooleanField(center.parttionEachLab),
          ),
          _buildField(
            "Is there an AC in each lab?",
            formatBooleanField(center.acInLab),
          ),
          _buildField(
            "Is the Network Printer available?",
            formatBooleanField(center.printerLab),
          ),
          _buildField(
            "Is there a projector in each lab?",
            formatBooleanField(center.projectorLab),
          ),
          _buildField(
            "Is there a sound system in each lab?",
            formatBooleanField(center.soundSystem),
          ),
          _buildField(
            "Is there Fire Extinguisher in each lab?",
            formatBooleanField(center.fireExuter),
          ),
          _buildField(
            "Is there a Locker Facility",
            formatBooleanField(center.lockerFacelity),
          ),
          _buildField(
            "Is there a drinking water facility in/near the labs?",
            formatBooleanField(center.drinkingWater),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 16),
            child: Text("Lab Infrastructure details", style: AppTextStyles.centerText),
          ),

          _buildField("Name of the Primary ISP", center.primaryIspName),
          _buildField(
              "Primary Internet speed",
              "${center.primaryConnectType ?? 'N/A'} (${center.primaryIspSpeed ?? '0'} ${center.speedUnitPrimary ?? ''})"
          ),

          _buildField("Primary ISP Connection Type", center.primaryConnectType),

          _buildField("Name of the Secondary ISP", center.secondaryIspName),

          _buildField(
              "Secondary ISP speed",
              "${center.primaryConnectType ?? 'N/A'} (${center.secondaryIspSpeed ?? '0'} ${center.secoundaryUnit ?? ''})"
          ),
          _buildField("Secondary ISP Connection Type", center.secondaryConnectedType),
          _buildField("UPS Backup(KVA)", center.upsBackupKua),
          _buildField("UPS Backup Time(in mins)", center.upsBackupTime),

        ],
      ),
    );
  }

// ===== Bank Details =====
  Widget _buildBankDetails(api.Center center) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 16),
            child: Text("Bank Details", style: AppTextStyles.centerText),
          ),

          _buildField("Beneficiary Name", center.beneficiaryName),
          _buildField("Name of the bank", center.bankName),
          _buildField("Bank Account number", center.bankAccount),
          _buildField("Bank IFSC code", center.Ifsc),
          _buildField("PAN number", center.panNo),
          _buildField("GST State code", center.gstState),
          _buildField("UIDAI Number", center.uidainNo),

        ],
      ),
    );
  }


  // ===== Generic Field Widget =====
  Widget _buildField(
      String title,
      String? value, {
        bool showDropdownArrow = false,
        bool showTitle = true, // New parameter to show or hide title
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle) // Only show title if showTitle is true
            Text(
              title,
              style: AppTextStyles.centerText.copyWith(fontWeight: FontWeight.w500),
            ),
          if (showTitle) const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.fillColorFB,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value?.isNotEmpty == true ? value! : "N/A",
                    style: AppTextStyles.centerText,
                  ),
                ),
                if (showDropdownArrow)
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildLabCard(api.Lab lab, int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 160,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                "Lab ${index + 1}",
                style: AppTextStyles.button,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildField("Floor", lab.floorName),
          _buildField("Total Computers", lab.noOfComputer),
          _buildField("window_generation", lab.processer),
          _buildField("Monitor Type", lab.monitorType),
          _buildField("Operating System", lab.operatingSystem),
          _buildField("RAM (GB)", lab.ram),
          _buildField("Hard Disk (GB)", lab.hardDisk),
          _buildField("Ethernet Company", lab.ehternetSwtchCompany),
          _buildField("Switch Category", lab.switchCategory),
          _buildField("No. of Ports", lab.noOfPortEthSwitch),
        ],
      ),
    );
  }


  // ===== Image Gallery =====
  Widget _buildImageGallery(List<api.CenterImage> images) {
    if (images.isEmpty) return const Center(child: Text("No Images Available"));
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final img = images[index];
          final imageUrl = "http://staging.bookmytestcenter.com/${img.centerImage}";
          return Container(
            margin: const EdgeInsets.only(right: 10),
            width: 160,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildDocumentsSection(List<api.Document> documents) {
    if (documents.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "No documents uploaded",
          style: AppTextStyles.centerText,
        ),
      );
    }

    return ListView.builder(
      itemCount: documents.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final doc = documents[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Container(
            padding: const EdgeInsets.all(14),
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
            child: Row(
              children: [
                const Icon(Icons.description, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc.docName.isNotEmpty ? doc.docName : "Document",
                        style: AppTextStyles.centerText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doc.url,
                        style: AppTextStyles.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () {
                    // yaha URL open karwa sakte ho
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.dashBordButton3),
          const SizedBox(height: 12),
          child,
        ],
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

}
