import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/project_controller.dart';
import '../../../utils/toast_message.dart';

class CounslingFormScreen extends StatefulWidget {
  const CounslingFormScreen({super.key});

  @override
  State<CounslingFormScreen> createState() => _CounslingFormScreenState();
}

class _CounslingFormScreenState extends State<CounslingFormScreen> {
  final ProjectController projectController = Get.put(ProjectController());

  @override
  void initState() {
    super.initState();

    final projectId = Get.arguments['project_id'];
    projectController.projectId = projectId;
    projectController.fetchProjectDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
     
      body: Obx(() {
        if (projectController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = projectController.projectData.value;

        if (data == null) {
          return const Center(child: Text("No project details available"));
        }

        return SafeArea(
          child: Column(

            children: [
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],),
                Divider(),
                SizedBox(height: 8,),
              ],),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 16,right: 16,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.examName ?? '',style: AppTextStyles.dashBordButton2,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
          
          
          
                              Text("Booking Received Date", style: AppTextStyles.topHeading3),
                              SizedBox(width: 7,),
                              Text(
                                data.bookingReceived ?? '',
                                style: AppTextStyles.centerText,
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              CircleAvatar(
                                backgroundColor: Colors.red.shade800,
                                radius: 16,
                                child: Icon(Icons.close,color: Colors.white,),
                              ),
                              SizedBox(width: 10,),
                              Text("Booking cancelled on", style: AppTextStyles.topHeading3),
                              SizedBox(width: 7,),
                              Text(
                                data.centerBookingAcceptDate ?? '',
                                style: AppTextStyles.centerText,
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Divider(),
                          SizedBox(height: 16,),
                          Text("1. Project Details", style: AppTextStyles.dashBordButton3),
          
                        ],
                      ),
          
                      const SizedBox(height: 0),
                      _buildField("Exam Date", data.startDate ?? ''),
                      _buildField("Exam Name", data.examName ?? ''),
                      _buildField("Exam City", data.examCityName ?? ''),
                      _buildField("Seats", data.numberOfSeats ?? ''),
                      _buildField("Exam Type", data.examType ?? ''),
                      _buildField("Pricing", data.pricePerSeat ?? ''),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "2. Software & Hardware requirements",
                          style: AppTextStyles.dashBordButton3,
                        ),
                      ),
                      _buildField("Exam Mode", data.examMode ?? ''),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Computer configuration",
                          style: AppTextStyles.dashBordButton3,
                        ),
                      ),
                      _buildField("Operating System", data.inetModeOs ?? ''),
                      _buildField("RAM", data.inetModeRam ?? ''),
                      _buildField("Processor", data.inetModeProcessor ?? ''),
                      _buildField(
                        "Display Resolution",
                        data.inetModeDisplay ?? '',
                      ),
                      _buildField(
                        "Internet on each device",
                        data.inetModeInternetEach ?? '',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Amenity requirements",
                          style: AppTextStyles.dashBordButton3,
                        ),
                      ),
                      _buildField("Parking Facility", data.parkingFacility ?? ''),
                      _buildField("Security Guard", data.securityGuard ?? ''),
                      _buildField("AC in Lab", data.acInLab ?? ''),
                      _buildField("Lockers", data.lockerFacility ?? ''),
                      _buildField("Waiting area", data.waitingArea ?? ''),
                      _buildField("Power Backup", data.powerBackup ?? ''),
                      _buildField("PH Handicapped", data.phHandicaped ?? ''),
                      _buildField("Printer", data.printer ?? ''),
                      _buildField("Rough Sheet", data.roughSheet ?? ''),
                      _buildField("Partition", data.partitionInLab ?? ''),
                      _buildField("Ac in Each Lab", data.acInLab ?? ''),
                      _buildField("CCTV Required", data.cctvRequired ?? ''),
          
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          var resp = await projectController.acceptBooking();

                          if (resp['status'] == true) {
                            AppToast.showSuccess(context, resp['message']);
                          } else {
                            AppToast.showError(context, resp['message']);
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text("Accept", style: AppTextStyles.button),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          var resp = await projectController.rejectBooking();

                          if (resp['status'] == true) {
                            AppToast.showSuccess(context, resp['message']);
                          } else {
                            AppToast.showError(context, resp['message']);
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text("Reject", style: AppTextStyles.button),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildField(String label, String value) {
    // Convert 0/1 to No/Yes
    String displayValue = value;
    if (value == '0') displayValue = 'No';
    else if (value == '1') displayValue = 'Yes';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Text(
                textAlign: TextAlign.start,
                displayValue,
                style: AppTextStyles.centerText,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
