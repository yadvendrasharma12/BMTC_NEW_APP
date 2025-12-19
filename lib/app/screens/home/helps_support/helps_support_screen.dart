import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/text_style.dart';
import '../../../core/app_colors.dart';

class HelpsSupportScreen extends StatefulWidget {
  const HelpsSupportScreen({super.key});

  @override
  State<HelpsSupportScreen> createState() => _HelpsSupportScreenState();
}

class _HelpsSupportScreenState extends State<HelpsSupportScreen> {
  final String phoneNumber = '+91 99178 23465';
  final String supportEmail = 'support@testpanindia.com';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// SIMULATE API / DATA LOAD
  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _callNumber() async {
    final uri = Uri.parse('tel:$phoneNumber');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _sendEmail() async {
    final uri = Uri.parse(
      'mailto:$supportEmail?subject=Support Request',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,

      body: isLoading ? _loader() : _mainContent(),
    );
  }

  /// ================= LOADER =================
  Widget _loader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// ================= MAIN UI =================
  Widget _mainContent() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          /// HEADER CARD
          Row(
            children: [
              Text(
                        "Help & Support",
                        style: AppTextStyles.topHeading2,
                      ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black.withOpacity(0.08),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need Help?',
                  style: AppTextStyles.dashBordButton2,
                ),
                const SizedBox(height: 6),
                Text(
                  'We are here to help you with any queries or issues.',
                  style: AppTextStyles.centerText,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// CALL SUPPORT
          _supportTile(
            icon: Icons.call,
            title: 'Call Us',
            subtitle: phoneNumber,
            onTap: _callNumber,
          ),

          SizedBox(height: 16,),


          _supportTile(
            icon: Icons.email,
            title: 'Email Us',
            subtitle: supportEmail,
            onTap: _sendEmail,
          ),


          SizedBox(height: 21,),
          /// INFO
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.borderColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Support is available Monday to Saturday, 10 AM – 6 PM.',
                    style: AppTextStyles.centerText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= DIVIDER =================
  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Divider(
        thickness: 1,
        color: Colors.grey.shade300,
      ),
    );
  }

  /// ================= SUPPORT TILE =================
  Widget _supportTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black.withOpacity(0.07),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.centerSubTitle),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.centerText.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
