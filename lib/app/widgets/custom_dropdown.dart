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

  // 👇 OPTIONAL validator
  final String? Function(T?)? validator;

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
    this.borderColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormField<T>(
      validator: validator, // 👈 null allowed
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 47,
              padding: padding,
              decoration: BoxDecoration(
                color: fillColor ?? Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: state.hasError
                      ? Colors.red
                      : (borderColor ??
                      theme.primaryColor.withOpacity(0.5)),
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
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 26,
                    color: Colors.black,
                  ),
                  style: GoogleFonts.karla(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (val) {
                    state.didChange(val); // 🔥 IMPORTANT
                    onChanged(val);
                  },
                  items: items.map((item) {
                    final isSelected = item == value;
                    return DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        itemLabel(item),
                        style: GoogleFonts.karla(
                          fontSize: 14,
                          color:
                          isSelected ? Colors.black : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // ❌ Error text only when validator fails
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 8),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
