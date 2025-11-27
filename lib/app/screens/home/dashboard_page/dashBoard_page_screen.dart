import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/screens/home/center_pages/center_page_screen.dart';
import 'package:bmtc_app/app/screens/home/helps_support/helps_support_screen.dart';
import 'package:bmtc_app/app/screens/home/settings/settings_screen.dart';
import 'package:bmtc_app/app/screens/home/tabs/tab_screen/booking_request_screen.dart';
import 'package:bmtc_app/app/screens/home/tabs/tab_screen/confirm_booking_screen.dart';
import 'package:bmtc_app/app/screens/home/tabs/tab_screen/in_review_screen.dart';
import 'package:flutter/material.dart';

import '../calendar_page/calendar_screen.dart';
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

  final List<String> menuItems = [
    'My Bookings',
    'My Center',
    'My Calendar',
    'Settings',
    'Help & Support',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        menuItems: menuItems,
        selectedIndex: selectedMenuIndex,
        onItemSelected: (int index) {
          setState(() {
            selectedMenuIndex = index;
          });
        },
      ),
      appBar: DashboardTopBar(
        selectedMenuIndex: selectedMenuIndex,
        tabController: _tabController,
      ),
      body: _buildBody(),
    );
  }


  Widget _buildBody() {
    switch (selectedMenuIndex) {
      case 0:
        return TabBarView(
          controller: _tabController,
          children: const [
            BookingRequestScreen(),
            InReviewScreen(),
            ConfirmBookingScreen()
          ],
        );
      case 1:
        return CenterPageScreen();
      case 2:
        return CalendarScreen();
      case 3:
        return SettingsScreen();
      case 4:
        return HelpsSupportScreen();

      default:
        return Center(
          child: Text(
            'Screen not found',
            style: TextStyle(fontSize: 16),
          ),
        );
    }
  }

}



