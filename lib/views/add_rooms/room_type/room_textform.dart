import 'package:flutter/material.dart';

class RoomCustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Color primaryColor;
  final Color textColor;

  const RoomCustomFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.onChanged,
    required this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.primaryColor = const Color(0xff1E91B6),
    this.textColor = const Color(0xFF2D3142),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: primaryColor, size: 20)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red.withOpacity(0.5)),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
