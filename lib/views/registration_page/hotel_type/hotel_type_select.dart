import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/basic_info/basic_information.dart';
import 'package:hotel_side/views/registration_page/hotel_type/chechbox_type.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:hotel_side/widgets/home_page_widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

class HotelTypeSelection extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  HotelTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context, listen: true);
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
          'Property Type',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Indicator
                // const LinearProgressIndicator(
                //   value: 0.2, // 20% progress
                //   backgroundColor: Color(0xFFE0E0E0),
                //   valueColor: AlwaysStoppedAnimation<Color>(Color(0xff1E91B6)),
                // ),
                const SizedBox(height: 32),

                // Main Title and Description
                const Text(
                  'What would you like to list?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Choose the type of property you want to list on our platform.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),

                // Property Type Dropdown
                Container(
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Property Type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomDropdown(
                        hintText: 'Select property type',
                        value: hotelProvider.selectedItem,
                        items: hotelProvider.items,
                        onChanged: (String? newValue) {
                          hotelProvider.setSelectedItem(newValue);
                          hotelProvider.updateHotelData('hotel_type', newValue);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Property Setup Options
                Container(
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Property Setup',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomCheckboxTile(
                        // context: context,
                        title: 'Entire Property',
                        subtitle:
                            'Guests will have the whole place to themselves',
                        value:
                            hotelProvider.hotelData['entire_property'] ?? false,
                        onChanged: (value) {
                          hotelProvider.updateHotelData(
                              'entire_property', value);
                        },
                      ),
                      const Divider(height: 24),
                      CustomCheckboxTile(
                        // context: context,
                        title: 'Private Property',
                        subtitle: 'Guests will have their own private space',
                        value: hotelProvider.hotelData['private_property'] ??
                            false,
                        onChanged: (value) {
                          hotelProvider.updateHotelData(
                              'private_property', value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Next Button
                Center(
                  child: HotelButton(
                    text: "Continue",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (hotelProvider.selectedItem == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a property type'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BasicInformation(),
                        ));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
