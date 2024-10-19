import 'package:flutter/material.dart';

class RoomDetailPage extends StatelessWidget {
  final Map<String, dynamic> roomDetails;

  const RoomDetailPage({super.key, required this.roomDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            roomDetails['images'].isNotEmpty
                ? Image.network(
                    roomDetails['images'][0],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey,
                    child: const Icon(Icons.image, size: 50),
                  ),
            const SizedBox(height: 16.0),
            Text(
              'Room Area: ${roomDetails['room_area']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Accommodation Type: ${roomDetails['accomadation_type']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Property Size: ${roomDetails['Property Size']} sq ft',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Base Price: ₹${roomDetails['Base Price']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Features:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildFeatureRow('Cupboard', roomDetails['Cupboard']),
            _buildFeatureRow('Wardrobe', roomDetails['Wardrobe']),
            _buildFeatureRow('Free Breakfast', roomDetails['Free Breakfast']),
            _buildFeatureRow('Free Lunch', roomDetails['Free Lunch']),
            _buildFeatureRow('Free Dinner', roomDetails['Free Dinner']),
            _buildFeatureRow('Laundry', roomDetails['Laundry']),
            _buildFeatureRow('Elevator', roomDetails['Elevator']),
            _buildFeatureRow('Air Conditioner', roomDetails['Air Conditioner']),
            _buildFeatureRow('House Keeping', roomDetails['House Keeping']),
            _buildFeatureRow('Kitchen', roomDetails['Kitchen']),
            _buildFeatureRow('Wifi', roomDetails['Wifi']),
            _buildFeatureRow('Parking', roomDetails['Parking']),
            const SizedBox(height: 16.0),
            Text(
              'Extra Bed Types: ${roomDetails['Select Extra Bed Types']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Number of Extra Adults Allowed: ${roomDetails['Number of Extra Adults Allowed']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Number of Extra Child Allowed: ${roomDetails['Number of Extra Child Allowed']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String feature, bool isAvailable) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(feature, style: const TextStyle(fontSize: 18)),
        Icon(
          isAvailable ? Icons.check_circle : Icons.cancel,
          color: isAvailable ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
