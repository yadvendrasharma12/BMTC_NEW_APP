import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/project_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';

class CounslingPopup extends StatefulWidget {
  final String projectId;

  const CounslingPopup({super.key, required this.projectId});

  @override
  State<CounslingPopup> createState() => _CounslingPopupState();
}

class _CounslingPopupState extends State<CounslingPopup> {
  final ProjectController projectController = Get.put(ProjectController());

  @override
  void initState() {
    super.initState();
    projectController.projectId = widget.projectId;
    projectController.fetchProjectDetail();
  }

  /// ================= YES / NO FORMATTER =================
  String formatYesNo(String? value) {
    if (value == "1") return "Yes";
    if (value == "0") return "No";
    if (value == null || value.isEmpty) return "N/A";
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.90,
        child: Obx(() {
          if (projectController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = projectController.projectData.value;
          if (data == null) {
            return const Center(child: Text("No data found"));
          }

          return Column(
            children: [

              /// ================= HEADER =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              Padding(
                padding: const EdgeInsets.only(left: 16, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.examName ?? '',
                      style: AppTextStyles.dashBordButton2,
                    ),
                    Row(
                      children: [
                        Text(
                          "Booking Received Date ",
                          style: AppTextStyles.topHeading3,
                        ),
                        Text(
                          formatDateTime(data.bookingReceived),
                          style: AppTextStyles.centerText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// ================= BODY =================
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Booking Accepted
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green.shade800,
                            child: const Icon(Icons.check, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Booking Accepted on ",
                            style: AppTextStyles.topHeading3,
                          ),
                          Text(
                            formatDateTime(data.centerBookingAcceptDate),
                            style: AppTextStyles.centerText,
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xffF5F78C),
                            child: const Icon(Icons.more_horiz),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Booking in review. Please wait for confirmation",
                              style: AppTextStyles.topHeading3,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      const Divider(),

                      /// ================= DETAILS =================
                      /// Siz
                      SizedBox(height: 12,),
                      Text("1. Project Details", style: AppTextStyles.dashBordButton3),


                      _field("Exam Date", data.startDate, data.endDate),
                      _field("Exam Name", data.examName),
                      _field("Exam City", data.examCityName),
                      _field("Exam City", data.clientName),
                      _field("Seats", data.numberOfSeats?.toString()),
                      _field("Pricing", "₹ ${data.pricePerSeat ?? '-'}"),

                      const SizedBox(height: 14),
                      Text("02. Software & Hardware requirements",
                          style: AppTextStyles.dashBordButton3),

                      _field("Exam Mode", data.examMode),

                      const SizedBox(height: 14),
                      Text("03. Computer configuration",
                          style: AppTextStyles.dashBordButton3),

                      _field("Operating System", data.inetModeOs),
                      _field("RAM", data.inetModeRam),
                      _field("Processor", data.inetModeProcessor),
                      _field("Display Resolution", data.inetModeDisplay),
                      _field("Internet on each device", data.inetModeInternetEach),

                      const SizedBox(height: 14),
                      Text("04. Amenity Requirements",
                          style: AppTextStyles.dashBordButton3),

                      _field("Parking Facility", formatYesNo(data.parkingFacility)),
                      _field("Security Guard", formatYesNo(data.securityGuard)),
                      _field("Lockers", formatYesNo(data.lockerFacility)),
                      _field("Waiting Area", formatYesNo(data.waitingArea)),
                      _field("Power Backup", formatYesNo(data.powerBackup)),
                      _field("PH Handicapped", formatYesNo(data.phHandicaped)),
                      _field("Printer", formatYesNo(data.printer)),
                      _field("Rough Sheet", formatYesNo(data.roughSheet)),
                      _field("Partition", formatYesNo(data.partitionInLab)),
                      _field("AC in each Lab", formatYesNo(data.acInLab)),
                      _field("CCTV Required", formatYesNo(data.cctvRequired)),

                      const SizedBox(height: 10),
                      Divider(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have a question? ", style: AppTextStyles.centerText),
                          Text("Contact us", style: AppTextStyles.linkTexts),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  /// ================= FIELD WIDGET =================
  Widget _field(String label, String? startDate, [String? endDate]) {
    String displayValue = "N/A";

    if (startDate != null && startDate.isNotEmpty) {
      displayValue = formatDateTime(startDate);

      if (endDate != null && endDate.isNotEmpty) {
        displayValue =
        "${formatDateTime(startDate)}  -  ${formatDateTime(endDate)}";
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.topHeading3),
          const SizedBox(height: 6),
          Container(
            height: 40,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.background,
            ),
            child: Text(
              displayValue,
              style: AppTextStyles.centerText,
            ),
          ),
        ],
      ),
    );
  }

  String formatValue(String? value) {
    if (value == null || value.isEmpty) return "N/A";
    return value;
  }


  String formatDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "N/A";

    final formats = [
      "yyyy-MM-dd HH:mm:ss",     // 2025-12-11 10:08:31
      "MMM dd, yyyy HH:mm:ss",   // Dec 11, 2025 10:12:37
      "MM dd yyyy HH:mm:ss",     // 12 11 2025 10:12:37
    ];

    for (var f in formats) {
      try {
        final dateTime = DateFormat(f, 'en_US').parse(dateStr);
        return DateFormat("MMM dd yyyy hh:mm a").format(dateTime);
      } catch (_) {}
    }

    return dateStr; // fallback
  }

}
