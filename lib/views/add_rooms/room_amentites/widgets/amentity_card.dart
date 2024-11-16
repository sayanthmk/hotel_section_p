import 'package:flutter/material.dart';

class AmenityCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color primaryColor;
  final Color secondaryColor;

  const AmenityCard({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value ? primaryColor : Colors.grey.shade300,
            width: 2,
          ),
          color: value ? secondaryColor : Colors.white,
          boxShadow: value
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: InkWell(
          onTap: () => onChanged(!value),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: value ? primaryColor : Colors.grey.shade600,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: value ? FontWeight.w600 : FontWeight.normal,
                      color: value ? primaryColor : const Color(0xFF2C3E50),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 0.9,
                  child: Checkbox(
                    value: value,
                    onChanged: onChanged,
                    activeColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
