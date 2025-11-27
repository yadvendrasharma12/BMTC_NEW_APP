import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/text_style.dart';

class HelpsSupportScreen extends StatefulWidget {
  const HelpsSupportScreen({super.key});

  @override
  State<HelpsSupportScreen> createState() => _HelpsSupportScreenState();
}

class _HelpsSupportScreenState extends State<HelpsSupportScreen> {
  final String phoneNumber = '+91-9917823465';
  final String supportEmail = 'support@testpanindia.com';

  Future<void> _callNumber() async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print("Not Found");
    }
  }

  Future<void> _sendEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: supportEmail,
      query: Uri.encodeQueryComponent('subject=Support Request'),
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print("Not Found") ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 12,
                right: 12,
                bottom: 12,
                top: 16,
              ),
              padding: const EdgeInsets.all(16),
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Helps & Support',
                          style: AppTextStyles.dashBordButton2,
                        ),
                        Text(
                          'We are here to helps you with your queries',
                          style: AppTextStyles.topHeading3,
                        ),
                        const SizedBox(height: 16),


                        Text(
                          'Call Us',
                          style: AppTextStyles.inputHint,
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: _callNumber,
                          child: Text(
                            phoneNumber,
                            style: AppTextStyles.dashBordButton2.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),


                        Text(
                          'Email Us',
                          style: AppTextStyles.inputHint,
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: _sendEmail,
                          child: Text(
                            supportEmail,
                            style: AppTextStyles.dashBordButton2.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
