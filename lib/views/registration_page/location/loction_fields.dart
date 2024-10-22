import 'package:flutter/material.dart';
import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';

class LocationField extends StatelessWidget {
  const LocationField({
    super.key,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    required this.pincodeController,
  });

  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController pincodeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // City Field
          const Text(
            'City',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: cityController,
            labelText: 'Enter your city',
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'City is required';
              }
              return null;
            },
            prefixIcon: const Icon(
              Icons.location_city,
              color: Color(0xff1E91B6),
              size: 20,
            ),
            borderColor: Colors.grey.withOpacity(0.2),
            focusedBorderColor: const Color(0xff1E91B6),
            enabledBorderColor: Colors.grey.withOpacity(0.2),
            errorBorderColor: Colors.red.withOpacity(0.5),
            // backgroundColor: Colors.grey.withOpacity(0.05),
          ),
          const SizedBox(height: 20),

          // State Field
          const Text(
            'State',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: stateController,
            labelText: 'Enter your state',
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'State is required';
              }
              return null;
            },
            prefixIcon: const Icon(
              Icons.map,
              color: Color(0xff1E91B6),
              size: 20,
            ),
            borderColor: Colors.grey.withOpacity(0.2),
            focusedBorderColor: const Color(0xff1E91B6),
            enabledBorderColor: Colors.grey.withOpacity(0.2),
            errorBorderColor: Colors.red.withOpacity(0.5),
            // backgroundColor: Colors.grey.withOpacity(0.05),
          ),
          const SizedBox(height: 20),

          // Country Field
          const Text(
            'Country',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: countryController,
            labelText: 'Enter your country',
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Country is required';
              }
              return null;
            },
            prefixIcon: const Icon(
              Icons.public,
              color: Color(0xff1E91B6),
              size: 20,
            ),
            borderColor: Colors.grey.withOpacity(0.2),
            focusedBorderColor: const Color(0xff1E91B6),
            enabledBorderColor: Colors.grey.withOpacity(0.2),
            errorBorderColor: Colors.red.withOpacity(0.5),
            // backgroundColor: Colors.grey.withOpacity(0.05),
          ),
          const SizedBox(height: 20),

          // Pincode Field
          const Text(
            'Pincode',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: pincodeController,
            labelText: 'Enter your pincode',
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pincode is required';
              }
              if (value.length != 6) {
                return 'Please enter a valid pincode';
              }
              return null;
            },
            prefixIcon: const Icon(
              Icons.pin_drop,
              color: Color(0xff1E91B6),
              size: 20,
            ),
            borderColor: Colors.grey.withOpacity(0.2),
            focusedBorderColor: const Color(0xff1E91B6),
            enabledBorderColor: Colors.grey.withOpacity(0.2),
            errorBorderColor: Colors.red.withOpacity(0.5),
            // backgroundColor: Colors.grey.withOpacity(0.05),
          ),
        ],
      ),
    );
  }
}
