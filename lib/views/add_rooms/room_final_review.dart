import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/rooms_list/rooms_list.dart';
import 'package:provider/provider.dart';

class RoomsSubmissionPage extends StatelessWidget {
  const RoomsSubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);

    final roomdata = roomProvider.roomData;

    final cupboard = roomdata['Cupboard'] ?? false;
    final wardrobe = roomdata['Wardrobe'] ?? false;
    final breakfast = roomdata['Free Breakfast'] ?? false;
    final lunch = roomdata['Free Lunch'] ?? false;
    final dinner = roomdata['Free Dinner'] ?? false;
    final laundry = roomdata['Laundry'] ?? false;
    final elevator = roomdata['Elevator'] ?? false;
    final airConditioner = roomdata['Air Conditioner'] ?? false;
    final houseKeeping = roomdata['House Keeping'] ?? false;
    final kitchen = roomdata['Kitchen'] ?? false;
    final wifi = roomdata['Wifi'] ?? false;
    final parking = roomdata['Parking'] ?? false;

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(title: const Text('Final Review')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Review your details:',
              ),
              const SizedBox(height: 20),
              Text(
                  'room_area: ${roomdata['room_area'] ?? 'Value not provided'}'),
              // Text(
              //     'accomadation_type: ${roomdata['accomadation_type'] ?? 'Value not provided'}'),
              Text(
                  'Property Size: ${roomdata['Property Size'] ?? 'Value not provided'}'),
              Text(
                  'Room type: ${roomdata['room_type'] ?? 'Value not provided'}'),
              Text(
                  'Select Extra Bed Types: ${roomdata['Select Extra Bed Types'] ?? 'Value not provided'}'),
              Text(
                  'Base Price: ${roomdata['Base Price'] ?? 'Value not provided'}'),
              Text(
                  'Number of Extra Adults Allowed: ${roomdata['Number of Extra Adults Allowed'] ?? 'Value not provided'}'),
              Text(
                  'Number of Extra Child Allowed: ${roomdata['Number of Extra Child Allowed'] ?? 'Value not provided'}'),

              Text('cupboard: ${cupboard ? 'Yes' : 'No'}'),
              Text('wardrobe: ${wardrobe ? 'Yes' : 'No'}'),
              // Text('accommodation: ${accommodation ? 'Yes' : 'No'}'),
              Text('breakfast: ${breakfast ? 'Yes' : 'No'}'),
              Text('lunch: ${lunch ? 'Yes' : 'No'}'),
              Text('dinner: ${dinner ? 'Yes' : 'No'}'),
              Text('laundry: ${laundry ? 'Yes' : 'No'}'),
              Text('elevator: ${elevator ? 'Yes' : 'No'}'),
              Text('airConditioner: ${airConditioner ? 'Yes' : 'No'}'),
              Text('houseKeeping: ${houseKeeping ? 'Yes' : 'No'}'),
              Text('kitchen: ${kitchen ? 'Yes' : 'No'}'),
              Text('wifi: ${wifi ? 'Yes' : 'No'}'),
              Text('parking: ${parking ? 'Yes' : 'No'}'),
              const SizedBox(height: 20),
              const Text(
                'Images:',
              ),
              const SizedBox(height: 10),
              Consumer<RoomProvider>(
                builder: (context, provider, child) {
                  return SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        if (provider.isUploading)
                          const CircularProgressIndicator()
                        else if (provider.roomImageUrls.isEmpty)
                          const Text('No images uploaded yet.')
                        else
                          Row(
                            children: provider.roomImageUrls
                                .map((url) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              url,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(Icons.error,
                                                    size: 100);
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Uploaded Image',
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                      ],
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // String? hotelId = roomProvider.hotelId;
                  roomProvider.submitRoom().then((_) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RoomListPage(),
                    ));
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  });
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
