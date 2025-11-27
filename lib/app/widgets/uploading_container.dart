import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadingContainer extends StatelessWidget {
  final String infoText;
  final String buttonText;
  final VoidCallback onPressed;

  const UploadingContainer({
    super.key,
    required this.infoText,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 12,bottom: 12,right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 0.5),
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: AppColors.primaryColor, // 🔹 border color
                  width: 1.2,
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: GoogleFonts.karla(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white, // 🔹 text black
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              infoText,
              style: GoogleFonts.karla(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
