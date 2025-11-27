import 'package:flutter/material.dart';
import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';

class ActionButtonsCard extends StatelessWidget {
  /// Texts ab optional ho gaye
  final String? primaryText;
  final String? secondaryText;

  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? primaryButtonColor;
  final Color? primaryTextColor;
  final Color? secondaryButtonColor;
  final Color? secondaryBorderColor;
  final Color? secondaryTextColor;

  const ActionButtonsCard({
    super.key,
    this.primaryText,
    this.secondaryText,
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.backgroundColor,
    this.borderColor,
    this.primaryButtonColor,
    this.primaryTextColor,
    this.secondaryButtonColor,
    this.secondaryBorderColor,
    this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackground = backgroundColor ?? AppColors.background;
    final Color effectiveBorder = borderColor ?? AppColors.grey73;
    final Color effectivePrimaryButtonColor =
        primaryButtonColor ?? AppColors.blackColor;
    final Color effectivePrimaryTextColor =
        primaryTextColor ?? AppColors.background;
    final Color effectiveSecondaryButtonColor =
        secondaryButtonColor ?? AppColors.background;
    final Color effectiveSecondaryBorderColor =
        secondaryBorderColor ?? AppColors.borderColor;
    final Color effectiveSecondaryTextColor =
        secondaryTextColor ?? AppColors.blackColor;

    // Check: koi button dikhana hai ya nahi
    final bool showPrimary = primaryText != null && primaryText!.isNotEmpty;
    final bool showSecondary = secondaryText != null && secondaryText!.isNotEmpty;

    // Agar dono hi nahi hain, toh empty sized box de do (ya aap yahan null bhi return nahi kar sakte)
    if (!showPrimary && !showSecondary) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: showPrimary && showSecondary ? 130 : 80, // 1 button ho toh thoda chhota
      decoration: BoxDecoration(
        color: effectiveBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: effectiveBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Primary button (agar text diya ho)
          if (showPrimary) ...[
            GestureDetector(
              onTap: onPrimaryTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 44,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: effectivePrimaryButtonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  primaryText!,
                  style: AppTextStyles.dashBordButton1.copyWith(
                    color: effectivePrimaryTextColor,
                  ),
                ),
              ),
            ),
          ],

          // Agar dono buttons hain toh unke beech me space
          if (showPrimary && showSecondary) const SizedBox(height: 12),

          // Secondary button (agar text diya ho)
          if (showSecondary) ...[
            GestureDetector(
              onTap: onSecondaryTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 44,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: effectiveSecondaryBorderColor),
                  color: effectiveSecondaryButtonColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  secondaryText!,
                  style: AppTextStyles.dashBordButton2.copyWith(
                    color: effectiveSecondaryTextColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
