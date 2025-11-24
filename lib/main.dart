import 'package:bmtc_app/app/screens/add_center_pages/center_details_page1.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page3.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page4.dart';
import 'package:bmtc_app/app/screens/auth_pages/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/screens/add_center_pages/center_details_page2.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff2A75AE)),
        useMaterial3: true,
      ),
      home: RegisterScreen(),
    );
  }
}

