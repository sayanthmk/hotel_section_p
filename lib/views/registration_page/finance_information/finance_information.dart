import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/finance_information/widgets/document_upload.dart';
import 'package:hotel_side/views/registration_page/finance_information/widgets/finace_input_field.dart';
import 'package:hotel_side/views/registration_page/finance_information/widgets/finance_card.dart';
import 'package:hotel_side/views/registration_page/finance_information/widgets/radio_section.dart';
import 'package:hotel_side/views/registration_page/finance_information/widgets/section_tile.dart';
import 'package:hotel_side/views/registration_page/images_page/images.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
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
                  // const ProgressBar(),
                  const SizedBox(height: 32),
                  const FinanceSectionTitle(
                    title: 'Finance & Legal Information',
                    subtitle:
                        'Please provide your business identification details',
                  ),
                  const SizedBox(height: 24),
                  FinanceCardContainer(
                    children: [
                      FinancialInputFields(
                        panNumberController: panNumberController,
                        propertyNumberController: propertyNumberController,
                        gstNumberController: gstNumberController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const FinanceSectionTitle(
                    title: 'Property Information',
                    subtitle: 'Tell us about your property ownership status',
                  ),
                  const SizedBox(height: 24),
                  FinanceCardContainer(
                    children: [
                      FinanceRadioSection(
                        title: 'Is your property owned or leased?',
                        groupValue: hotelProvider.hotelData['leased'] ?? false,
                        onChanged: (value) =>
                            hotelProvider.updateHotelData('leased', value),
                        textYes: 'Owned',
                        textNo: 'Leased',
                      ),
                      const Divider(height: 32),
                      FinanceRadioSection(
                        title: 'Do you have registration?',
                        groupValue:
                            hotelProvider.hotelData['registartion'] ?? false,
                        onChanged: (value) => hotelProvider.updateHotelData(
                            'registartion', value),
                        textYes: 'Yes',
                        textNo: 'No',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const DocumentUploadSection(),
                  const SizedBox(height: 32),
                  Center(
                    child: HotelButton(
                      text: "Continue to Images",
                      // onTap: () => _handleSubmit(context, hotelProvider),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          hotelProvider.updateHotelData(
                              'pan_number', panNumberController.text);
                          hotelProvider.updateHotelData(
                              'property_number', propertyNumberController.text);
                          hotelProvider.updateHotelData(
                              'gst_number', gstNumberController.text);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ImagesUploadingScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please fill all required fields correctly'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },

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
}
// Section Title Widget


// Card Container Widget


// Radio Section Widget


// Financial Input Fields Widget


// Progress Bar Widget
// class ProgressBar extends StatelessWidget {
//   const ProgressBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const LinearProgressIndicator(
//       value: 0.8, // 80% progress
//       backgroundColor: Color(0xFFE0E0E0),
//       valueColor: AlwaysStoppedAnimation<Color>(Color(0xff1E91B6)),
//     );
//   }
// }

// Main Screen Widget
  //                       void _handleSubmit(BuildContext context, HotelProvider hotelProvider) {
  //   if (_formKey.currentState!.validate()) {
  //     hotelProvider.updateHotelData('pan_number', panNumberController.text);
  //     hotelProvider.updateHotelData(
  //         'property_number', propertyNumberController.text);
  //     hotelProvider.updateHotelData('gst_number', gstNumberController.text);

  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => const ImagesUploadingScreen(),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please fill all required fields correctly'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }