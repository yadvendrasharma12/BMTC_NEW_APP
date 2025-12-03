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

  final TextEditingController totalLabsController = TextEditingController();
  final TextEditingController totalSystemsController = TextEditingController();
  final TextEditingController totalNetworkController = TextEditingController();
  final TextEditingController primaryISPController = TextEditingController();
  final TextEditingController secondaryISPController = TextEditingController();
  final TextEditingController upsBackupController = TextEditingController();






  String? selectedTankCapacity;





  List<LabDetail> labs = [LabDetail()];




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



  bool _isPositiveNumber(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    final num? n = num.tryParse(trimmed);
    return n != null && n > 0;
  }



  void _validateAndNext() {

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
    Get.to(() =>  CenterDetailsPage4());
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
          Row(
            children: [
              _buildContainer(
                  "Basement",

              ),
            ],
          ),

          const SizedBox(height: 15),
          Text("Total Number of computers", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildContainer(
                  "100",

              ),
            ],
          ),

          const SizedBox(height: 15),
          Text("System Processor", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildContainer(
                  "i3",
                  showDropdownIcon: true
              ),
            ],
          ),

          const SizedBox(height: 15),
          Text("Monitor type", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildContainer(
                  "LCD",
                  showDropdownIcon: true
              ),
            ],
          ),

          const SizedBox(height: 15),
          Text("Operating System", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildContainer(
                  "Win 10",
                  showDropdownIcon: true
              ),
            ],
          ),

          const SizedBox(height: 15),
          Text("RAM (in GB)", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildContainer(
                  "8GB",
                  showDropdownIcon: true
              ),
            ],
          ),

          const SizedBox(height: 15),
          Text("Hard Disk Drive Capacity in GB",
              style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildContainer(
                  "1GB",
                  showDropdownIcon: true
              ),
            ],
          ),

          const SizedBox(height: 15),
          Text("Ethernet Switch Company", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildContainer(
                  "Netgear",
                  showDropdownIcon: true
              ),
            ],
          ),

          const SizedBox(height: 15),
          Text("Switch Category", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildContainer(
                  "Managed L2",
                  showDropdownIcon: true
              ),
            ],
          ),

          const SizedBox(height: 15),
          Text("No. of port Ethernet switch", style: AppTextStyles.centerText),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildContainer(
                  "8",
                  showDropdownIcon: true
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContainer(
      String label, {
        bool showDropdownIcon = false,
        VoidCallback? onTap,
      }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            left: 16,
            top: 13,
            bottom: 13,
            right: 8,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            color: AppColors.fillColorFB,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 👉 Text left side
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.centerText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// 👉 Optional dropdown arrow right side
              if (showDropdownIcon) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 25,
                ),
              ],
            ],
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 6,vertical: 4),
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 6,vertical: 4),
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
                    left: 12, right: 12, bottom: 12, top: 0),
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
                        style: AppTextStyles.linkText,
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
                      left: 12, right: 12, bottom: 12, top: 0),
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

                      Text("What is the Center Name?",
                          style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Centers "),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Text("Center Description (about center)",
                          style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Centers Description "),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Text("Centers Postal Address",
                          style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Indore "),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Text("Center Latitude",
                          style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("22.9656 "),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Text("Center Longitude",
                          style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("23.56766 "),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Text("Center Capacity",
                          style: AppTextStyles.centerText),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("100 "),
                        ],
                      ),
                      const SizedBox(height: 25),

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
                          _buildContainer("India "),
                          const SizedBox(width: 10),
                          _buildContainer("Utter Pradesh"),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          _buildContainer("Indore"),
                          const SizedBox(width: 10),
                          _buildContainer("Local"),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _buildContainer("123456 "),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "What is the Category of your Test Center",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Private "),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Any Nearby Landmark",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Sonarpur"),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Is the Lift available for Physically Handicapped Candidate?",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildYesNoRadio(liftAvailable ?? "", (val) {
                        setState(() {
                          liftAvailable = val;
                        });
                      }),

                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Name of Railway Station",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Railway Station"),
                        ],
                      ),

                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Distance from the railway station?",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Distance Railway"),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Name of Bus Station",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Bus Station"),
                        ],
                      ),

                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Distance from the Bus station?",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Distance Bus"),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Name of Metro Station",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Railway Metro"),
                        ],
                      ),

                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Distance from the Metro station?",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Distance Metro"),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Name of Airport Station",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Railway Airport"),
                        ],
                      ),

                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Distance from the Airport station?",
                          style: AppTextStyles.centerText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildContainer("Distance Airport"),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),

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
                    left: 12, right: 12, bottom: 12, top: 0),
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
                    Row(
                      children: [
                        _buildContainer("Name"),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text("Phone number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Phone number"),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("Alternate Phone number",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Alternate Phone number"),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("Email", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Email address"),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Center Superintendent details",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text("Name", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Name"),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("Phone Number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("phone number"),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("Email address", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Email address"),
                      ],
                    ),
                    const SizedBox(height: 23),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "IT Manager Details",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text("Name", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Name"),
                      ],
                    ),
                    const SizedBox(height: 14),

                    Text("Phone number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Phone number"),
                      ],
                    ),
                    const SizedBox(height: 15),

                    const SizedBox(height: 14),

                    Text("Email address", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Email address"),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Emergency Contact no of the Center",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text("Phone Number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Phone Number"),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("Landline Phone Number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("Landline Phone Number"),
                      ],
                    ),

                  ],
                ),
              ),


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
                    left: 12, right: 12, bottom: 12, top: 0),
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
                    Row(
                      children: [
                        _buildContainer("Lab No."),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Total number of systems",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer("100"),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Are all labs connected through a single network?",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Single Network",
                        showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Total Network", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "0",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Is there a partition in each System",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Is there an AC in each lab?",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Is the Network Printer available?",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Is there a projector in each lab?",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Is there a sound system in each lab?",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("How Many Fire Extinguisher in each lab",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Is there a Free Baggage Space?",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Is there a drinking water facility in/near the labs?",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

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
                    Row(
                      children: [
                        _buildContainer(
                            "Jio",

                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Primary ISP Connected Type",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Primary Internet Speed",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "200",

                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Name of the Secondary ISP",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",

                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Secondary ISP Connected Type",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Secondary Isp Speed",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "0",

                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("Generator Available",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text("UPS Backup (KVA)", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "23",

                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text("Ups backup time (in mins)",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                            "Yes",
                            showDropdownIcon: true
                        ),
                      ],
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
                    left: 12, right: 12, bottom: 12, top: 0),
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
                    Row(
                      children: [
                        _buildContainer(
                            "Aryan ",

                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("Name of the bank", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                          "Central Bank of India",

                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("Bank account number",
                        style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                          "0987654321",

                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("Bank IFSC code", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                          "CBIN023833",

                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("PAN Number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                          "ABCDE1234F",

                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("GST Number", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                          "27ABSCONDER12345F2",

                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text("GST State Code", style: AppTextStyles.centerText),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildContainer(
                          "85",

                        ),
                      ],
                    ),

                    // const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           Get.back();
                    //         },
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10),
                    //             border:
                    //             Border.all(color: const Color(0xffDDDDDD)),
                    //           ),
                    //           height: 48,
                    //           width: double.infinity,
                    //           child: Align(
                    //             alignment: Alignment.center,
                    //             child: Text(
                    //               "Go Back",
                    //               textAlign: TextAlign.center,
                    //               style: AppTextStyles.centerText,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 26),
                    //     Expanded(
                    //       flex: 2,
                    //       child: CustomPrimaryButton(
                    //         icon: Icons.arrow_right_alt_rounded,
                    //         text: "Next",
                    //         onPressed: _validateAndNext,
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
