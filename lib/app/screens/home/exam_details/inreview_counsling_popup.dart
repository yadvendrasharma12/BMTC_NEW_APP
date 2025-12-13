import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
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
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.close)),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    Text(
                      "Bar Counseling Exam",
                      style: AppTextStyles.topHeading2,
                    ),
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

              /// ================= BODY =================
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      _field("Exam Date", data.startDate),
                      _field("Exam Name", data.examName),
                      _field("Exam City", data.examCityName),
                      _field("Seats",
                          data.numberOfSeats?.toString()),
                      _field("Pricing",
                          "₹ ${data.pricePerSeat ?? '-'}"),

                      const SizedBox(height: 14),
                      Text(
                        "Software & Hardware requirements",
                        style: AppTextStyles.dashBordButton3,
                      ),

                      _field("Exam Mode", data.examMode),
                      _field("Operating System", data.inetModeOs),
                      _field("RAM", data.inetModeRam),
                      _field("Processor", data.inetModeProcessor),
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

  /// ================= FIELD =================
  Widget _field(String label, String? value) {
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
              (value != null && value.isNotEmpty) ? value : "N/A",
              style: AppTextStyles.centerText,
            ),
          ),
        ],
      ),
    );
  }
}
