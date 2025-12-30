// import 'dart:async';
// import 'package:bmtc_app/app/core/app_colors.dart';
// import 'package:bmtc_app/app/screens/auth_pages/onboarding/onboarding_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );
//
//     _controller.forward();
//
//     Timer(const Duration(seconds: 3), () {
//        Get.offAll(() => OnboardingScreen());
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: Center(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Image.asset(
//               "assets/logo/BMTCLogo.png",
//               height: 160,
//               filterQuality: FilterQuality.high,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page1.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page3.dart';
import 'package:bmtc_app/app/screens/add_center_pages/center_details_page4.dart';
import 'package:bmtc_app/app/screens/auth_pages/login/login_screen.dart';
import 'package:bmtc_app/app/screens/auth_pages/onboarding/onboarding_screen.dart';
import 'package:bmtc_app/app/screens/home/dashboard_page/dashBoard_page_screen.dart';
import 'package:bmtc_app/app/utils/shared_preferances.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../add_center_pages/center_details_page2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    _navigate();
  }

  Future<void> _navigate() async {
    final centerId = await MySharedPrefs.get();

    if (kDebugMode) {
      print("🔥 AUTO LOGIN CHECK CENTER ID: $centerId");
    }

    await Future.delayed(const Duration(seconds: 3));

    if (centerId != null && centerId.isNotEmpty) {
      Get.offAll(() => const DashboardPageScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              "assets/logo/BMTCLogo.png",
              height: 160,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

