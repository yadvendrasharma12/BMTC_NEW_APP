import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/dashboard_controller.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/text_style.dart';
import '../../../../models/dashboard_modal.dart';
import '../../../../widgets/custom_textformfield.dart';
import '../../exam_details/counsling_form_screen.dart';
import '../../widgets/action_button_card.dart';
import '../../widgets/status_summary_card.dart';
import '../../self_booking/self_booking_screen.dart';
import '../../center_pages/center_page_screen.dart';

class BookingRequestScreen extends StatefulWidget {
  const BookingRequestScreen({super.key});

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {
  final TextEditingController searchController = TextEditingController();
  final controller = Get.put(DashboardController());

  bool headerChecked = false;
  List<bool> rowCheckedList = [];

  String _selectedYear = "1Y";
  String _selectedYears = "1Y";

  List<TotalBookingRequest> filteredRequests = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterRequests);
  }

  void _filterRequests() {
    final query = searchController.text.toLowerCase();

    final allData = controller.dashboardModel.value.data;
    final requests = allData?.totalBookingRequest ?? [];

    setState(() {
      filteredRequests = requests
          .where((item) =>
          (item.examName ?? "").toLowerCase().contains(query))
          .toList();

      rowCheckedList = List<bool>.filled(filteredRequests.length, false);
      headerChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.dashboardModel.value.data;

        if (filteredRequests.isEmpty) {
          filteredRequests = data?.totalBookingRequest ?? [];
        }

        if (rowCheckedList.length != filteredRequests.length) {
          rowCheckedList =
          List<bool>.filled(filteredRequests.length, false);
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                StatusSummaryCard(
                  title: "Total Bookings",
                  currentCount: data?.totalBookingReqCount ?? 0,
                  percentage: 64.54,
                  iconPath: "assets/icons/check.png",
                  showYearDropdown: true,
                  selectedYear: _selectedYears,
                  onYearChanged: (val) {
                    setState(() => _selectedYears = val ?? "1Y");
                  },
                ),

                const SizedBox(height: 10),

                StatusSummaryCard(
                  title: "Seats Booked",
                  currentCount: data?.numberOfSeats ?? 0,
                  percentage: 64,
                  iconPath: "assets/icons/seat_booked.png",
                  showYearDropdown: true,
                  selectedYear: _selectedYear,
                  onYearChanged: (val) {
                    setState(() => _selectedYear = val ?? "1Y");
                  },
                ),

                const SizedBox(height: 20),

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
                  label: 'Search by Exam Name',
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

  // ----------------------------------------------------------
  // TABLE UI
  // ----------------------------------------------------------

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
            filteredRequests.isEmpty
                ? const Padding(
              padding: EdgeInsets.all(20),
              child: Text("No bookings available"),
            )
                : Column(
              children: List.generate(
                filteredRequests.length,
                    (i) => _buildDataRow(i),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------- HEADER -----------------------------

  Widget _buildHeaderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Checkbox(
              value: headerChecked,
              onChanged: (val) {
                setState(() {
                  headerChecked = val ?? false;
                  rowCheckedList =
                  List<bool>.filled(filteredRequests.length, headerChecked);
                });
              },
            ),
          ),
          _headerCell("Exam Name", 150),
          _headerCell("Client", 150),
          _headerCell("City", 100),
          _headerCell("Exam Date", 150),
          _headerCell("Seats", 100),
          _headerCell("Pricing", 100),
          _headerCell("Status", 100),
          _headerCell("Action", 100),
        ],
      ),
    );
  }

  // ---------------------- ROW -----------------------------

  Widget _buildDataRow(int index) {
    final booking = filteredRequests[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Checkbox(
              value: rowCheckedList[index],
              onChanged: (val) {
                setState(() {
                  rowCheckedList[index] = val ?? false;
                  headerChecked = rowCheckedList.every((e) => e);
                });
              },
            ),
          ),

          _dataCell(booking.examName ?? "-", 150),
          _dataCell(booking.clientName ?? "-", 150),
          _dataCell(booking.examCityName ?? "-", 100),

          /// Start - End Date in one cell
          _dataCell(
              "${booking.startDate ?? '-'} to ${booking.endDate ?? '-'}",
              150),

          _dataCell(booking.numberOfSeats ?? "-", 100),
          _dataCell(booking.pricePerSeat ?? "-", 100),
          _statusCell(booking.status, 100),

          /// Action Button (Fixed width)
          Container(
            width: 100,
            alignment: Alignment.center,
            child: GestureDetector(
              // onTap: () {
              //   final projectId = booking.projectId ?? "";
              //   Get.to(
              //     CounslingFormScreen(),
              //     arguments: {"project_id": projectId},
              //   );
              // },
              onTap: () async {
                final projectId = booking.projectId ?? "";

                bool? updated = await Get.to(
                      () => const CounslingFormScreen(),
                  arguments: {"project_id": projectId},
                );

                // 🔴 YAHAN BACK SE AANE KE BAAD CODE CHALEGA
                if (updated == true) {

                  // API se fresh data
                  await controller.fetchDashboard();

                  // UI list refresh
                  final data = controller.dashboardModel.value.data;

                  setState(() {
                    filteredRequests = data?.totalBookingRequest ?? [];
                    rowCheckedList =
                    List<bool>.filled(filteredRequests.length, false);
                    headerChecked = false;
                  });
                }
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

  // ---------------------- CELLS -----------------------------

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
  Widget _statusCell(String? status, double width) {
    String text;
    Color color;

    if (status == "1") {
      text = "Approved";
      color = Colors.green;
    } else if (status == "0") {
      text = "Rejected";
      color = Colors.red;
    } else {
      text = "Pending";
      color = Colors.orange;
    }

    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        text,
        style: AppTextStyles.tableText.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

}
