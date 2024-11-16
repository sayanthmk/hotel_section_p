import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:provider/provider.dart';

class RoomEditingPage extends StatelessWidget {
  const RoomEditingPage({super.key, required this.roomDetails});
  final Map<String, dynamic> roomDetails;

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);

    // Initialize controllers with existing data
    final TextEditingController roomAreaController =
        TextEditingController(text: roomDetails['room_area']?.toString() ?? '');
    final TextEditingController propertySizeController = TextEditingController(
        text: roomDetails['Property Size']?.toString() ?? '');
    final TextEditingController extraBedTypeController = TextEditingController(
        text: roomDetails['Select Extra Bed Types']?.toString() ?? '');
    final TextEditingController basePriceController = TextEditingController(
        text: roomDetails['Base Price']?.toString() ?? '');
    final TextEditingController extraAdultsController = TextEditingController(
        text: roomDetails['Number of Extra Adults Allowed']?.toString() ?? '');
    final TextEditingController extraChildrenController = TextEditingController(
        text: roomDetails['Number of Extra Child Allowed']?.toString() ?? '');
    final TextEditingController roomTypeController =
        TextEditingController(text: roomDetails['room_type']?.toString() ?? '');

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Room Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Room Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: roomAreaController,
              decoration: const InputDecoration(
                labelText: 'Room Area (sq ft)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: propertySizeController,
              decoration: const InputDecoration(
                labelText: 'Property Size',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: extraBedTypeController,
              decoration: const InputDecoration(
                labelText: 'Extra Bed Types',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: basePriceController,
              decoration: const InputDecoration(
                labelText: 'Base Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: extraAdultsController,
              decoration: const InputDecoration(
                labelText: 'Number of Extra Adults Allowed',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: extraChildrenController,
              decoration: const InputDecoration(
                labelText: 'Number of Extra Children Allowed',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: roomTypeController,
              decoration: const InputDecoration(
                labelText: 'Room Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Boolean fields using SwitchListTile
            ...[
              'Accommodation Only',
              'Air Conditioner',
              'Cupboard',
              'Elevator',
              'Free Breakfast',
              'Free Dinner',
              'Free Lunch',
              'House Keeping',
              'Kitchen',
              'Laundry',
              'Parking',
              'Wardrobe',
              'Wifi',
            ].map((key) => SwitchListTile(
                  title: Text(key),
                  value: roomDetails[key] ?? false,
                  onChanged: (value) {
                    roomProvider.updateRoomData(key, value);
                  },
                )),
            const SizedBox(height: 16),
            const Text(
              'Room Images:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Display room images if available
            roomDetails['room_images'] != null
                ? Wrap(
                    spacing: 8,
                    children: List<Widget>.from(
                      roomDetails['room_images'].map<Widget>((imageUrl) {
                        return Image.network(
                          imageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        );
                      }),
                    ),
                  )
                : const Text('No images available'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Prepare the updated data
                  Map<String, dynamic> updatedData = {
                    'room_area': int.tryParse(roomAreaController.text) ?? 0,
                    'Property Size':
                        int.tryParse(propertySizeController.text) ?? 0,
                    'Select Extra Bed Types':
                        int.tryParse(extraBedTypeController.text) ?? 0,
                    'Base Price': int.tryParse(basePriceController.text) ?? 0,
                    'Number of Extra Adults Allowed':
                        int.tryParse(extraAdultsController.text) ?? 0,
                    'Number of Extra Child Allowed':
                        int.tryParse(extraChildrenController.text) ?? 0,
                    'room_type': roomTypeController.text,
                  };

                  // Add boolean fields to the updated data
                  [
                    'Accommodation Only',
                    'Air Conditioner',
                    'Cupboard',
                    'Elevator',
                    'Free Breakfast',
                    'Free Dinner',
                    'Free Lunch',
                    'House Keeping',
                    'Kitchen',
                    'Laundry',
                    'Parking',
                    'Wardrobe',
                    'Wifi',
                  ].forEach((key) {
                    updatedData[key] = roomDetails[key] ?? false;
                  });

                  // Call the updateRoom function
                  await roomProvider.updateRoom(
                      roomDetails['room_id'], updatedData);

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Room details updated successfully!')),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Failed to update room: ${e.toString()}')),
                  );
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
