import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:hotel_side/views/rooms_list/room_detail_view/room_d_feature_row.dart';
import 'package:hotel_side/views/rooms_list/room_detail_view/widgets/roominfodetailcard.dart';
import 'package:provider/provider.dart';

class RoomDetailCard extends StatelessWidget {
  const RoomDetailCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(builder: (context, provider, child) {
      final roomDetails = provider.selectedRoom;

      if (roomDetails == null) {
        // Fallback UI if roomDetails is null
        return Center(
          child: Text(
            'No room details available',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }

      return ListView(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: roomDetails['room_images'] != null &&
                    roomDetails['room_images'].isNotEmpty
                ? Image.network(
                    roomDetails['room_images'][0],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey.shade200,
                    child:
                        const Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
          ),
          const SizedBox(height: 24.0),
          RoomInfoDetailCard(roomDetails: roomDetails),
          const SizedBox(height: 24.0),
          Text(
            'Features',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16.0),
          FeatureRow(
            feature: 'Cupboard',
            isAvailable: roomDetails['Cupboard'] ?? false,
            customIcon: Icons.door_sliding,
          ),
          FeatureRow(
            feature: 'Wardrobe',
            isAvailable: roomDetails['Wardrobe'] ?? false,
            customIcon: Icons.door_front_door,
          ),
          FeatureRow(
            feature: 'Free Breakfast',
            isAvailable: roomDetails['Free Breakfast'] ?? false,
            customIcon: Icons.breakfast_dining,
          ),
          FeatureRow(
            feature: 'Free Lunch',
            isAvailable: roomDetails['Free Lunch'] ?? false,
            customIcon: Icons.lunch_dining,
          ),
          FeatureRow(
            feature: 'Free Dinner',
            isAvailable: roomDetails['Free Dinner'] ?? false,
            customIcon: Icons.dinner_dining,
          ),
          FeatureRow(
            feature: 'Laundry',
            isAvailable: roomDetails['Laundry'] ?? false,
            customIcon: Icons.local_laundry_service,
          ),
          FeatureRow(
            feature: 'Elevator',
            isAvailable: roomDetails['Elevator'] ?? false,
            customIcon: Icons.elevator,
          ),
          FeatureRow(
            feature: 'Air Conditioner',
            isAvailable: roomDetails['Air Conditioner'] ?? false,
            customIcon: Icons.ac_unit,
          ),
          FeatureRow(
            feature: 'House Keeping',
            isAvailable: roomDetails['House Keeping'] ?? false,
            customIcon: Icons.cleaning_services,
          ),
          FeatureRow(
            feature: 'Kitchen',
            isAvailable: roomDetails['Kitchen'] ?? false,
            customIcon: Icons.kitchen,
          ),
          FeatureRow(
            feature: 'Wifi',
            isAvailable: roomDetails['Wifi'] ?? false,
            customIcon: Icons.wifi,
          ),
          FeatureRow(
            feature: 'Parking',
            isAvailable: roomDetails['Parking'] ?? false,
            customIcon: Icons.local_parking,
          ),
          const SizedBox(height: 24.0),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).cardColor,
                    Theme.of(context).cardColor.withOpacity(0.9),
                  ],
                ),
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
          ),
          const SizedBox(height: 24.0),
        ],
      );
    });
  }
}
