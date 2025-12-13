import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/self_booking_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';

class ExamDetailsScreen extends StatefulWidget {
  const ExamDetailsScreen({super.key});

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  final controller = Get.find<SelfBookingController>();

  bool isEditable = false; // Toggle edit mode

  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController clientEmailController = TextEditingController();
  final TextEditingController clientPhoneController = TextEditingController();
  final TextEditingController examNameController = TextEditingController();
  final TextEditingController examTypeController = TextEditingController();
  final TextEditingController examDateController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController centerNameController = TextEditingController();
  final TextEditingController totalBatchController = TextEditingController();
  final TextEditingController labAssignedController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fillData();
  }

  void _fillData() {
    final booking = controller.selectedBooking.value;
    if (booking != null) {
      clientNameController.text = booking['client_name'] ?? '';
      clientEmailController.text = booking['client_email'] ?? '';
      clientPhoneController.text = booking['client_phone'] ?? '';
      examNameController.text = booking['exam_name'] ?? '';
      examTypeController.text = booking['exam_type'] ?? '';
      examDateController.text = booking['exam_date'] ?? '';

      seatsController.text = booking['seats_booked']?.toString() ?? '';
      locationController.text = booking['exam_location'] ?? '';
      centerNameController.text = booking['center_name'] ?? '';
      totalBatchController.text = booking['total_batch'] ?? '';
      labAssignedController.text = booking['labs_assigned'] ?? '';
      startDateController.text = booking['start_date'] ?? '';
      endDateController.text = booking['end_date'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text("Exam Details", style: AppTextStyles.onBoard1stText),
      ),
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: _bottomButtons(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditableFieldTile(label: "Client Name", controller: clientNameController, enabled: isEditable),
              EditableFieldTile(label: "Client Email", controller: clientEmailController, enabled: isEditable),
              EditableFieldTile(label: "Client Phone", controller: clientPhoneController, enabled: isEditable),
              EditableFieldTile(label: "Exam Name", controller: examNameController, enabled: isEditable),
              EditableFieldTile(label: "Exam Type", controller: examTypeController, enabled: isEditable),
              EditableFieldTile(label: "Exam Date", controller: examDateController, enabled: isEditable),
              EditableFieldTile(label: "Seats", controller: seatsController, enabled: isEditable),
              EditableFieldTile(label: "Location", controller: locationController, enabled: isEditable),
              EditableFieldTile(label: "Center Name", controller: centerNameController, enabled: false),
              EditableFieldTile(label: "Total Batch", controller: totalBatchController, enabled: isEditable),
              EditableFieldTile(label: "Lab Assigned", controller: labAssignedController, enabled: isEditable),
              EditableFieldTile(label: "Start Date", controller: startDateController, enabled: isEditable),
              EditableFieldTile(label: "End Date", controller: endDateController, enabled: isEditable),
              const SizedBox(height: 20),


            ],
          ),
        ),
      ),
    );
  }

  /// 👉 Bottom Edit + Update Buttons
  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade400),
              onPressed: () {
                setState(() => isEditable = true);
              },
              child: const Text("Edit"),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                Map<String, dynamic> updatedData = {
                  "id": controller.selectedBooking.value?['id'] ?? '',
                  "client_name": clientNameController.text,
                  "client_email": clientEmailController.text,
                  "client_phone": clientPhoneController.text,
                  "exam_name": examNameController.text,
                  "exam_type": examTypeController.text,
                  "exam_location": locationController.text,
                  "exam_duration": "${seatsController.text} Hours",
                  "seats_booked": seatsController.text,
                  "labs_assigned": labAssignedController.text,
                  "exam_batch": totalBatchController.text,
                  "batch1": "8 AM - 9 AM",
                  "batch2": "10 AM - 11 AM",
                  "start_date": startDateController.text,
                  "end_date": endDateController.text,
                };
                controller.updateBooking(updatedData);
              },
              child: controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Update", style: TextStyle(color: Colors.white)),
            )),
          ),
        ],
      ),
    );
  }
}

class EditableFieldTile extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;

  const EditableFieldTile({
    required this.label,
    required this.controller,
    this.enabled = true,
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.tableText),
        const SizedBox(height: 8),
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: TextField(
            enabled: enabled,
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
