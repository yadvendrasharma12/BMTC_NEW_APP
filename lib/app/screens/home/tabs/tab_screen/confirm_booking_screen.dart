import 'package:bmtc_app/app/screens/home/exam_details/exam_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/text_style.dart';
import '../../../../widgets/custom_textformfield.dart';
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
  String _selectedYear = "1Y";
  String _selectedYears = "1Y";

  final int _rowCount = 5;


  late List<bool> _rowCheckedList;

  @override
  void initState() {
    super.initState();
    _rowCheckedList = List<bool>.filled(_rowCount, false);
  }


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
                  currentCount: 0,
                  showYearDropdown: true,
                  selectedYear: _selectedYear,
                  onYearChanged: (val) {
                    setState(() {
                      _selectedYear = val ?? "1Y";
                    });
                  },
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
                  left: 20.0,
                  right: 20.0,
                  top: 12.0,
                  bottom: 10,
                ),
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
                          // 🔍 Search + Export row
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: AppTextField(
                                    controller: searchController,
                                    keyboardType: TextInputType.number,
                                    label: 'Search here',
                                    prefix: const Icon(Icons.search),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: _onExportTap,
                                    child: Container(
                                      height: 42,
                                      color: AppColors.blackColor,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Export",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.button,
                                          ),
                                          Icon(
                                            Icons.file_download_outlined,
                                            size: 20,
                                            color: AppColors.background,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: headerChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            headerChecked = val ?? false;
                                            // 🔹 header ke hisaab se sab rows update
                                            for (int i = 0;
                                            i < _rowCheckedList.length;
                                            i++) {
                                              _rowCheckedList[i] =
                                                  headerChecked;
                                            }
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Exam Name",
                                        style: AppTextStyles.centerSubTitle,
                                      ),
                                      const SizedBox(width: 28),
                                      Text(
                                        "From",
                                        style: AppTextStyles.centerSubTitle,
                                      ),
                                      const SizedBox(width: 76),
                                      Text(
                                        "Duration",
                                        style: AppTextStyles.centerSubTitle,
                                      ),
                                      const SizedBox(width: 25),
                                      Text(
                                        "Exam Date",
                                        style: AppTextStyles.centerSubTitle,
                                      ),
                                      const SizedBox(width: 70),
                                      Text(
                                        "Seats",
                                        style: AppTextStyles.centerSubTitle,
                                      ),
                                      const SizedBox(width: 25),
                                      Text(
                                        "Pricing",
                                        style: AppTextStyles.centerSubTitle,
                                      ),
                                      const SizedBox(width: 50),
                                      Text(
                                        "Status",
                                        style: AppTextStyles.centerSubTitle,
                                      ),
                                      const SizedBox(width: 55),
                                      Text(
                                        "Action",
                                        style: AppTextStyles.centerSubTitle,
                                      ),
                                    ],
                                  ),
                                ),

                                const Divider(height: 1),

                                // ===== ROWS =====
                                Column(
                                  children: List.generate(_rowCount, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: _rowCheckedList[index],
                                            onChanged: (val) {
                                              setState(() {
                                                _rowCheckedList[index] =
                                                    val ?? false;

                                                final allSelected =
                                                _rowCheckedList.every(
                                                        (e) => e == true);
                                                headerChecked = allSelected;
                                              });
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Bar Council",
                                            style: AppTextStyles.tableText,
                                          ),
                                          const SizedBox(width: 20),
                                          Text(
                                            "Testpan India",
                                            style: AppTextStyles.tableText,
                                          ),
                                          const SizedBox(width: 20),
                                          Text(
                                            "2 days",
                                            style: AppTextStyles.tableText,
                                          ),
                                          const SizedBox(width: 20),
                                          Text(
                                            "Mar 3th - 4th, 2025",
                                            style: AppTextStyles.tableText,
                                          ),
                                          const SizedBox(width: 20),
                                          Text(
                                            "470",
                                            style: AppTextStyles.tableText,
                                          ),
                                          const SizedBox(width: 20),
                                          Text(
                                            "Rs. 60/seat",
                                            style: AppTextStyles.tableText,
                                          ),
                                          const SizedBox(width: 20),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.ConfirmColor,
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            height: 30,
                                            width: 98,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Confirmed",
                                              style: AppTextStyles
                                                  .centerSubTitle,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(ExamDetailsScreen());
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 65,
                                              decoration: BoxDecoration(
                                                color: AppColors.blackColor,
                                                borderRadius:
                                                BorderRadius.circular(10),
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

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  void _onExportTap() async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Export started...')));
  }
}
