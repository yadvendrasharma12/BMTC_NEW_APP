import 'package:bmtc_app/app/core/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

customAppBar(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.background,
    elevation: 0,
    flexibleSpace: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Text(
          title,
          style: GoogleFonts.karla(
            fontSize: 24,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
