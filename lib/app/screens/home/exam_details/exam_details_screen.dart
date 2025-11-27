import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/text_style.dart';
import '../../../widgets/custom_textformfield.dart';

class ExamDetailsScreen extends StatefulWidget {
  const ExamDetailsScreen({super.key});

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  TextEditingController examDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [

                    Text("Bar Council Exam",
                        style: AppTextStyles.onBoard1stText),
                    Spacer(),
                    IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.close,color: AppColors.blackColor,)) ,
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text("Booking Received on",
                        style: AppTextStyles.topHeading3),
                    const SizedBox(width: 8),
                    Text("February 25th, 2025",
                        style: AppTextStyles.linkText),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 16),
                Text("Exam Details",
                    style: AppTextStyles.onBoard1stText),
                const SizedBox(height: 6),
                Text("Project details",
                    style: AppTextStyles.dashBordButton3),
                const SizedBox(height: 22),


                const _DetailFieldTile(
                  label: "Exam Date",
                  value: "March 3rd",
                ),

                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Exam Category",
                  value: "Government",
                ),

                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Exam City",
                  value: "Delhi",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Seats",
                  value: "460",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "From",
                  value: "TestPan India",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Pricing",
                  value: "Rs. 60 / Seats",
                ),
                SizedBox(height: 22,),
                Text("Software & Hardware Requirements",
                    style: AppTextStyles.dashBordButton3),
                SizedBox(height: 20,),
                const _DetailFieldTile(
                  label: "Exam Mode",
                  value: "Internat Based",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Exam Mode",
                  value: "Internat Based",
                ),
                SizedBox(height: 22,),
                Text("Computer Configure",
                    style: AppTextStyles.dashBordButton3),
                SizedBox(height: 20,),
                const _DetailFieldTile(
                  label: "Operating System",
                  value: "windows 10",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "RAM",
                  value: "4GB",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Processor",
                  value: "I-7 10th GEN",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Display Resolution",
                  value: "1200 * 800",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Internet on each device",
                  value: "Yes",
                ),
                SizedBox(height: 22,),
                Text("Amenity Rearmament",
                    style: AppTextStyles.dashBordButton3),
                SizedBox(height: 20,),
                const _DetailFieldTile(
                  label: "Parking Facility",
                  value: "Yes",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Security Guard",
                  value: "Male",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Lookers",
                  value: "Yes",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Waiting Area",
                  value: "No",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Power Backup",
                  value: "Yes",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "PH handicapped",
                  value: "No",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Printer",
                  value: "Yes",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Rough Sheet",
                  value: "Yes",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Partition",
                  value: "Yes",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "AC in Lab",
                  value: "Yes",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "CCTV Required",
                  value: "Yes",
                ),
                const SizedBox(height: 16),
                const _DetailFieldTile(
                  label: "Footage Required",
                  value: "Yes",
                ),
                SizedBox(height: 26,),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Have a Question? ",
                        style: GoogleFonts.karla(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xff737373),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                      //    Get.to(ForgetScreen());
                        },
                        child: Text("Contact Us", style: AppTextStyles.linkText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 🔻 Same file ke niche yahi helper widget hai
class _DetailFieldTile extends StatelessWidget {
  final String label;
  final String value;

  const _DetailFieldTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.tableText),
        const SizedBox(height: 8),
        Container(
          height: 48,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            value,
            style: AppTextStyles.dashBordButton2,
          ),
        ),
      ],
    );
  }
}
