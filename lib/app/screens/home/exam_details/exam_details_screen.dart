// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/self_booking_controller.dart';
// import '../../../core/app_colors.dart';
// import '../../../core/text_style.dart';
//
// class ExamDetailsScreen extends StatefulWidget {
//   const ExamDetailsScreen({super.key});
//
//   @override
//   State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
// }
//
// class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
//   final controller = Get.find<SelfBookingController>();
//
//   bool isEditable = false; // Toggle edit mode
//
//   final TextEditingController clientNameController = TextEditingController();
//   final TextEditingController clientEmailController = TextEditingController();
//   final TextEditingController clientPhoneController = TextEditingController();
//   final TextEditingController examNameController = TextEditingController();
//   final TextEditingController examTypeController = TextEditingController();
//   final TextEditingController examDateController = TextEditingController();
//   final TextEditingController seatsController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController centerNameController = TextEditingController();
//   final TextEditingController totalBatchController = TextEditingController();
//   final TextEditingController labAssignedController = TextEditingController();
//   final TextEditingController startDateController = TextEditingController();
//   final TextEditingController endDateController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _fillData();
//   }
//
//   void _fillData() {
//     final booking = controller.selectedBooking.value;
//     if (booking != null) {
//       clientNameController.text = booking['client_name'] ?? '';
//       clientEmailController.text = booking['client_email'] ?? '';
//       clientPhoneController.text = booking['client_phone'] ?? '';
//       examNameController.text = booking['exam_name'] ?? '';
//       examTypeController.text = booking['exam_type'] ?? '';
//       examDateController.text = booking['exam_date'] ?? '';
//
//       seatsController.text = booking['seats_booked']?.toString() ?? '';
//       locationController.text = booking['exam_location'] ?? '';
//       centerNameController.text = booking['center_name'] ?? '';
//       totalBatchController.text = booking['total_batch'] ?? '';
//       labAssignedController.text = booking['labs_assigned'] ?? '';
//       startDateController.text = booking['start_date'] ?? '';
//       endDateController.text = booking['end_date'] ?? '';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: const Icon(Icons.arrow_back_ios)),
//         title: Text("Exam Details", style: AppTextStyles.onBoard1stText),
//       ),
//       backgroundColor: Colors.grey.shade200,
//       bottomNavigationBar: _bottomButtons(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 50,
//                     width: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.blueGrey.shade100,
//                       borderRadius: BorderRadius.circular(12)
//                     ),
//                     child: Icon(Icons.add,color: AppColors.primaryColor,size: 30,),
//                   ),
//                   SizedBox(height: 8,),
//                   Text("Update a booking",style: AppTextStyles.topHeading2,) ,
//                   SizedBox(height: 7,),
//                   Text(
//                     textAlign: TextAlign.center,
//                     "Please enter the following details to update a booking.",
//                     style: AppTextStyles.centerSubTitle,
//                   overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//
//                   ) ,
//
//                 ],
//               ),
//               SizedBox(height: 12,),
//               EditableFieldTile(label: "Client Name", controller: clientNameController, enabled: isEditable),
//               EditableFieldTile(label: "Client Email", controller: clientEmailController, enabled: isEditable),
//               EditableFieldTile(label: "Client Phone", controller: clientPhoneController, enabled: isEditable),
//               EditableFieldTile(label: "Exam Name", controller: examNameController, enabled: isEditable),
//               EditableFieldTile(label: "Exam Type", controller: examTypeController, enabled: isEditable),
//               EditableFieldTile(label: "Exam Date", controller: examDateController, enabled: isEditable),
//               EditableFieldTile(label: "Seats", controller: seatsController, enabled: isEditable),
//               EditableFieldTile(label: "Location", controller: locationController, enabled: isEditable),
//               EditableFieldTile(label: "Center Name", controller: centerNameController, enabled: false),
//               EditableFieldTile(label: "Total Batch", controller: totalBatchController, enabled: isEditable),
//               EditableFieldTile(label: "Lab Assigned", controller: labAssignedController, enabled: isEditable),
//               EditableFieldTile(label: "Start Date", controller: startDateController, enabled: isEditable),
//               EditableFieldTile(label: "End Date", controller: endDateController, enabled: isEditable),
//               const SizedBox(height: 20),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// 👉 Bottom Edit + Update Buttons
//   Widget _bottomButtons() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       color: Colors.white,
//       child: Row(
//         children: [
//           Expanded(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade400),
//               onPressed: () {
//                 setState(() => isEditable = true);
//               },
//               child: const Text("Edit"),
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Obx(() => ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//               onPressed: controller.isLoading.value
//                   ? null
//                   : () {
//                 Map<String, dynamic> updatedData = {
//                   "id": controller.selectedBooking.value?['id'] ?? '',
//                   "client_name": clientNameController.text,
//                   "client_email": clientEmailController.text,
//                   "client_phone": clientPhoneController.text,
//                   "exam_name": examNameController.text,
//                   "exam_type": examTypeController.text,
//                   "exam_location": locationController.text,
//                   "exam_duration": "${seatsController.text} Hours",
//                   "seats_booked": seatsController.text,
//                   "labs_assigned": labAssignedController.text,
//                   "exam_batch": totalBatchController.text,
//                   "batch1": "8 AM - 9 AM",
//                   "batch2": "10 AM - 11 AM",
//                   "start_date": startDateController.text,
//                   "end_date": endDateController.text,
//                 };
//                 controller.updateBooking(updatedData);
//               },
//               child: controller.isLoading.value
//                   ? Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: const CircularProgressIndicator(color: Colors.white),
//                   )
//                   : const Text("Update", style: TextStyle(color: Colors.white)),
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class EditableFieldTile extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final bool enabled;
//
//   const EditableFieldTile({
//     required this.label,
//     required this.controller,
//     this.enabled = true,
//     super.key,
//   });
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: AppTextStyles.tableText),
//         const SizedBox(height: 8),
//         Container(
//           height: 46,
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(11),
//             border: Border.all(color: AppColors.borderColor),
//           ),
//           child: TextField(
//             enabled: enabled,
//             controller: controller,
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               isDense: true,
//               contentPadding: EdgeInsets.zero,
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  bool isEditable = false;

  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController clientEmailController = TextEditingController();
  final TextEditingController clientPhoneController = TextEditingController();
  final TextEditingController examNameController = TextEditingController();
  final TextEditingController examTypeController = TextEditingController();
  final TextEditingController examDateController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController centerNameController = TextEditingController();
  final TextEditingController totalBatchController = TextEditingController();
  final TextEditingController labAssignedController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final Map<int, TextEditingController> batchTimeControllers = {};

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
      seatsController.text = booking['seats_booked']?.toString() ?? '';
      durationController.text = booking['exam_duration']?.toString() ?? "";
      locationController.text = booking['exam_location'] ?? '';
      centerNameController.text = booking['center_name'] ?? '';
      totalBatchController.text = booking['total_batch'] ?? '1';
      labAssignedController.text = booking['labs_assigned'] ?? '';


      startDateController.text =
      booking['start_date'] != null && booking['start_date'] != '0000-00-00'
          ? DateFormat('dd-MM-yyyy').format(
          DateTime.parse(booking['start_date']))
          : '';
      endDateController.text =
      booking['end_date'] != null && booking['end_date'] != '0000-00-00'
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(booking['end_date']))
          : '';

      int totalBatch = int.tryParse(totalBatchController.text) ?? 1;
      for (int i = 1; i <= totalBatch; i++) {
        batchTimeControllers[i] = TextEditingController();
        batchTimeControllers[i]!.text = booking['batch$i'] ?? '';
      }
    }
  }


  // Date Picker
  void _pickDate(TextEditingController controller) async {
    DateTime initialDate = DateTime.tryParse(
        controller.text.replaceAll("-", "/")) ?? DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  // Time Picker
  Future<void> _pickTime(TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final dt = DateTime(
          now.year, now.month, now.day, picked.hour, picked.minute);
      controller.text = DateFormat('hh:mm a').format(dt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: _bottomButtons(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: () => Get.back(),
                      icon: const Icon(Icons.close)),
                ],),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Icon(
                      Icons.add, color: AppColors.primaryColor, size: 30,),
                  ),
                  const SizedBox(height: 8),
                  Text("Update a booking", style: AppTextStyles.topHeading2,),
                  const SizedBox(height: 7),
                  Text(
                    textAlign: TextAlign.center,
                    "Please enter the following details to update a booking.",
                    style: AppTextStyles.centerSubTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _clientDetailsCard(),
              const SizedBox(height: 16),
              _examDetailsCard(),
              const SizedBox(height: 16),
              _bookingDetailsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _clientDetailsCard() {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Client Details", style: AppTextStyles.topHeading2),
            const SizedBox(height: 12),
            EditableFieldTile(label: "Client Name",
                controller: clientNameController,
                enabled: isEditable),
            EditableFieldTile(label: "Client Email",
                controller: clientEmailController,
                enabled: isEditable),
            EditableFieldTile(label: "Client Phone",
                controller: clientPhoneController,
                enabled: isEditable),
          ],
        ),
      ),
    );
  }

  Widget _bookingDetailsCard() {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Booking Details", style: AppTextStyles.topHeading2),
            const SizedBox(height: 12),
            EditableFieldTile(label: "Seats booked",
                controller: seatsController,
                enabled: isEditable),
            EditableFieldTile(label: "Lab Assigned",
                controller: labAssignedController,
                enabled: isEditable),
          ],
        ),
      ),
    );
  }

  Widget _examDetailsCard() {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Exam Details", style: AppTextStyles.topHeading2),
            const SizedBox(height: 12),
            EditableFieldTile(label: "Exam Name",
                controller: examNameController,
                enabled: isEditable),
            _examTypeDropdown(),
            EditableFieldTile(label: "Exam Location",
                controller: locationController,
                enabled: isEditable),
            EditableFieldTile(label: "Exam Duration (in days)",
                controller: durationController,
                enabled: isEditable),

            _datePickerField("Exam Start Date", startDateController),
            _datePickerField("Exam End Date", endDateController),
            EditableFieldTile(label: "Exam Center Name",
                controller: centerNameController,
                enabled: false),
            _totalBatchDropdown(),
            _batchTimeFields(),
          ],
        ),
      ),
    );
  }

  Widget _examTypeDropdown() {
    List<String> options = ["Online", "Offline"];
    String? selected = examTypeController.text.isNotEmpty
        ? options.firstWhere((e) =>
    e.toLowerCase() == examTypeController.text.toLowerCase(), orElse: () => '')
        : null;

    return DropdownFieldTile(
      label: "Exam Type",
      value: selected ?? "",
      enabled: isEditable,
      onChanged: (val) {
        if (val != null) {
          setState(() {
            examTypeController.text = val;
          });
        }
      },
    );
  }

  Widget _totalBatchDropdown() {
    return DropdownFieldTile(
      label: "Total Batch",
      value: totalBatchController.text,
      enabled: isEditable,
      onChanged: (val) {
        if (val != null) {
          setState(() {
            totalBatchController.text = val;
            int total = int.tryParse(val) ?? 1;
            batchTimeControllers.clear();
            for (int i = 1; i <= total; i++) {
              batchTimeControllers[i] = TextEditingController();
            }
          });
        }
      },
      options: List.generate(5, (index) => "${index + 1}"),
    );
  }

  Widget _batchTimeFields() {
    return Column(
      children: batchTimeControllers.entries.map((entry) {
        return GestureDetector(
          onTap: isEditable ? () => _pickTime(entry.value) : null,
          child: EditableFieldTile(
            label: "Batch ${entry.key} Time",
            controller: entry.value,
            enabled: false, // disabled because time is selected via picker
          ),
        );
      }).toList(),
    );
  }

  Widget _datePickerField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.tableText),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: isEditable ? () => _pickDate(controller) : null,
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.text.isNotEmpty
                    ? controller.text
                    : "Select Date", style: AppTextStyles.centerText),
                const Icon(Icons.calendar_today, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400),
              onPressed: () {
                setState(() => isEditable = true);
              },
              child: const Text("Edit"),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Obx(() =>
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black),
                  onPressed: controller.isLoading.value ? null : _updateBooking,
                  child: controller.isLoading.value
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 3),
                  )
                      : const Text(
                      "Update", style: TextStyle(color: Colors.white)),
                )),
          ),
        ],
      ),
    );
  }


  void _updateBooking() async {
    Map<String, dynamic> updatedData = {
      "id": controller.selectedBooking.value?['id'] ?? '',
      "client_name": clientNameController.text,
      "client_email": clientEmailController.text,
      "client_phone": clientPhoneController.text,
      "exam_name": examNameController.text,
      "exam_type": examTypeController.text,
      "exam_location": locationController.text,
      "exam_duration": durationController.text,
      "seats_booked": seatsController.text,
      "labs_assigned": labAssignedController.text,
      "exam_batch": totalBatchController.text,
      "start_date": startDateController.text != ''
          ? DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(startDateController.text))
          : '0000-00-00',
      "end_date": endDateController.text != ''
          ? DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(endDateController.text))
          : '0000-00-00',
      "batch_times": batchTimeControllers.map((key, val) =>
          MapEntry("batch$key", val.text)),
    };


    controller.updateBooking(updatedData);
  }
}



/// Custom dropdown
class DropdownFieldTile extends StatelessWidget {
  final String label;
  final String value;
  final List<String>? options;
  final bool enabled;
  final Function(String?) onChanged;

  const DropdownFieldTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.options,
  });

  @override
  Widget build(BuildContext context) {
    List<String> items = options ?? ["Online", "Offline"];
    String? selected = items.contains(value) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.tableText),
        const SizedBox(height: 6),
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selected,
              hint: const Text("Select"),
              onChanged: enabled ? onChanged : null,
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

/// Editable field
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
        const SizedBox(height: 6),
        Container(
          height: 46,
          padding: const EdgeInsets.only(left: 12,top: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
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

