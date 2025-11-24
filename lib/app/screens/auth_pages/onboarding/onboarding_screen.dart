

import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../register/register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/mobile-app.png",
      "title": "Create your Center Profile",
      "desc":
      "Create and showcase your center profiles to get more exam bookings."
    },
    {
      "image": "assets/images/mobile.png",
      "title": "Create your Center Profile",
      "desc":
      "Create and showcase your center profiles to get more exam bookings."
    },
    {
      "image": "assets/images/mobile-app.png",
      "title": "Create your Center Profile",
      "desc":
      "Create and showcase your center profiles to get more exam bookings."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardContent(
                  image: onboardingData[index]["image"]!,
                  title: onboardingData[index]["title"]!,
                  desc: onboardingData[index]["desc"]!,
                ),
              ),
            ),
            SizedBox(height: 32,),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.offAll(RegisterScreen());

                          },
                          child:  Text(
                            "Skip",
                            style: GoogleFonts.karla(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            if (_currentPage == onboardingData.length - 1) {
                             Get.offAll(RegisterScreen());
                            } else {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                          child: Text(
                            _currentPage == onboardingData.length - 1
                                ? "Get Started"
                                : "Next",
                            style:  GoogleFonts.karla(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 25 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ?  Colors.black
            : Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  final String image, title, desc;

  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Expanded(
          child: Image.asset(image, fit: BoxFit.contain),
        ),
        const SizedBox(height: 20),
        Text(
          title,
         style: AppTextStyles.onBoard1stText,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: AppTextStyles.onBoard2ndText,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
