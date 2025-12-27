import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/dashboard_controller.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/text_style.dart';
import '../../../../models/dashboard_modal.dart';
import '../../../../widgets/custom_textformfield.dart';
import '../../center_pages/center_page_screen.dart';
import '../../exam_details/counsling_form_screen.dart';
import '../../exam_details/inreview_counsling_popup.dart';
import '../../self_booking/self_booking_screen.dart';
import '../../widgets/action_button_card.dart';
import '../../widgets/status_summary_card.dart';

class InReviewScreen extends StatefulWidget {
  const InReviewScreen({super.key});

  @override
  State<InReviewScreen> createState() => _InReviewScreenState();
}

class _InReviewScreenState extends State<InReviewScreen> {
  final TextEditingController searchController = TextEditingController();
  final controller = Get.put(DashboardController());

  bool headerChecked = false;
  late List<bool> rowCheckedList;

  List<TotalInReviewBooking> filteredRequests = [];

  @override
  void initState() {
    super.initState();
    rowCheckedList = [];
    searchController.addListener(_filterRequests);
  }

  void _filterRequests() {
    final query = searchController.text.toLowerCase();
    final requests = controller.dashboardModel.value.data?.totalInReviewBooking ?? [];

    setState(() {
      filteredRequests = requests
          .where((item) =>
      (item.examName ?? '').toLowerCase().contains(query) ||
          (item.examCityName ?? '').toLowerCase().contains(query))
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

        final requests = controller.dashboardModel.value.data?.totalInReviewBooking ?? [];

        if (filteredRequests.isEmpty) {
          filteredRequests = requests;
        }

        if (rowCheckedList.length != filteredRequests.length) {
          rowCheckedList = List<bool>.filled(filteredRequests.length, false);
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                StatusSummaryCard(
                  title: "In Review",
                  currentCount: filteredRequests.length,
                  iconPath: "assets/icons/check.png",
                ),
                const SizedBox(height: 10),
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

  // ---------------- TABLE ----------------
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
                ? Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "No bookings available",
                style: AppTextStyles.centerSubTitle,
              ),
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

  // ---------------- HEADER ----------------
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
                  List<bool>.filled(filteredRequests.length, headerChecked);
                });
              },
            ),
          ),
          _headerCell("Exam Name", 150),
          _headerCell("City", 150),
          _headerCell("Client", 120),
          _headerCell("Start Date", 120),
          _headerCell("End Date", 120),
          _headerCell("Seats", 80),
          _headerCell("Pricing", 100),
          _headerCell("Status", 100),
          _headerCell("Action", 100),
        ],
      ),
    );
  }

  // ---------------- DATA ROW ----------------
  Widget _buildDataRow(int index) {
    final b = filteredRequests[index];

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
          _dataCell(b.examName ?? "-", 150),
          _dataCell(b.examCityName ?? "-", 150),
          _dataCell(b.clientName ?? "-", 120),
          _dataCell(b.startDate ?? "-", 120),
          _dataCell(b.endDate ?? "-", 120),
          _dataCell(b.numberOfSeats?.toString() ?? "-", 80),
          _dataCell("₹ ${b.pricePerSeat ?? 200}", 100),
          _statusCell(b.examCenterStatus, 100),

          Container(
            width: 100,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                final projectId = b.projectId ?? '';

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
                      child: CounslingPopup(projectId: projectId),
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

  // ---------------- CELLS ----------------
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

    switch (status) {
      case "1":
        text = "Approved";
        color = Colors.green;
        break;
      case "2":
        text = "Rejected";
        color = Colors.red;
        break;
      default:
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
