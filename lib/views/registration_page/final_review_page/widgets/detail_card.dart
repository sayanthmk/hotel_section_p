import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/final_review_page/widgets/build_section_tile.dart';
import 'package:hotel_side/views/registration_page/final_review_page/widgets/faciltity_chip.dart';
import 'package:hotel_side/views/registration_page/final_review_page/widgets/image_tile.dart';
import 'package:hotel_side/views/registration_page/final_review_page/widgets/info_card.dart';
import 'package:provider/provider.dart';

class DetailFinalReviewCard extends StatelessWidget {
  const DetailFinalReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);
    final hotelData = hotelProvider.hotelData;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildSectionTitle('Basic Information'),
            const SectionTitle(title: 'Basic Information'),
            InfoCard(
              title: 'Hotel Type',
              value: hotelData['hotel_type'],
            ),
            // _buildInfoCard('Hotel Type', hotelData['hotel_type']),

            InfoCard(
              title: 'Property Setup',
              value: hotelData['property_setup'],
            ),
            InfoCard(
              title: 'Hotel Name',
              value: hotelData['hotel_name'],
            ),

            InfoCard(
              title: 'Booking Since',
              value: hotelData['Booking_since'],
            ),
            const SectionTitle(title: 'Contact Details'),
            InfoCard(
              title: 'contact_number',
              value: hotelData['contact_number'],
            ),
            InfoCard(
              title: 'email_address',
              value: hotelData['email_address'],
            ),
            const SectionTitle(title: 'Location'),
            InfoCard(
              title: 'City',
              value: hotelData['city'],
            ),
            InfoCard(
              title: 'State',
              value: hotelData['state'],
            ),
            InfoCard(
              title: 'Country',
              value: hotelData['country'],
            ),
            InfoCard(
              title: 'Pincode',
              value: hotelData['pincode'],
            ),

            const SectionTitle(title: 'Legal Information'),
            InfoCard(
              title: 'PAN number',
              value: hotelData['pan_number'],
            ),
            InfoCard(
              title: 'Property Number',
              value: hotelData['property_number'],
            ),
            InfoCard(
              title: 'GST Number',
              value: hotelData['gst_number'],
            ),

            const SectionTitle(title: 'Facilities & Features'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FacilityChip(
                  title: 'Leased',
                  value: hotelData['leased'] ?? false,
                ),
                FacilityChip(
                  title: 'Registered',
                  value: hotelData['registartion'] ?? false,
                ),
                FacilityChip(
                  title: 'Free Cancellation',
                  value: hotelData['free_cancel'] ?? false,
                ),
                FacilityChip(
                  title: 'Couple Friendly',
                  value: hotelData['couple_friendly'] ?? false,
                ),
                FacilityChip(
                  title: 'Parking Available',
                  value: hotelData['parking_facility'] ?? false,
                ),
                FacilityChip(
                  title: 'Restaurant',
                  value: hotelData['restaurant_facility'] ?? false,
                ),
              ],
            ),
            // _buildSectionTitle('Hotel Images'),
            const SectionTitle(title: 'Hotel Images'),
            const ImageListView(),
          ],
        ),
      ),
    );
  }
}
             // _buildFacilityChip(
                //     'Leased', hotelData['leased'] ?? false),
                // _buildFacilityChip(
                //     'Registered', hotelData['registartion'] ?? false),
                // _buildFacilityChip('Free Cancellation',
                //     hotelData['free_cancel'] ?? false),
                // _buildFacilityChip('Couple Friendly',
                //     hotelData['couple_friendly'] ?? false),
                // _buildFacilityChip('Parking Available',
                //     hotelData['parking_facility'] ?? false),
                // _buildFacilityChip('Restaurant',
                //     hotelData['restaurant_facility'] ?? false),
                            // _buildInfoCard('PAN Number', hotelData['pan_number']),
            // _buildInfoCard(
            //     'Property Number', hotelData['property_number']),
            // _buildInfoCard('GST Number', hotelData['gst_number']),
            // _buildSectionTitle('Facilities & Features'),