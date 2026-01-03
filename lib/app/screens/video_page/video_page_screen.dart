// import 'package:bmtc_app/app/core/app_colors.dart';
// import 'package:bmtc_app/app/screens/home/dashboard_page/dashBoard_page_screen.dart';
// import 'package:bmtc_app/app/widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// import '../../core/text_style.dart';
//
// class VideoPageScreen extends StatefulWidget {
//   const VideoPageScreen({super.key});
//
//   @override
//   State<VideoPageScreen> createState() => _VideoPageScreenState();
// }
//
// class _VideoPageScreenState extends State<VideoPageScreen> {
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = YoutubePlayerController(
//       initialVideoId: 'dQw4w9WgXcQ',
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         controlsVisibleAtStart: true,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.pause();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.sizeOf(context).width;
//
//      return  YoutubePlayerBuilder(
//       player: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.blue,
//       ),
//       builder: (context, player) {
//         return Scaffold(
//           body: Center(
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 4,
//                     spreadRadius: 1,
//                     color: Colors.black.withOpacity(0.05),
//                   ),
//                 ],
//               ),
//               child:Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(height: 20),
//                   Text(
//                     "Welcome to BookMyTestCenter",
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.centerDetailsTopTitle,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "We’re extremely excited to have you as a center partner",
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     style: AppTextStyles.centerSubTitle,
//                   ),
//                   const SizedBox(height: 26),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: CustomPrimaryButton(
//                       text: "Let's get started",
//                       onPressed: () {
//                         _controller.pause();
//                         Get.to(DashboardPageScreen());
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//
//                   // Full width video
//                   ClipRRect(
//
//                     borderRadius: BorderRadius.circular(12),
//                     child: SizedBox(
//                       width: double.infinity, // full width
//                       child: AspectRatio(
//
//                         aspectRatio: 17 / 9,
//                         child: YoutubePlayer(
//                           controller: _controller,
//                           showVideoProgressIndicator: true,
//                           progressIndicatorColor: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               )
//
//             ),
//           ),
//         );
//       },
//     );
//
//   }
// }



import 'package:bmtc_app/app/screens/home/dashboard_page/dashBoard_page_screen.dart';
import 'package:bmtc_app/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../core/text_style.dart';
import '../../widgets/custom_appbar.dart';

class VideoPageScreen extends StatefulWidget {
  const VideoPageScreen({super.key});

  @override
  State<VideoPageScreen> createState() => _VideoPageScreenState();
}

class _VideoPageScreenState extends State<VideoPageScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      'assets/videos/intro_video.mp4',
    )..initialize().then((_) {
      setState(() {});
      _controller.play();
    });
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying
          ? _controller.pause()
          : _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: customAppBar("Welcome to BookMyTestCenter"),
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              if (_controller.value.isInitialized)
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.12),
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio:
                            _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),

                          /// ▶️ Show only when paused
                          if (!_controller.value.isPlaying)
                            Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.45),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 46,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 28),



              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "We’re extremely excited to have you as a center partner",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.centerSubTitle,
                ),
              ),

              const Spacer(),

              /// 🚀 CTA BUTTON
              CustomPrimaryButton(
                text: "Let's get started",
                onPressed: () {
                  _controller.pause();
                  Get.to(DashboardPageScreen());
                },
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
