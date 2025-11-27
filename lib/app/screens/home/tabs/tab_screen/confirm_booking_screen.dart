
import 'package:bmtc_app/app/screens/home/exam_details/exam_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/text_style.dart';
import '../../center_pages/center_page_screen.dart';
import '../../self_booking/self_booking_screen.dart';
import '../../widgets/action_button_card.dart';
import '../../widgets/add_booking_dailog.dart';
import '../../widgets/status_summary_card.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key});

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  final TextEditingController searchController = TextEditingController();
  bool headerChecked = false;
  bool rowChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StatusSummaryCard(
                  title: "Confirmed bookings",
                  currentCount: 58,
                  totalCount: 62,
                  percentage: 64.54,
                  iconPath: "assets/icons/check.png",

                ),
              ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 10.0,
          ),
          child: StatusSummaryCard(
            title: "Seats Booked",
            currentCount: 1385,
            percentage: 93.54,
            iconPath: "assets/icons/seat_booked.png",

          ),
        ),


              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 10.0,
                ),
                child: ActionButtonsCard(
                  primaryText: "Custom booking",
                  secondaryText: "Edit Center profile",
                  onPrimaryTap: () {
                    Get.to(SelfBookingScreen());

                  },
                  onSecondaryTap: () {
                    Get.to(CenterPageScreen());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 12.0, bottom: 10),
                child: Container(

                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.grey73),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              Text("Exam Name", style: AppTextStyles.centerSubTitle),
                              const SizedBox(width: 28),
                              Text("From", style: AppTextStyles.centerSubTitle),
                              const SizedBox(width: 76),
                              Text("Duration", style: AppTextStyles.centerSubTitle),
                              const SizedBox(width: 25),
                              Text("Exam Date", style: AppTextStyles.centerSubTitle),
                              const SizedBox(width: 70),
                              Text("Seats", style: AppTextStyles.centerSubTitle),
                              const SizedBox(width: 25),
                              Text("Pricing", style: AppTextStyles.centerSubTitle),
                              const SizedBox(width: 50),
                              Text("Status", style: AppTextStyles.centerSubTitle),
                              const SizedBox(width: 55),
                              Text("Action", style: AppTextStyles.centerSubTitle),
                            ],
                          ),
                        ),
                        const Divider(),
                        Column(
                          children: List.generate(5, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                  Text("Bar Council", style: AppTextStyles.tableText),
                                  const SizedBox(width: 20),
                                  Text("Testpan India", style: AppTextStyles.tableText),
                                  const SizedBox(width: 20),
                                  Text("2 days", style: AppTextStyles.tableText),
                                  const SizedBox(width: 20),
                                  Text("Mar 3th - 4th, 2025", style: AppTextStyles.tableText),
                                  const SizedBox(width: 20),
                                  Text("470", style: AppTextStyles.tableText),
                                  const SizedBox(width: 20),
                                  Text("Rs. 60/seat", style: AppTextStyles.tableText),
                                  const SizedBox(width: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.ConfirmColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    height: 30,
                                    width: 98,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Confirmed",
                                      style: AppTextStyles.centerSubTitle,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: (){
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
                ),
              ),



              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
