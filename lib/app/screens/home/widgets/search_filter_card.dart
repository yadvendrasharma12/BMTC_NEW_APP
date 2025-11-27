
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:bmtc_app/app/widgets/custom_textformfield.dart';

class SearchFilterCard extends StatelessWidget {
  final TextEditingController controller;
  final String searchLabel;
  final String filterLabel;
  final String exportLabel;

  // customizable colors
  final Color? cardColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? primaryButtonColor;
  final Color? primaryButtonTextColor;

  final VoidCallback? onFilterTap;
  final VoidCallback? onExportTap;

  const SearchFilterCard({
    super.key,
    required this.controller,
    this.searchLabel = "Enter exam name..",
    this.filterLabel = "Filter By",
    this.exportLabel = "Export",
    this.cardColor,
    this.borderColor,
    this.textColor,
    this.primaryButtonColor,
    this.primaryButtonTextColor,
    this.onFilterTap,
    this.onExportTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveCardColor = cardColor ?? AppColors.background;
    final Color effectiveBorderColor = borderColor ?? AppColors.borderColor;
    final Color effectiveTextColor = textColor ?? AppColors.blackColor;
    final Color effectivePrimaryButtonColor =
        primaryButtonColor ?? AppColors.blackColor;
    final Color effectivePrimaryButtonTextColor =
        primaryButtonTextColor ?? AppColors.background;

    return Container(
      decoration: BoxDecoration(
        color: effectiveCardColor,
        borderRadius: BorderRadius.circular(12),

      ),
      child: Padding(
        padding:
        const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 0),
        child: Column(
          children: [
            // 🔍 Search field
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: AppTextField(
                    prefix: const Icon(CupertinoIcons.search),
                    controller: controller,
                    label: searchLabel,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Filter + Export buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filter
                GestureDetector(
                  onTap: onFilterTap,
                  child: Container(
                    height: 44,
                    width: 115,
                    decoration: BoxDecoration(
                      border: Border.all(color: effectiveBorderColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          filterLabel,
                          style: AppTextStyles.centerText
                              .copyWith(color: effectiveTextColor),
                        ),
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),

                // Export
                GestureDetector(
                  onTap: onExportTap,
                  child: Container(
                    height: 44,
                    width: 115,
                    decoration: BoxDecoration(
                      color: effectivePrimaryButtonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          exportLabel,
                          style: AppTextStyles.button.copyWith(
                            color: effectivePrimaryButtonTextColor,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.download,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
