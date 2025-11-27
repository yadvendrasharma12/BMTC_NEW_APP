import 'package:bmtc_app/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_textformfield.dart';

class AddBookingDialog extends StatefulWidget {
  final List<String> examTypeOptions;
  final List<String> labOptions;
  final List<String> yesNoOptions;

  const AddBookingDialog({
    super.key,
    required this.examTypeOptions,
    required this.labOptions,
    required this.yesNoOptions,
  });

  @override
  State<AddBookingDialog> createState() => _AddBookingDialogState();
}

class _AddBookingDialogState extends State<AddBookingDialog> {
  final _formKey = GlobalKey<FormState>();

  String? selectedExamType;
  String? selectedLabs;

  /// ✅ Exam batch (1–5)
  int? selectedBatch;

  DateTime? selectedExamDate;
  DateTime? selectedExamEndDate;

  /// ✅ har batch ke liye time controller list
  final List<TextEditingController> _batchTimeControllers = [];

  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController clientEmailController = TextEditingController();
  final TextEditingController clientPhoneController = TextEditingController();
  final TextEditingController examNameController = TextEditingController();
  final TextEditingController examLocationController = TextEditingController();
  final TextEditingController examDurationController = TextEditingController();
  final TextEditingController seatsBookedController = TextEditingController();
  final TextEditingController totalNetworkController = TextEditingController();

  String _formatDate(DateTime? date) {
    if (date == null) return "Select date";
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return "Select time";
    final hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  Future<void> _pickExamDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: (isStart ? selectedExamDate : selectedExamEndDate) ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          selectedExamDate = picked;
        } else {
          selectedExamEndDate = picked;
        }
      });
    }
  }

  /// ✅ kisi batch ke liye time pick karna
  Future<void> _pickBatchTime(int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      _batchTimeControllers[index].text = _formatTime(picked);
      setState(() {});
    }
  }

  /// ✅ batch change hone par controllers ko reset / create karo
  void _onBatchChanged(int? value) {
    setState(() {
      selectedBatch = value;
      _batchTimeControllers.clear();
      if (selectedBatch != null) {
        for (int i = 0; i < selectedBatch!; i++) {
          _batchTimeControllers.add(TextEditingController());
        }
      }
    });
  }

  void _onConfirmPressed() {
    // TODO: yahan form validate/cart logic lagana hai
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    for (final c in _batchTimeControllers) {
      c.dispose();
    }
    clientNameController.dispose();
    clientEmailController.dispose();
    clientPhoneController.dispose();
    examNameController.dispose();
    examLocationController.dispose();
    examDurationController.dispose();
    seatsBookedController.dispose();
    totalNetworkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // close button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          color: AppColors.blackColor,
                          size: 25,
                        ),
                      ),
                    ],
                  ),

                  // title + icon
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Text("Add a new booking",
                                    style: AppTextStyles.heading2),
                                const SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Please enter the following details\n"
                                      "to create a booking",
                                  style: AppTextStyles.topHeading3,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CLIENT DETAILS
                  Text("Client details", style: AppTextStyles.topHeading3),
                  const SizedBox(height: 10),
                  Text("Client Name", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: clientNameController,
                    keyboardType: TextInputType.name,
                    hintText: 'Client Name',
                    label: '',
                  ),
                  const SizedBox(height: 12),
                  Text("Client Email", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: clientEmailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Client Email',
                    label: '',
                  ),
                  const SizedBox(height: 12),
                  Text("Client Phone Number", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: clientPhoneController,
                    keyboardType: TextInputType.phone,
                    hintText: 'Client Phone number',
                    label: '',
                  ),

                  const SizedBox(height: 22),

                  // EXAM DETAILS
                  Text("Exam details", style: AppTextStyles.topHeading3),
                  const SizedBox(height: 10),
                  Text("Exam Name", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: examNameController,
                    keyboardType: TextInputType.text,
                    hintText: 'Exam name',
                    label: '',
                  ),
                  const SizedBox(height: 12),
                  Text("Exam Type", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  CustomDropdown<String>(
                    hintText: "Exam type",
                    value: selectedExamType,
                    items: widget.examTypeOptions,
                    itemLabel: (v) => v,
                    onChanged: (v) => setState(() => selectedExamType = v),
                    validator: (_) => null,
                  ),
                  const SizedBox(height: 12),
                  Text("Exam Location", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: examLocationController,
                    keyboardType: TextInputType.text,
                    hintText: 'Exam location',
                    label: '',
                  ),
                  const SizedBox(height: 12),

                  Text("Exam Start Date", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => _pickExamDate(isStart: true),
                    child: AbsorbPointer(
                      child: AppTextField(
                        controller: TextEditingController(
                          text: _formatDate(selectedExamDate),
                        ),
                        keyboardType: TextInputType.text,
                        hintText: 'Exam start date',
                        label: '',
                        suffix: const Icon(Icons.calendar_month),
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Text("Exam End Date", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => _pickExamDate(isStart: false),
                    child: AbsorbPointer(
                      child: AppTextField(
                        controller: TextEditingController(
                          text: _formatDate(selectedExamEndDate),
                        ),
                        keyboardType: TextInputType.text,
                        hintText: 'Exam end date',
                        label: '',
                        suffix: const Icon(Icons.calendar_month),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text("Exam Duration (in days)", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: examDurationController,
                    keyboardType: TextInputType.number,
                    hintText: 'Exam duration (in days)',
                    label: '',
                  ),

                  const SizedBox(height: 13),

                  // ✅ EXAM BATCH DROPDOWN
                  Text("Exam Batch", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  CustomDropdown<int>(
                    hintText: "Select batch count",
                    value: selectedBatch,
                    items: const [1, 2, 3, 4, 5],
                    itemLabel: (v) => v.toString(),
                    onChanged: _onBatchChanged,
                    validator: (_) => null,
                  ),

                  const SizedBox(height: 12),

                  // ✅ DYNAMIC BATCH TIMINGS – SIRF TAB DIKHENGE JAB BATCH SELECT HOGA
                  if (selectedBatch != null && selectedBatch! > 0) ...[
                    for (int i = 0; i < selectedBatch!; i++) ...[
                      Text(
                        "Timing for batch ${i + 1}",
                        style: AppTextStyles.centerText,
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => _pickBatchTime(i),
                        child: AbsorbPointer(
                          child: AppTextField(
                            controller: _batchTimeControllers[i],
                            keyboardType: TextInputType.text,
                            hintText: 'Select time',
                            label: '',
                            suffix: const Icon(Icons.access_time_rounded),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],

                  const SizedBox(height: 20),

                  // BOOKING DETAILS
                  Text("Booking details", style: AppTextStyles.topHeading3),
                  const SizedBox(height: 12),
                  Text("Seats booked", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: seatsBookedController,
                    keyboardType: TextInputType.number,
                    hintText: 'Seats booked',
                    label: '',
                  ),
                  const SizedBox(height: 12),
                  Text("Labs assigned", style: AppTextStyles.centerText),
                  const SizedBox(height: 6),
                  CustomDropdown<String>(
                    hintText: "Labs assigned",
                    value: selectedLabs,
                    items: widget.labOptions,
                    itemLabel: (v) => v,
                    onChanged: (v) => setState(() => selectedLabs = v),
                    validator: (_) => null,
                  ),

                  const SizedBox(height: 24),
                  CustomPrimaryButton(
                    text: "Confirm Booking",
                    onPressed: _onConfirmPressed,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
