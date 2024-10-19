import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/images.dart';
import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:hotel_side/widgets/home_page_widgets/radio_button.dart';
import 'package:provider/provider.dart';

class FinanceInformation extends StatelessWidget {
  final TextEditingController panNumberController = TextEditingController();
  final TextEditingController propertyNumberController =
      TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FinanceInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff1E91B6)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Financial Details',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Indicator
                  const LinearProgressIndicator(
                    value: 0.8, // 80% progress
                    backgroundColor: Color(0xFFE0E0E0),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff1E91B6)),
                  ),
                  const SizedBox(height: 32),

                  // Finance Section
                  _buildSectionTitle(
                    'Finance & Legal Information',
                    'Please provide your business identification details',
                  ),
                  const SizedBox(height: 24),

                  _buildInputCard([
                    CustomTextFormField(
                      controller: panNumberController,
                      labelText: 'PAN Number',
                      hintText: 'Enter your PAN Number',
                      prefixIcon: const Icon(Icons.credit_card,
                          color: Color(0xff1E91B6)),
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
                      prefixIcon:
                          const Icon(Icons.home_work, color: Color(0xff1E91B6)),
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
                      prefixIcon: const Icon(Icons.receipt_long,
                          color: Color(0xff1E91B6)),
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
                  ]),
                  const SizedBox(height: 32),

                  // Property Information Section
                  _buildSectionTitle(
                    'Property Information',
                    'Tell us about your property ownership status',
                  ),
                  const SizedBox(height: 24),

                  _buildInputCard([
                    _buildRadioSection(
                      'Is your property owned or leased?',
                      hotelProvider.hotelData['leased'] ?? false,
                      (value) => hotelProvider.updateHotelData('leased', value),
                      'Owned',
                      'Leased',
                    ),
                    const Divider(height: 32),
                    _buildRadioSection(
                      'Do you have registration?',
                      hotelProvider.hotelData['registartion'] ?? false,
                      (value) =>
                          hotelProvider.updateHotelData('registartion', value),
                      'Yes',
                      'No',
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Document Upload Section
                  _buildDocumentUploadSection(),
                  const SizedBox(height: 32),

                  // Next Button
                  Center(
                    child: HotelButton(
                      text: "Continue to Images",
                      onTap: () => _handleSubmit(context, hotelProvider),
                      color: const Color(0xff1E91B6),
                      textColor: Colors.white,
                      borderRadius: 12.0,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      height: 56,
                      width: screenSize.width * 0.85,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildInputCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildRadioSection(
    String title,
    bool groupValue,
    Function(bool?) onChanged,
    String textYes,
    String textNo,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        CustomRadioButton(
          groupValue: groupValue,
          onChanged: onChanged,
          textYes: textYes,
          textNo: textNo,
        ),
      ],
    );
  }

  Widget _buildDocumentUploadSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upload Documents',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file,
                    size: 48,
                    color: const Color(0xff1E91B6).withOpacity(0.7),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Drag and drop or click to upload',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Supported formats: PDF, JPG, PNG',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit(BuildContext context, HotelProvider hotelProvider) {
    if (_formKey.currentState!.validate()) {
      hotelProvider.updateHotelData('pan_number', panNumberController.text);
      hotelProvider.updateHotelData(
          'property_number', propertyNumberController.text);
      hotelProvider.updateHotelData('gst_number', gstNumberController.text);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ImagesUploadingScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
