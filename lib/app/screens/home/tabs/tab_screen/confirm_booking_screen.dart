import 'package:bmtc_app/app/screens/home/exam_details/confim_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/dashboard_controller.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/text_style.dart';
import '../../../../widgets/custom_textformfield.dart';
import '../../center_pages/center_page_screen.dart';
import '../../self_booking/self_booking_screen.dart';
import '../../widgets/action_button_card.dart';
import '../../widgets/status_summary_card.dart';
import '../../exam_details/counsling_form_screen.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key});

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  final TextEditingController searchController = TextEditingController();
  final controller = Get.put(DashboardController());

  bool headerChecked = false;
  late List<bool> rowCheckedList;

  String _selectedYear = "1Y";

  /// IMPORTANT: Always use List<Map> for table
  List<Map<String, dynamic>> filteredBookings = [];

  @override
  void initState() {
    super.initState();
    rowCheckedList = [];
    searchController.addListener(_filterBookings);
  }

  void _filterBookings() {
    final query = searchController.text.toLowerCase();
    final bookings = controller.dashboardModel.value.data?.totalConfirmBooking ?? [];

    setState(() {
      filteredBookings = bookings
          .map((e) => e.toJson())
          .where((item) {
        final examName = (item['exam_name'] ?? '').toLowerCase();
        final city = (item['exam_city_name'] ?? '').toLowerCase();
        return examName.contains(query) || city.contains(query);
      }).toList();

      rowCheckedList = List<bool>.filled(filteredBookings.length, false);
      headerChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardData = controller.dashboardModel.value.data;
    final totalSeatsBooked = dashboardData?.numberOfSeats ?? 0;
    return Scaffold(
      backgroundColor: AppColors.borderColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final bookings = controller.dashboardModel.value.data?.totalConfirmBooking ?? [];

        /// First time: Load all
        if (filteredBookings.isEmpty) {
          filteredBookings = bookings.map((e) => e.toJson()).toList();
        }

        if (rowCheckedList.length != filteredBookings.length) {
          rowCheckedList = List<bool>.filled(filteredBookings.length, false);
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                StatusSummaryCard(
                  title: "Confirmed bookings",
                  currentCount: filteredBookings.length,
                  iconPath: "assets/icons/check.png",
                ),

                const SizedBox(height: 10),

                StatusSummaryCard(
                  title: "Seats Booked",
                  currentCount: totalSeatsBooked,
                  showYearDropdown: true,
                  selectedYear: _selectedYear,
                  onYearChanged: (val) => setState(() => _selectedYear = val ?? "1Y"),
                  iconPath: "assets/icons/seat_booked.png",
                ),

                const SizedBox(height: 15),

                ActionButtonsCard(
                  primaryText: "Custom booking",
                  secondaryText: "Edit Center profile",
                  onPrimaryTap: () => Get.to(SelfBookingScreen()),
                  onSecondaryTap: () => Get.to(CenterPageScreen()),
                ),

                const SizedBox(height: 20),

                AppTextField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  label: 'Search by Exam Name or City',
                  prefix: const Icon(Icons.search),
                ),

                const SizedBox(height: 20),

                _buildContainerTable(),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ---------------------------------------
  // SAME TABLE AS BookingRequestScreen
  // ---------------------------------------

  Widget _buildContainerTable() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey73),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            _buildHeaderRow(),
            const Divider(height: 1),
            filteredBookings.isEmpty
                ? const Padding(
              padding: EdgeInsets.all(20),
              child: Text("No bookings available"),
            )
                : Column(
              children: List.generate(
                filteredBookings.length,
                    (i) => _buildDataRow(i),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HEADER ROW (Same as BookingRequestScreen)
  Widget _buildHeaderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Checkbox(
              activeColor: AppColors.primaryColor,
              checkColor: Colors.white,
              value: headerChecked,
              onChanged: (val) {
                setState(() {
                  headerChecked = val ?? false;
                  rowCheckedList =
                  List<bool>.filled(filteredBookings.length, headerChecked);
                });
              },
            ),
          ),

          _headerCell("Exam Name", 150),
          _headerCell("City", 150),
          _headerCell("Client Name", 100),
          _headerCell("Exam Date", 150),
          _headerCell("Seats", 100),
          _headerCell("Pricing", 100),
          _headerCell("Status", 100),
          _headerCell("Action", 100),
        ],
      ),
    );
  }

  // DATA ROW (Same as BookingRequestScreen)
  Widget _buildDataRow(int index) {
    final b = filteredBookings[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Checkbox(
              activeColor: AppColors.primaryColor,
              checkColor: Colors.white,
              value: rowCheckedList[index],
              onChanged: (val) {
                setState(() {
                  rowCheckedList[index] = val ?? false;
                  headerChecked = rowCheckedList.every((e) => e);
                });
              },
            ),
          ),

          _dataCell(b['exam_name'] ?? "-", 150),
          _dataCell(b['exam_city_name'] ?? "-", 150),
          _dataCell(b['client_name'] ?? "-", 100),

          _dataCell("${b['start_date']} to ${b['end_date']}", 150),

          _dataCell(b['exam_required_seat']?.toString() ?? "-", 100),
          _dataCell("₹ ${b['price_per_seat']}", 100),

          _statusCell("approved", 100),

          Container(
            width: 100,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                final projectId = b['project_id'] ?? '';

                if (projectId.isEmpty) {
                  Get.snackbar('Error', 'Project ID not available');
                  return;
                }

                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) {
                    return Dialog(
                      insetPadding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ConfimPopup(projectId: projectId),
                    );
                  },
                );
              },

              child: Container(
                height: 32,
                width: 70,
                decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text("View", style: AppTextStyles.button),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // HEADER & DATA CELLS
  Widget _headerCell(String title, double width) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(title, style: AppTextStyles.centerSubTitle),
    );
  }

  Widget _dataCell(String value, double width) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(value, style: AppTextStyles.tableText),
    );
  }

  Widget _statusCell(String status, double width) {
    Color bgColor;
    Color textColor;
    String text;

    if (status.toLowerCase() == "approved") {
      bgColor = Colors.white;
      textColor = Colors.green.shade800;
      text = "Approved";
    } else {
      bgColor = Colors.orange.shade100;
      textColor = Colors.orange.shade800;
      text = "In Review";
    }

    return Container(
      width: width,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: AppTextStyles.tableText.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

}
