import 'package:flutter/material.dart';
import 'package:hotel_side/views/registration_page/basic_info/section_header.dart';
import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';

class BasicInfoFormSection extends StatelessWidget {
  const BasicInfoFormSection({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.hotelNameController,
    required this.bookingSinceController,
    required this.contactNumberController,
    required this.emailAddressController,
    required this.basePriceController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController hotelNameController;
  final TextEditingController bookingSinceController;
  final TextEditingController contactNumberController;
  final TextEditingController emailAddressController;
  final TextEditingController basePriceController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SectionHeader(
                  title: 'Basic Information',
                  icon: Icons.hotel,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: basePriceController,
                          labelText: 'Base Price',
                          hintText: 'Enter the base price',
                          prefixIcon: const Icon(Icons.business),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Base price is required';
                            }
                            return null;
                          },
                          borderColor: Colors.grey.shade300,
                          focusedBorderColor: const Color(0xff1E91B6),
                          enabledBorderColor: Colors.grey.shade300,
                          errorBorderColor: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: hotelNameController,
                          labelText: 'Stay/Hotel Name',
                          hintText: 'Enter your Hotel Name',
                          prefixIcon: const Icon(Icons.business),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Hotel Name is required';
                            }
                            return null;
                          },
                          borderColor: Colors.grey.shade300,
                          focusedBorderColor: const Color(0xff1E91B6),
                          enabledBorderColor: Colors.grey.shade300,
                          errorBorderColor: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: bookingSinceController,
                          labelText: 'Taking Booking Since',
                          hintText: 'Enter Year (e.g., 2020)',
                          prefixIcon: const Icon(Icons.calendar_today),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Year is required';
                            } else if (value.length != 4) {
                              return 'Please enter a valid year';
                            }
                            return null;
                          },
                          borderColor: Colors.grey.shade300,
                          focusedBorderColor: const Color(0xff1E91B6),
                          enabledBorderColor: Colors.grey.shade300,
                          errorBorderColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const SectionHeader(
                    title: 'Contact Details', icon: Icons.contact_phone),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: contactNumberController,
                          labelText: 'Contact Number',
                          hintText: 'Enter your Contact Number',
                          prefixIcon: const Icon(Icons.phone),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Contact Number is required';
                            } else if (value.length < 10) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          borderColor: Colors.grey.shade300,
                          focusedBorderColor: const Color(0xff1E91B6),
                          enabledBorderColor: Colors.grey.shade300,
                          errorBorderColor: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: emailAddressController,
                          labelText: 'Email Address',
                          hintText: 'Enter your Email Address',
                          prefixIcon: const Icon(Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,7}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          borderColor: Colors.grey.shade300,
                          focusedBorderColor: const Color(0xff1E91B6),
                          enabledBorderColor: Colors.grey.shade300,
                          errorBorderColor: Colors.red,
                        ),
                      ],
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
