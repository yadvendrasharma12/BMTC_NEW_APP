import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/text_style.dart';

class TestYoutubeScreen extends StatefulWidget {
  const TestYoutubeScreen({super.key});

  @override
  State<TestYoutubeScreen> createState() => _TestYoutubeScreenState();
}

class _TestYoutubeScreenState extends State<TestYoutubeScreen> {
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "Welcome to BookMyTestCenter",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.centerDetailsTopTitle,
                ),
                const SizedBox(height: 8),
                Text(
                  "We’re extremely exited to have you as a center partner",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: AppTextStyles.centerSubTitle,
                ),

                const SizedBox(height: 32),

                SizedBox(
                  height: h * 0.30,
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: player,
                  ),
                ),

                const SizedBox(height: 40),

                // ✅ Button
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomPrimaryButton(
                      text: "Let's get started",
                      onPressed: () {
                        // TODO: navigate yaha
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
