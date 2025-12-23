import 'dart:io';
import 'package:bmtc_app/app/controllers/profile_update_controller.dart';
import 'package:bmtc_app/app/controllers/project_controller.dart';
import 'package:bmtc_app/app/controllers/self_booking_controller.dart';
import 'package:bmtc_app/app/controllers/view_self_booking_controller.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page1.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page3.dart';

import 'package:bmtc_app/app/screens/auth_pages/splash/splash_screen.dart';
import 'package:bmtc_app/app/screens/home/dashboard_page/dashBoard_page_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controllers/auth_controller.dart';
import 'app/controllers/profile_data_controller.dart';
import 'app/controllers/center_form_controller.dart'; // remove if unused

import 'app/screens/add_center_pages/center_details_page2.dart';
import 'app/screens/add_center_pages/center_details_page4.dart';
import 'app/utils/internate_checker.dart';
import 'app/utils/shared_preferances.dart';

/// ✅ Allow self-signed certificates for staging
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  Get.put(AuthController());

  Get.lazyPut(() => ExamCenterController());
  Get.lazyPut(() => ViewSelfBookingController());
  Get.lazyPut(() => ProfileDataController());
  Get.lazyPut(() => ProfileUpdateController());
  Get.lazyPut(() => SelfBookingController());
  Get.lazyPut(() => ProjectController());


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> _getInitialScreen() async {
    final centerId = await MySharedPrefs.get();
    if (kDebugMode) {
      print("🔥 AUTO LOGIN CHECK CENTER ID: $centerId");
    }

    if (centerId != null && centerId.isNotEmpty) {
      return const
      DashboardPageScreen();
    } else {
      return SplashScreen();
    }
  }

  final InternetChecker _internetChecker = InternetChecker();

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _internetChecker.startListening(context);
    });
  }

  @override
  void dispose() {
    _internetChecker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookMyTestCenter',

      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return snapshot.data!;
        },
      ),
    );
  }
}


