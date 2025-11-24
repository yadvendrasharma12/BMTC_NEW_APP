import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../core/app_colors.dart';

class OtpPinField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final int length;
  final StreamController<ErrorAnimationType>? errorController;

  const OtpPinField({
    super.key,
    required this.controller,
    this.onCompleted,
    this.onChanged,
    this.length = 4,
    this.errorController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PinCodeTextField(
        appContext: context,
        length: length,
        controller: controller,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        cursorColor: AppColors.primaryColor,
        errorAnimationController: errorController,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: 62,
          fieldWidth: 62,
          inactiveColor: AppColors.borderColor,
          inactiveFillColor: AppColors.fillColorFB,
          selectedColor: AppColors.primaryColor,
          selectedFillColor: AppColors.fillColorFB,
          activeColor: AppColors.primaryColor,
          activeFillColor: AppColors.fillColorFB,
          borderWidth: 2,
        ),
        animationDuration: const Duration(milliseconds: 200),
        enableActiveFill: true,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        onCompleted: (value) {
          if (onCompleted != null) {
            onCompleted!(value);
          }
        },
      ),
    );
  }
}
