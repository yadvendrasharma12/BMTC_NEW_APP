import 'package:bmtc_app/app/screens/add_center_pages/center_details_page1.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page3.dart';
import 'package:bmtc_app/app/screens/auth_pages/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controllers/auth_controller.dart';
import 'app/controllers/center_form_controller.dart';
import 'app/screens/add_center_pages/center_details_page4.dart';
import 'app/services/connection_service/connectvity_service.dart';
import 'app/utils/toast_message.dart';
import 'app/screens/auth_pages/splash/splash_screen.dart';

void main() {
  Get.lazyPut(() => ExamCenterController());
  Get.put(AuthController());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final connectivityService = ConnectivityService();



  @override
  void dispose() {
    connectivityService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookMyTestCenter',
      home: RegisterScreen(),
    );
  }
}
