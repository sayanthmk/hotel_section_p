import 'package:flutter/material.dart';
import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';

class FinancialInputFields extends StatelessWidget {
  final TextEditingController panNumberController;
  final TextEditingController propertyNumberController;
  final TextEditingController gstNumberController;

  const FinancialInputFields({
    super.key,
    required this.panNumberController,
    required this.propertyNumberController,
    required this.gstNumberController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: panNumberController,
          labelText: 'PAN Number',
          hintText: 'Enter your PAN Number',
          prefixIcon: const Icon(Icons.credit_card, color: Color(0xff1E91B6)),
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'PAN Number is required';
            } else if (value.length != 10) {
              return 'PAN Number must be 10 characters';
            }
            return null;
          },
          borderColor: const Color(0xFFE0E0E0),
          focusedBorderColor: const Color(0xff1E91B6),
          enabledBorderColor: const Color(0xFFE0E0E0),
          errorBorderColor: Colors.red,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: propertyNumberController,
          labelText: 'Property Number',
          hintText: 'Enter your Property Number',
          prefixIcon: const Icon(Icons.home_work, color: Color(0xff1E91B6)),
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Property Number is required';
            } else if (value.length < 4) {
              return 'Property Number must be at least 4 characters';
            }
            return null;
          },
          borderColor: const Color(0xFFE0E0E0),
          focusedBorderColor: const Color(0xff1E91B6),
          enabledBorderColor: const Color(0xFFE0E0E0),
          errorBorderColor: Colors.red,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: gstNumberController,
          labelText: 'GST Number',
          hintText: 'Enter your GST Number',
          prefixIcon: const Icon(Icons.receipt_long, color: Color(0xff1E91B6)),
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'GST Number is required';
            } else if (value.length != 15) {
              return 'GST Number must be 15 characters';
            }
            return null;
          },
          borderColor: const Color(0xFFE0E0E0),
          focusedBorderColor: const Color(0xff1E91B6),
          enabledBorderColor: const Color(0xFFE0E0E0),
          errorBorderColor: Colors.red,
        ),
      ],
    );
  }
}
