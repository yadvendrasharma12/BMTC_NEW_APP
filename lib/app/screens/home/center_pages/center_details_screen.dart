import 'package:bmtc_app/app/core/text_style.dart';
import 'package:bmtc_app/app/screens/home/center_pages/edit_center_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/profile_data_controller.dart';
import '../../../core/app_colors.dart';
import '../../../models/lab_model.dart';

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
  final profileController = Get.put(ProfileDataController());

  String? liftAvailable;

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


        final labs = data.labs; // <- yahan change kiya

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ================== Center Basic Details ==================
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Center Images", style: AppTextStyles.topHeading3),
                          GestureDetector(
                            onTap: () {
                              // Edit Center action
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: AppColors.blackColor,
                              ),
                              height: 36,
                              width: 130,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.edit_note_outlined,
                                    color: AppColors.background,
                                  ),
                                  const SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(EditCenterInformationScreen());
                                  },
                                      child: Text("Edit Center", style: AppTextStyles.button)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      _buildImageGallery(data.images),
                    ],
                  ),
                ),


                const SizedBox(height: 5),

                // ================== Center Details ==================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Text("Center Details", style: AppTextStyles.topHeading3),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Basic Details", style: AppTextStyles.linkText),
                      const SizedBox(height: 14),
                      _buildField("Center Name", data.center["center_name"]),
                      _buildField(
                        "Center Description",
                        data.center["center_description"],
                      ),
                      _buildField("Postal Address", data.center["address"]),
                      _buildField(
                        "Center Latitude",
                        data.center["address_lat"],
                      ),
                      _buildField(
                        "Center Longitude",
                        data.center["address_long"],
                      ),
                      _buildField("Center Capacity", data.center["capacity"]),
                      Text(
                        "Where is Center Located",
                        style: AppTextStyles.centerText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              "Country",
                              data.center["country_id"],
                            ),
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: _buildField(
                              "State",
                              data.center["state_id"],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildField("City", data.center["city_id"]),
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: _buildField(
                              "Local Address",
                              data.center["local_area_name"],
                            ),
                          ),
                        ],
                      ),
                      _buildField("Nearby Landmark", data.center["landmark"]),
                      _buildField(
                        "Is the Lift available for Physically Handicapped Candidate?",
                        data.center["landmark"],
                      ),

                      _buildField(
                        "Nearby Railway Station",
                        data.center["nearest_railway_station"],
                      ),
                      _buildField(
                        "Distance Railway Station",
                        data.center["distance_from_station"],
                      ),
                      _buildField(
                        "Nearby Bus Stop",
                        data.center["nearest_bus_stop"],
                      ),
                      _buildField(
                        "Distance bus Stop",
                        data.center["distance_from_bus_stop"],
                      ),
                      _buildField(
                        "Nearby Metro Station",
                        data.center["nearest_metro_station"],
                      ),
                      _buildField(
                        "Distance Metro Station",
                        data.center["distance_from_metro"],
                      ),
                      _buildField(
                        "Nearby Airport",
                        data.center["nearest_airport"],
                      ),
                      _buildField(
                        "Distance AirPort",
                        data.center["distance_from_airport"],
                      ),
                      SizedBox(height: 8),
                      Text("Admin Details", style: AppTextStyles.linkText),
                      SizedBox(height: 8),
                      _buildField(
                        "Point of Contact Name",
                        data.center["cs_name"],
                      ),
                      _buildField(
                        "Point of Contact Email",
                        data.center["cs_email"],
                      ),
                      _buildField(
                        "Point of Contact Mobile number",
                        data.center["cs_contact_number"],
                      ),
                      _buildField(
                        "Point of Contact alternate",
                        data.center["cs_phone_alternate"],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Center Superintendent details",
                        style: AppTextStyles.linkText,
                      ),
                      SizedBox(height: 8),
                      _buildField(
                        "Center Superintendent Name",
                        data.center["am_name"],
                      ),
                      _buildField(
                        "Center Superintendent Email",
                        data.center["am_email"],
                      ),
                      _buildField(
                        "Center Superintendent Phone",
                        data.center["am_contact_no"],
                      ),
                      SizedBox(height: 8),
                      Text("IT Manager Details", style: AppTextStyles.linkText),
                      SizedBox(height: 8),
                      _buildField("IT Manager Name", data.center["poc_name"]),
                      _buildField("IT Manager Email", data.center["poc_email"]),
                      _buildField(
                        "IT Manager Phone",
                        data.center["poc_contact_no"],
                      ),

                      SizedBox(height: 8),
                      Text(
                        "Emergency Contact number of the Center",
                        style: AppTextStyles.linkText,
                      ),
                      SizedBox(height: 8),
                      _buildField(
                        "Emergency Contact number",
                        data.center["emergency_contact_no"],
                      ),
                      _buildField("Emergency Contact Landline ", data.center["landline_number"],),
                    ],
                  ),
                ),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8,),
                      Text("General Lab details", style: AppTextStyles.linkText),
                      SizedBox(height: 8,),
                      _buildField("Total Number Of labs", data.center["total_no_lab"],),
                      _buildField("Total number of system,", data.center["total_no_system"],),
                      _buildField("Are all labs connected through a single network?", data.center["connected_single_network"],showDropdownArrow: true),
                      _buildField("Total networks", data.center["how_many_network"],),
                      _buildField("Is There a Partition in each System ", data.center["partitation"],showDropdownArrow: true),
                      _buildField("Is there an AC in each lab?", data.center["ac_in_each_lab"],showDropdownArrow: true),
                      _buildField("Is the Network Printer available?", data.center["network_printer"],showDropdownArrow: true),
                      _buildField("Is there a sound system in each lab?", data.center["projector_sound_system"],showDropdownArrow: true),
                      _buildField("Is there Fire Extinguisher in each lab?", data.center["fire_extinguisher"],showDropdownArrow: true),
                      _buildField("Is there CCTV in each lab?", data.center["no_of_cctv_each_lab"],showDropdownArrow: true),
                      _buildField("Is there a drinking water facility in/near the labs?", data.center["drinking_water_facility"],showDropdownArrow: true),




                      _buildField("Is the Network Printer available?", data.center["uidai_number"],),
                      _buildField("Is the Network Printer available?", data.center["uidai_number"],),
                      _buildField("Is the Network Printer available?", data.center["uidai_number"],),


                    ],),
                ),

                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8,),
                      Text("Lab Infrastructure Details", style: AppTextStyles.linkText),
                      SizedBox(height: 8,),
                      _buildField("Name of the Primary ISP", data.center["primary_isp_name"],showDropdownArrow: true),
                      _buildField("Primary ISP Connection Type", data.center["primary_isp_connect_type"],),
                      _buildField("Primary Internet speed", data.center["primary_isp_speed"],),
                      _buildField("Name of the Secondary ISP", data.center["secondary_isp_name"],showDropdownArrow: true),
                      _buildField("Secondary ISP Connection Type", data.center["secondary_isp_connect_type"],),
                      _buildField("Secondary ISP speed", data.center["secondary_isp_speed"],),
                      _buildField("Generator Available", data.center["network_printer"],showDropdownArrow: true),
                      _buildField("UPS Backup (KVA)", data.center["ups_backup_time"],),
                      _buildField("UPS Backup Time (in mins)", data.center["backup_minutes"],showDropdownArrow: true),



                      _buildField("Is the Network Printer available?", data.center["uidai_number"],),
                      _buildField("Is the Network Printer available?", data.center["uidai_number"],),
                      _buildField("Is the Network Printer available?", data.center["uidai_number"],),


                    ],),
                ),

                // ================== Lab Details ==================
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lab Details", style: AppTextStyles.topHeading3),
                    ],
                  ),
                ),

                if (labs.isNotEmpty)
                  ...labs.asMap().entries.map((entry) {
                    int index = entry.key;
                    final lab = entry.value;
                    return _buildLabCard(lab, index);
                  }).toList()
                else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "No Lab data available",
                      style: AppTextStyles.centerText,
                    ),
                  ),

                _buildCard(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 SizedBox(height: 8,),
                 Text("Bank Details", style: AppTextStyles.linkText),
                 SizedBox(height: 8,),
                   _buildField("Beneficiary Name", data.center["beneficiary_name"],),
                   _buildField("Name of the Bank", data.center["bank_name"],),
                   _buildField("Bank Account Number", data.center["bank_account_number"],),
                   _buildField("Bank IFSC Code", data.center["bank_ifsc_code"],),
                   _buildField("PAN Number ", data.center["pan_no"],),
                   _buildField("GST State Code ", data.center["gst_state_code"],),
                   _buildField("UIDAI Number", data.center["uidai_number"],),
               
               
               ],),
             )



              ],
            ),
          ),
        );
      }),
    );
  }

  // ================== Reusable Card Widget ==================
  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
      child: child,
    );
  }

  // ================== Reusable Field Widget ==================
  // ================== Reusable Field Widget as TextFormField ==================
  Widget _buildField(String title, String? value, {bool showDropdownArrow = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.centerText.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              color: AppColors.fillColorFB,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value ?? "N/A",
                    style: AppTextStyles.centerText,
                  ),
                ),
                if (showDropdownArrow)
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildLabCard(Lab lab, int index) {
    return _buildCard(
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
            ],
          ),
          const SizedBox(height: 15),
          _buildField("Floor Number", lab.floorName),
          _buildField("Total Number of Computers", lab.noOfComputer),
          _buildField("System Processor", lab.processor),
          _buildField("Monitor Type", lab.monitorType),
          _buildField("Operating System", lab.operatingSystem),
          _buildField("RAM (GB)", lab.ram),
          _buildField("Hard Disk (GB)", lab.hardDisk),
          _buildField("Ethernet Switch Company", lab.ethernetCompany),
          _buildField("Switch Category", lab.switchCategory),
          _buildField("No. of Port Ethernet Switch", lab.noOfPortEthSwitch),
        ],
      ),
    );
  }

  Widget _buildImageGallery(List<dynamic> images) {
    return SizedBox(
      height: 120, // height of image list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final img = images[index];
          final imageUrl = "http://staging.bookmytestcenter.com/${img["center_image"]}";

          return Container(
            margin: const EdgeInsets.only(right: 10),
            width: 160, // width of each image card
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.broken_image));
                },
              ),
            ),
          );
        },
      ),
    );
  }

}
