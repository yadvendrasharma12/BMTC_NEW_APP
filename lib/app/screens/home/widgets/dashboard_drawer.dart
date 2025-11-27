
import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardDrawer extends StatelessWidget {
  final List<String> menuItems;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const DashboardDrawer({
    super.key,
    required this.menuItems,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {

    List<dynamic> images = [
      "assets/icons/radio_button_checked.png",
      "assets/icons/Calendar.png",
      "assets/icons/Calendar.png",
      "assets/icons/settings.png",
      "assets/icons/Help circle.png"
    ];
    return Drawer(
      child: Container(
        color: AppColors.background,
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16,top: 75,bottom: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    'BookMyTestCenter',
                    style: AppTextStyles.heading2
                ),
              ),
            ),

            Column(
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 16,bottom: 16,top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      textAlign: TextAlign.start,
                      'GENERAL',
                      style: AppTextStyles.topHeading3
                    ),
                  ),
                ),
              ],
            ),

            ...List.generate(menuItems.length, (index) {
              final bool isSelected = index == selectedIndex;

              return InkWell(
                onTap: () {
                  onItemSelected(index);
                  Navigator.pop(context);
                },
                child: Container(

                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [

                      Image.asset(images[index],filterQuality: FilterQuality.high,
                        color: isSelected ? AppColors.background : AppColors.grey73,
                        height: 20,width: 20,
                        fit: BoxFit.fill,



                      ) ,

                      const SizedBox(width: 10),
                      Text(
                        menuItems[index],
                        style: GoogleFonts.karla(
                          fontSize: 17,
                          color: isSelected ? AppColors.background : AppColors.grey73,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),

            Container(
              margin: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 30, top: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
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
                children:  [
                  CircleAvatar(
                    radius: 18,
                    child: Icon(Icons.person, size: 18),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LTPV Group',
                        style:AppTextStyles.centerText,
                      ),
                      Text(
                        'info@email.com',
                        style: AppTextStyles.inputHint,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.more_vert, size: 19,color: AppColors.blackColor,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
