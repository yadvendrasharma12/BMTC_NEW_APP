import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:bmtc_app/app/core/app_colors.dart';

class DashboardTopBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedMenuIndex;
  final TabController? tabController;

  /// 👇 New props
  final String? titleText;
  final Widget? titleWidget;

  const DashboardTopBar({
    super.key,
    required this.selectedMenuIndex,
    required this.tabController,
    this.titleText,
    this.titleWidget,
  });

  @override
  Size get preferredSize {
    if (selectedMenuIndex == 0 && tabController != null) {
      return const Size.fromHeight(kToolbarHeight + 48);
    }
    return const Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    Widget resolvedTitle;

    if (titleWidget != null) {
      resolvedTitle = titleWidget!;
    } else if (titleText != null) {
      // Agar sirf text diya hai
      resolvedTitle = Text(
        titleText!,
        style: AppTextStyles.heading2, // ya jo bhi tumhara style ho
      );
    } else {
      // Default: dashboard ka logo
      resolvedTitle = Image.asset(
        "assets/icons/Group 1073714240.png",
        scale: 1.2,
        filterQuality: FilterQuality.high,
      );
    }

    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.menu_open_outlined,
          color: AppColors.blackColor,
          size: 28,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.background,
      titleSpacing: 0,
      title: resolvedTitle,
      bottom: (selectedMenuIndex == 0 && tabController != null)
          ? PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: tabController,
            isScrollable: false,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.grey73,
            labelStyle: AppTextStyles.linkText,
            indicatorColor: AppColors.primaryColor,
            automaticIndicatorColorAdjustment: true,
            tabs: const [
              Tab(text: 'Total Booking'),
              Tab(text: 'In Review'),
              Tab(text: 'Confirmed Bookings'),
            ],
          ),
        ),
      )
          : null,
    );
  }
}
