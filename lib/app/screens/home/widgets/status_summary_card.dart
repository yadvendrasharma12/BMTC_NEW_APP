import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';

class StatusSummaryCard extends StatelessWidget {
  final String title;
  final int currentCount;
  final int? totalCount;

  /// 🔹 Ab optional & nullable
  final double? percentage;

  final String iconPath;
  final Widget? countTrailing;

  // optional customization
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final Color? currentCountColor;
  final Color? totalCountColor;
  final Color? percentageBorderColor;
  final Color? percentageTextColor;

  // year dropdown
  final bool showYearDropdown;
  final String? selectedYear;
  final ValueChanged<String?>? onYearChanged;

  const StatusSummaryCard({
    super.key,
    required this.title,
    required this.currentCount,
    this.totalCount,
    this.percentage, // ⬅️ ab optional
    required this.iconPath,
    this.countTrailing,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.currentCountColor,
    this.totalCountColor,
    this.percentageBorderColor,
    this.percentageTextColor,
    this.showYearDropdown = false,
    this.selectedYear,
    this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    Widget _buildCountRow() {
      if (countTrailing != null) {
        return countTrailing!;
      }

      if (totalCount != null) {
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "$currentCount",
              style: GoogleFonts.karla(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: currentCountColor ?? AppColors.blackColor,
              ),
            ),
            Text(
              "/${totalCount!}",
              style: GoogleFonts.karla(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: totalCountColor ?? AppColors.grey73,
              ),
            ),
          ],
        );
      }

      return Text(
        "$currentCount",
        style: GoogleFonts.karla(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: currentCountColor ?? AppColors.blackColor,
        ),
      );
    }

    Widget _buildRightSide() {
      // 🔹 Agar dropdown dikhana hai → percentage ignore
      if (showYearDropdown) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          height: 27,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: percentageBorderColor ?? AppColors.grey73,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedYear,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 21,
              ),
              style: AppTextStyles.inputHint.copyWith(
                color: percentageTextColor ?? AppColors.blackColor,
              ),
              onChanged: onYearChanged,
              items: const [
                DropdownMenuItem(
                  value: "1Y",
                  child: Text("1Y"),
                ),
                DropdownMenuItem(
                  value: "2Y",
                  child: Text("2Y"),
                ),
                DropdownMenuItem(
                  value: "3Y",
                  child: Text("3Y"),
                ),
                DropdownMenuItem(
                  value: "4Y",
                  child: Text("4Y"),
                ),
              ],
            ),
          ),
        );
      }

      // 🔹 Agar percentage hi nahi diya gaya → kuch mat dikhाओ (ya chhota gap)
      if (percentage == null) {
        return const SizedBox(width: 10);
      }

      // 🔹 Normal percentage chip
      return Container(
        margin: const EdgeInsets.only(top: 30),
        height: 27,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: percentageBorderColor ?? AppColors.grey73,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          "${percentage!.toStringAsFixed(2)}%",
          style: AppTextStyles.inputHint.copyWith(
            color: percentageTextColor ?? AppColors.grey73,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 125,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? AppColors.grey73),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 55,
                width: 55,
                child: Image.asset(
                  iconPath,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.centerText.copyWith(
                      color: titleColor ?? AppColors.blackColor,
                    ),
                  ),
                  _buildCountRow(),
                ],
              ),
            ],
          ),
          _buildRightSide(),
        ],
      ),
    );
  }
}
