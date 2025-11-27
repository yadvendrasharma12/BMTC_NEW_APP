
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../widgets/custom_textformfield.dart';
import '../exam_details/exam_details_screen.dart';
import '../widgets/action_button_card.dart';
import '../widgets/add_booking_dailog.dart';
import '../widgets/status_summary_card.dart';

class SelfBookingScreen extends StatefulWidget {
  const SelfBookingScreen({super.key});

  @override
  State<SelfBookingScreen> createState() => _SelfBookingScreenState();
}

class _SelfBookingScreenState extends State<SelfBookingScreen> {
  final TextEditingController searchController = TextEditingController();
  bool headerChecked = false;
  String _selectedYear = "1Y";
  String _selectedYears = "1Y";
  bool rowChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text("My Self bookings",style: AppTextStyles.heading2,),
      ),
      backgroundColor: AppColors.borderColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: StatusSummaryCard(
                    title: "Total bookings",
                    currentCount: 58,
                    percentage: 64.54,
                    iconPath: "assets/icons/check.png",
                    showYearDropdown: true,
                    selectedYear: _selectedYears,
                    onYearChanged: (val) {
                      setState(() {
                        _selectedYear = val ?? "1Y";
                      });
                    },
        
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                  ),
                  child: ActionButtonsCard(
                    primaryText: "Add Custom booking",

                    onPrimaryTap: () {

                      showDialog(
                        context: context,
                        builder: (_) => AddBookingDialog(
                          examTypeOptions: const ["Online", "Offline", "Hybrid"],
                          labOptions: const ["Lab 1", "Lab 2"],
                          yesNoOptions: const ["Yes", "No"],
                        ),
                      );
                    },


                  ),
                ),
        
        
        
        
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 12.0, bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.grey73),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(children: [
                                Expanded(
                                  flex:3,
                                  child: AppTextField(
                                    controller: searchController,
                                    keyboardType: TextInputType.number,
                                    label: 'Search here',
                                    prefix: Icon(Icons.search),
        
                                  ),
                                ),


                              ],),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border:Border.all(color: AppColors.borderColor)
                                    ),
                                    width: 120,
                                    height: 42,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          "Filter by",style: AppTextStyles.centerText,),
                                        Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.blackColor,size: 27,)
                                      ],),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 42,
                                    color: AppColors.blackColor,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          "Export",style: AppTextStyles.button,),
                                        Icon(Icons.file_download_outlined,color: AppColors.background,)
                                      ],),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 1),
        
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ===== HEADER ROW =====
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: headerChecked,
                                          onChanged: (val) {
                                            setState(() {
                                              headerChecked = val ?? false;
                                            });
                                          },
                                        ),
                                        const SizedBox(width: 5),
                                        Text("Exam Name",
                                            style: AppTextStyles.centerSubTitle),
                                        const SizedBox(width: 28),
                                        Text("From", style: AppTextStyles.centerSubTitle),
                                        const SizedBox(width: 76),
                                        Text("Duration",
                                            style: AppTextStyles.centerSubTitle),
                                        const SizedBox(width: 25),
                                        Text("Exam Date",
                                            style: AppTextStyles.centerSubTitle),
                                        const SizedBox(width: 70),
                                        Text("Seats", style: AppTextStyles.centerSubTitle),
                                        const SizedBox(width: 25),
                                        Text("Pricing",
                                            style: AppTextStyles.centerSubTitle),
                                        const SizedBox(width: 50),
                                        Text("Status",
                                            style: AppTextStyles.centerSubTitle),
                                        const SizedBox(width: 55),
                                        Text("Action",
                                            style: AppTextStyles.centerSubTitle),
                                      ],
                                    ),
                                  ),
        
                                  const Divider(height: 1),
        
                                  // ===== DATA ROWS =====
                                  Column(
                                    children: List.generate(5, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: rowChecked,
                                              onChanged: (val) {
                                                setState(() {
                                                  rowChecked = val ?? false;
                                                });
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                            Text("Bar Council",
                                                style: AppTextStyles.tableText),
                                            const SizedBox(width: 20),
                                            Text("Testpan India",
                                                style: AppTextStyles.tableText),
                                            const SizedBox(width: 20),
                                            Text("2 days",
                                                style: AppTextStyles.tableText),
                                            const SizedBox(width: 20),
                                            Text("Mar 3th - 4th, 2025",
                                                style: AppTextStyles.tableText),
                                            const SizedBox(width: 20),
                                            Text("470", style: AppTextStyles.tableText),
                                            const SizedBox(width: 20),
                                            Text("Rs. 60/seat",
                                                style: AppTextStyles.tableText),
                                            const SizedBox(width: 20),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.yellow.shade100,
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              height: 30,
                                              width: 98,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Active",
                                                style: AppTextStyles.centerSubTitle,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(ExamDetailsScreen());
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 65,
                                                decoration: BoxDecoration(
                                                  color: AppColors.blackColor,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "View",
                                                  style: AppTextStyles.button,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        
        
        
        
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

