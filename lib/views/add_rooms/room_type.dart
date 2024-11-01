// custom_section.dart
import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_facilities.dart';
import 'package:hotel_side/widgets/home_page_widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

class CustomSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color textColor;

  const CustomSection({
    super.key,
    required this.title,
    required this.children,
    this.textColor = const Color(0xFF2D3142),
  });

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
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

// custom_form_field.dart
class CustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Color primaryColor;
  final Color textColor;

  const CustomFormField({
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

// custom_continue_button.dart
class CustomContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color primaryColor;

  const CustomContinueButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.primaryColor = const Color(0xff1E91B6),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

// room_type_selection.dart
class RoomTypeSelection extends StatelessWidget {
  RoomTypeSelection({super.key});

  final _formKey = GlobalKey<FormState>();
  final Color primaryBlue = const Color(0xff1E91B6);
  final Color textColor = const Color(0xFF2D3142);

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryBlue,
        title: const Text(
          'Add Room Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryBlue.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomSection(
                    title: 'Basic Information',
                    textColor: textColor,
                    children: [
                      CustomDropdown(
                        hintText: 'Select room type',
                        value: roomProvider.roomsSelectedItem,
                        items: roomProvider.roomsItems,
                        onChanged: (String? newValue) {
                          roomProvider.setRoomSelectedItem(newValue);
                          roomProvider.updateRoomData('room_type', newValue);
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        label: 'Room Area',
                        hint: 'Enter room area',
                        onChanged: (value) {
                          roomProvider.updateRoomData('room_area', value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Room area is required';
                          }
                          return null;
                        },
                        prefixIcon: Icons.square_foot,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        label: 'Room Size',
                        hint: 'Enter room size in sq. ft',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          roomProvider.updateRoomData(
                              'Property Size', int.tryParse(value));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Room size is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        prefixIcon: Icons.architecture,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomSection(
                    title: 'Capacity & Pricing',
                    textColor: textColor,
                    children: [
                      CustomFormField(
                        label: 'Extra Adults',
                        hint: 'Enter number of extra adults allowed',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          roomProvider.updateRoomData(
                            'Number of Extra Adults Allowed',
                            int.tryParse(value),
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Extra adults count is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        prefixIcon: Icons.person_add,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        label: 'Extra Children',
                        hint: 'Enter number of extra children allowed',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          roomProvider.updateRoomData(
                            'Number of Extra Child Allowed',
                            int.tryParse(value),
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Extra children count is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        prefixIcon: Icons.child_care,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        label: 'Base Price',
                        hint: 'Enter base price',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          roomProvider.updateRoomData(
                              'Base Price', int.tryParse(value));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Base price is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        prefixIcon: Icons.attach_money,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomContinueButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => RoomFacility()),
                        );
                      }
                    },
                    text: 'Continue to Facilities',
                    primaryColor: primaryBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
