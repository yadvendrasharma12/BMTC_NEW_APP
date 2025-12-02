import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/screens/home/center_pages/center_page_screen.dart';
import 'package:bmtc_app/app/screens/home/helps_support/helps_support_screen.dart';
import 'package:bmtc_app/app/screens/home/settings/settings_screen.dart';
import 'package:bmtc_app/app/screens/home/tabs/tab_screen/booking_request_screen.dart';
import 'package:bmtc_app/app/screens/home/tabs/tab_screen/confirm_booking_screen.dart';
import 'package:bmtc_app/app/screens/home/tabs/tab_screen/in_review_screen.dart';
import 'package:flutter/material.dart';

import '../calendar_page/calendar_screen.dart';
import '../self_booking/self_booking_screen.dart';
import '../widgets/dashboard_drawer.dart';
import '../widgets/dashboard_topbar.dart';

class DashboardPageScreen extends StatefulWidget {
  const DashboardPageScreen({super.key});

  @override
  State<DashboardPageScreen> createState() => _DashboardPageScreenState();
}

class _DashboardPageScreenState extends State<DashboardPageScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  int selectedMenuIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<DrawerItem> drawerItems;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    drawerItems = [
      DrawerItem(
        title: "My Bookings",
        iconPath: "assets/icons/radio_button_checked.png",
        screen: TabBarView(
          controller: _tabController,
          children: const [
            BookingRequestScreen(),
            InReviewScreen(),
            ConfirmBookingScreen(),
          ],
        ),
      ),
      DrawerItem(
        title: "My Center",
        iconPath: "assets/icons/Calendar.png",
        screen: const CenterPageScreen(),
      ),
      DrawerItem(
        title: "My Calendar",
        iconPath: "assets/icons/Calendar.png",
        screen: const CalendarScreen(),
      ),
      DrawerItem(
        title: "Self Bookings",
        iconPath: "assets/icons/Calendar.png",
        screen: const SelfBookingScreen(),
      ),
      DrawerItem(
        title: "Settings",
        iconPath: "assets/icons/settings.png",
        screen: const SettingsScreen(),
      ),
      DrawerItem(
        title: "Help & Support",
        iconPath: "assets/icons/Help circle.png",
        screen: const HelpsSupportScreen(),
      ),

    ];
  }

  void _onMenuItemSelected(int index) {
    setState(() {
      selectedMenuIndex = index;
      if (selectedMenuIndex == 0) _tabController.index = 0;
    });
    Navigator.of(context).pop(); // Drawer close
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: DashboardDrawer(
        menuItems: drawerItems.map((e) => e.title).toList(),
        icons: drawerItems.map((e) => e.iconPath).toList(),
        selectedIndex: selectedMenuIndex,
        onItemSelected: _onMenuItemSelected,
      ),
      appBar: DashboardTopBar(
        selectedMenuIndex: selectedMenuIndex,
        tabController: selectedMenuIndex == 0 ? _tabController : null,
      ),
      body: drawerItems[selectedMenuIndex].screen,
    );
  }
}



