
import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardDrawer extends StatelessWidget {
  final List<String> menuItems;
  final List<String> icons;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const DashboardDrawer({
    super.key,
    required this.menuItems,
    required this.icons,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            const SizedBox(height: 75),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('BookMyTestCenter', style: AppTextStyles.heading2),
              ),
            ),
            const Divider(),
            ...List.generate(menuItems.length, (index) {
              final bool isSelected = index == selectedIndex;
              return InkWell(
                onTap: () => onItemSelected(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        icons[index],
                        height: 20,
                        width: 20,
                        color: isSelected ? AppColors.background : AppColors.grey73,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        menuItems[index],
                        style: TextStyle(
                          color: isSelected ? AppColors.background : AppColors.grey73,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const Spacer(),
            // Profile container...
          ],
        ),
      ),
    );
  }
}
class DrawerItem {
  final String title;
  final String iconPath;
  final Widget screen;

  DrawerItem({
    required this.title,
    required this.iconPath,
    required this.screen,
  });
}

