import 'package:flutter/material.dart';
import 'package:hotel_side/views/rooms_list/room_detail_view/room_d_feature_row.dart';

class RoomDetailCard extends StatelessWidget {
  const RoomDetailCard({
    super.key,
    required this.roomDetails,
  });

  final Map<String, dynamic> roomDetails;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Room Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: roomDetails['room_images'].isNotEmpty
              ? Image.network(
                  roomDetails['room_images'][0],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 200,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
        ),
        const SizedBox(height: 24.0),

        // Room Details Section
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room Area: ${roomDetails['room_area']}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Property Size: ${roomDetails['Property Size']} sq ft',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Base Price: ₹${roomDetails['Base Price']}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24.0),

        // Features Section
        Text(
          'Features',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16.0),

        // Using the new FeatureRow widget
        FeatureRow(
          feature: 'Cupboard',
          isAvailable: roomDetails['Cupboard'],
          customIcon: Icons.door_sliding,
        ),
        FeatureRow(
          feature: 'Wardrobe',
          isAvailable: roomDetails['Wardrobe'],
          customIcon: Icons.door_front_door,
        ),
        FeatureRow(
          feature: 'Free Breakfast',
          isAvailable: roomDetails['Free Breakfast'],
          customIcon: Icons.breakfast_dining,
        ),
        FeatureRow(
          feature: 'Free Lunch',
          isAvailable: roomDetails['Free Lunch'],
          customIcon: Icons.lunch_dining,
        ),
        FeatureRow(
          feature: 'Free Dinner',
          isAvailable: roomDetails['Free Dinner'],
          customIcon: Icons.dinner_dining,
        ),
        FeatureRow(
          feature: 'Laundry',
          isAvailable: roomDetails['Laundry'],
          customIcon: Icons.local_laundry_service,
        ),
        FeatureRow(
          feature: 'Elevator',
          isAvailable: roomDetails['Elevator'],
          customIcon: Icons.elevator,
        ),
        FeatureRow(
          feature: 'Air Conditioner',
          isAvailable: roomDetails['Air Conditioner'],
          customIcon: Icons.ac_unit,
        ),
        FeatureRow(
          feature: 'House Keeping',
          isAvailable: roomDetails['House Keeping'],
          customIcon: Icons.cleaning_services,
        ),
        FeatureRow(
          feature: 'Kitchen',
          isAvailable: roomDetails['Kitchen'],
          customIcon: Icons.kitchen,
        ),
        FeatureRow(
          feature: 'Wifi',
          isAvailable: roomDetails['Wifi'],
          customIcon: Icons.wifi,
        ),
        FeatureRow(
          feature: 'Parking',
          isAvailable: roomDetails['Parking'],
          customIcon: Icons.local_parking,
        ),

        const SizedBox(height: 24.0),

        // Additional Information Section
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Additional Information',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Extra Bed Types: ${roomDetails['Select Extra Bed Types']}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Extra Adults Allowed: ${roomDetails['Number of Extra Adults Allowed']}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Extra Children Allowed: ${roomDetails['Number of Extra Child Allowed']}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
