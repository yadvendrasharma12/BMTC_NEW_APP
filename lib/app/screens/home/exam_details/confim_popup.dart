
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/project_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/text_style.dart';

class ConfimPopup extends StatefulWidget {
  final String projectId;
  const ConfimPopup({super.key,required this.projectId});

  @override
  State<ConfimPopup> createState() => _ConfimPopupState();
}

class _ConfimPopupState extends State<ConfimPopup> {
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
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          data.bookingReceived ?? '',
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green.shade800,
                            child: const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Icon(Icons.check, color: Colors.white, size: 16),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Booking Accepted on ",
                                      style: AppTextStyles.topHeading3,
                                    ),
                                    Expanded(
                                      child: Text(
                                        data.centerBookingAcceptDate ?? '',
                                        style: AppTextStyles.centerText,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  "Entry added to your Calendar",
                                  style: AppTextStyles.topHeading3,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green.shade800,
                            child: const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Icon(Icons.check, color: Colors.white, size: 16),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Booking confirmed on ",
                                      style: AppTextStyles.topHeading3,
                                    ),
                                    Expanded(
                                      child: Text(
                                        data.clientAcceptBookingDate ?? '',
                                        style: AppTextStyles.centerText,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  "Entry added to your Calendar",
                                  style: AppTextStyles.topHeading3,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 12,),

                      Text("1. Project Details", style: AppTextStyles.dashBordButton3),

                      SizedBox(height: 10,),

                      _field("Exam Date", data.startDate),
                      _field("Exam Name", data.examName),
                      _field("Exam City", data.examCityName),
                      _field("Seats",
                          data.numberOfSeats?.toString()),
                      _field("Pricing",
                          "₹ ${data.pricePerSeat ?? '-'}"),

                      const SizedBox(height: 14),
                      Text(
                        "2. Software & Hardware requirements",
                        style: AppTextStyles.dashBordButton3,
                      ),
                      SizedBox(height: 5,),
                      _field("Exam Mode", data.examMode),
                      const SizedBox(height: 14),
                      Text(
                        "3. Computer configuration",
                        style: AppTextStyles.dashBordButton3,
                      ),
                      SizedBox(height: 5,),
                      _field("Operating System", data.inetModeOs),
                      _field("RAM", data.inetModeRam),
                      _field("Processor", data.inetModeProcessor),
                      _field("Display Resolution", data.inetModeDisplay),
                      _field("Internet on each device", data.inetModeInternetEach),
                      const SizedBox(height: 14),
                      Text(
                        "4. Amenity Requirements",
                        style: AppTextStyles.dashBordButton3,
                      ),
                      SizedBox(height: 5,),
                      _field("Parking Facility", data.parkingFacility),
                      _field("Security guard", data.securityGuard),
                      _field("Lockers", data.lockerFacility),
                      _field("Waiting Area", data.waitingArea),
                      _field("Power Backup", data.powerBackup),
                      _field("PH Handicapped", data.phHandicaped),
                      _field("Printer", data.printer),
                      _field("Rough Sheet", data.roughSheet),
                      _field("Partition", data.partitionInLab),
                      _field("Ac in each Lab", data.acInLab),
                      _field("CCTV Required", data.cctvRequired),
                      SizedBox(height: 10,),
                      Divider(
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have a question?",
                            style: AppTextStyles.centerText,
                          ),
                          Text(
                            "Contact us",
                            style: AppTextStyles.linkTexts,
                          ),
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
  Widget _field(String label, String? value) {
    String displayValue = "N/A";

    if (value != null && value.isNotEmpty) {
      if (value == "1") {
        displayValue = "Yes";
      } else if (value == "0") {
        displayValue = "No";
      } else {
        displayValue = value;
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
}
