import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/screens/home/dashboard_page/dashBoard_page_screen.dart';
import 'package:bmtc_app/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/text_style.dart';

class videoPageScreen extends StatefulWidget {
  const videoPageScreen({super.key});

  @override
  State<videoPageScreen> createState() => _videoPageScreenState();
}

class _videoPageScreenState extends State<videoPageScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.sizeOf(context).width;

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(

          body: Center(
            child: Container(
              height: 560,
              margin:
              const EdgeInsets.only(left: 12, right: 12),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Welcome to BookMyTestCenter",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.centerDetailsTopTitle,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "We’re extremely exited to have you as a center partner",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: AppTextStyles.centerSubTitle,
                    ),
                  ),

                  const SizedBox(height: 26),



                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: CustomPrimaryButton(
                        text: "Let's get started",
                        onPressed: () {
                          _controller.pause();
                          Get.to(DashboardPageScreen());
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 27),
                  SizedBox(
                    height: h * 0.26,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: player,
                      ),
                    ),
                  ),




                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
