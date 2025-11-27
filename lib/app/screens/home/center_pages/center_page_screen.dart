
import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/screens/home/center_pages/center_details_screen.dart';
import 'package:bmtc_app/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

import '../../../core/text_style.dart';

class CenterPageScreen extends StatefulWidget {
  const CenterPageScreen({super.key});

  @override
  State<CenterPageScreen> createState() => _CenterPageScreenState();
}

class _CenterPageScreenState extends State<CenterPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 12,
                right: 12,
                bottom: 12,
                top: 10,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 88 ,
                          width: 88,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),  
                          ),

                          child: Image.asset("assets/images/images-center.png",filterQuality: FilterQuality.high,),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Zyprus Ltd.',
                          style: AppTextStyles.heading2,
                        ),
                        SizedBox(height: 6,),
                        Text(
                          'This centrally located Delhi test center is equipped with advanced CCTV and modern computer systems for secure, efficient exam conduction.  The prime location offers easy access for candidates. Ideal for both online and offline tests.',
                          style: AppTextStyles.topHeading3,
                        ),
                        SizedBox(height: 5,),
                        Divider(),
                        SizedBox(height: 5,),
                        Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("Location",style: AppTextStyles.topHeading3,),
                            Text("Neon Tower, Block 2, Delhi 110086",style: AppTextStyles.linkText,)
                          ],),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Seating",style: AppTextStyles.topHeading3,),
                              Text("1540",style: AppTextStyles.linkText,)
                            ],),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Audited",style: AppTextStyles.topHeading3,),
                              Container(
                                height: 22,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.ConfirmColor,
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Yes",style: AppTextStyles.linkText,),
                              ),

                            ],),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Available",style: AppTextStyles.topHeading3,),
                              Container(
                                height: 22,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.ConfirmColor,
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Yes",style: AppTextStyles.linkText,),
                              ),

                            ],),
                        ],),
                        SizedBox(height: 12,),
                        Divider(),
                        SizedBox(height: 22,),

                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.fillColorFB,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [

                              SizedBox(
                                height: 48,
                                width: 48,
                                child: Image.asset(
                                  "assets/logo/audit-report.png",
                                  filterQuality: FilterQuality.high,
                                ),
                              ),

                              const SizedBox(width: 10),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Audit Report",
                                    style: AppTextStyles.linkText,
                                  ),
                                  Text(
                                    "Last audited on Oct 10th, 2024",
                                    style: AppTextStyles.inputHint,
                                  ),
                                ],
                              ),

                              Spacer(),

                              Container(
                                height: 30,
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.borderColor),
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  "View",
                                  style: AppTextStyles.caption,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12,),

                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.fillColorFB,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [

                              SizedBox(
                                height: 48,
                                width: 48,
                                child: Image.asset(
                                  "assets/logo/location.png",
                                  filterQuality: FilterQuality.high,
                                ),
                              ),

                              const SizedBox(width: 10),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Zyprus Ltd.",
                                    style: AppTextStyles.linkText,
                                  ),
                                  Text(
                                    "Last audited on Oct 10th, 2024",
                                    style: AppTextStyles.inputHint,
                                  ),
                                ],
                              ),

                              Spacer(),

                              Container(
                                height: 30,
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.borderColor),
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  "View",
                                  style: AppTextStyles.caption,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 26,),
                        CustomPrimaryButton(text: "More Details", onPressed: (){
                          Get.to(CenterDetailsScreen());
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
