
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hintText;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
    this.borderRadius = 10,
    this.fillColor,
    this.borderColor, required String? Function(dynamic value) validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: fillColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? theme.primaryColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(
            hintText,
            style: GoogleFonts.karla(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 35,
            color: Colors.black,
          ),
          style: GoogleFonts.karla(
            fontSize: 14,
            color: Colors.black,
          ),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
