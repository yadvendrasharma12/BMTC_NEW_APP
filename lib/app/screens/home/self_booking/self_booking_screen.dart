import 'package:bmtc_app/app/screens/home/exam_details/counsling_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/self_booking_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../utils/toast_message.dart';
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
  final SelfBookingController controller = Get.find<SelfBookingController>();
  bool headerChecked = false;
  late List<bool> rowCheckedList;
  List<Map<String, dynamic>> filteredBookings = [];

  @override
  void initState() {
    super.initState();
    rowCheckedList = [];

    // Listen to search input changes
    searchController.addListener(_filterBookings);
  }

  void _filterBookings() {
    final query = searchController.text.toLowerCase();
    final data = controller.selfBookingModel.value?.data;
    final bookings = (filteredBookings.isNotEmpty || searchController.text.isNotEmpty)
        ? filteredBookings
        : List<Map<String, dynamic>>.from(data?.selfBookingData ?? []);

    setState(() {
      if (query.isEmpty) {
        filteredBookings = bookings
            .map((e) => e) // safe cast
            .toList();
      } else {
        filteredBookings = bookings
            .map((e) => e) // safe cast
            .where((item) {
          final location = (item['exam_location'] ?? '').toString().toLowerCase();
          return location.contains(query);
        })
            .toList();
      }

      // Reset checkboxes
      rowCheckedList = List<bool>.filled(filteredBookings.length, false);
      headerChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.selfBookingModel.value?.data;
          final bookings = filteredBookings.isNotEmpty || searchController.text.isNotEmpty
              ? filteredBookings
              : data?.selfBookingData ?? [];

          // Initialize rowCheckedList
          if (rowCheckedList.length != bookings.length) {
            rowCheckedList = List<bool>.filled(bookings.length, false);
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Status Card
                  StatusSummaryCard(
                    title: "Total bookings",
                    currentCount: data?.totalSelfBookingReqCount ?? 0,
                    iconPath: "assets/icons/check.png",
                    showYearDropdown: true,
                    selectedYear: "1Y",
                    onYearChanged: (val) {},
                  ),

                  const SizedBox(height: 10),

                  // Action Button
                  ActionButtonsCard(
                    primaryText: "Add Custom booking",
                    onPrimaryTap: () async {
                      final controller = Get.find<SelfBookingController>();

                      final examTypes = [
                        "Online",
                        "Offline",
                        "Hybrid",
                        "Center Based",
                        "Home Based",
                      ];

                      final labList = [
                        "Ground",
                        "Basement",
                        "LAB 1",
                        "LAB 2",
                        "LAB 3",
                        "LAB 4",
                        "LAB 5",
                      ];
                      final yesNoList = ["YES", "NO"];

                      final bookingId = await showDialog<int>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AddBookingDialog(
                          examTypeOptions: examTypes,
                          labOptions: labList,
                          yesNoOptions: yesNoList,
                          examData: null,        // for editing, we pass data here
                        ),
                      );

                      if (bookingId != null) {
                        /// After dialog created a new booking
                        await controller.fetchSelfBooking();
                        setState(() {});
                        AppToast.showSuccess(context, "Booking added successfully!");
                      }
                    },
                  ),


                  const SizedBox(height: 20),

                  // Search Field
                  AppTextField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    label: "Search by location",
                    prefix: const Icon(Icons.search),
                  ),

                  const SizedBox(height: 20),



                  // Table
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.grey73),
                      ),
                      child: Table(
                        columnWidths: const {
                          0: FixedColumnWidth(150),
                          1: FixedColumnWidth(150),
                          2: FixedColumnWidth(120),
                          3: FixedColumnWidth(120),
                          4: FixedColumnWidth(120),
                          5: FixedColumnWidth(120),
                          6: FixedColumnWidth(80),
                          7: FixedColumnWidth(150),
                          8: FixedColumnWidth(80),
                        },
                        border: TableBorder.all(color: Colors.grey),
                        children: [
                          // Header
                          TableRow(
                            decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
                            children: [
                              _buildHeader("Client Name"),
                              _buildHeader("Client Email"),
                              _buildHeader("Client Phone"),
                              _buildHeader("Exam"),
                              _buildHeader("Exam Type"),
                              _buildHeader("Exam Date"),
                              _buildHeader("Seats"),
                              _buildHeader("Location"),
                              _buildHeader("Action"),
                            ],
                          ),

                          // Rows
                          ...List.generate(bookings.length, (index) {
                            final item = bookings[index];
                            return TableRow(
                              children: [
                                _buildCell(item['client_name'] ?? '-'),
                                _buildCell(item['client_email'] ?? '-'),
                                _buildCell(item['client_phone'] ?? '-'),
                                _buildCell(item['exam_name'] ?? '-'),
                                _buildCell(item['exam_type'] ?? '-'),
                                _buildCell(item['start_date'] ?? '-'),
                                _buildCell(item['seats_booked']?.toString() ?? '-'),
                                _buildCell(item['exam_location'] ?? '-'),

                                // Action button
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      controller.selectedBooking(item);
                                      bool? updated = await Get.to(() => const ExamDetailsScreen());
                                      if (updated == true) {
                                        await controller.fetchSelfBooking();
                                        setState(() {
                                          filteredBookings.clear(); // Optional: reset search
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 65,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text("View", style: AppTextStyles.button),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: AppTextStyles.linkText),
    );
  }

  Widget _buildCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: AppTextStyles.tableText),
    );
  }

}
