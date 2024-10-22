import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_final_review.dart';
import 'package:hotel_side/widgets/home_page_widgets/alert_box.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:provider/provider.dart';

class RoomImageUploadPage extends StatelessWidget {
  const RoomImageUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<RoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Room Images'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: hotelProvider.roomImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                File image = hotelProvider.roomImages[index];
                return Stack(
                  children: [
                    Image.file(image, fit: BoxFit.cover),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          hotelProvider
                              .removeRoomImage(index); // Remove selected image
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HotelButton(
              text: "Next",
              onTap: () async {
                final success = await hotelProvider.uploadRoomImages();
                if (success) {
                  // If images uploaded successfully, submit the room data
                  // await hotelProvider.submitRoom();
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Room added successfully!')),
                  // );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoomsSubmissionPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to upload images')),
                  );
                }
              },
              color: const Color(0xff1E91B6),
              textColor: Colors.white,
              borderRadius: 10.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              height: 50,
              width: 300,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            // return const CustomImageSourceDialog();
            return CustomAlertDialog(
              contentText: 'Pick a image',
              titleText: 'Choose Image',
              buttonText1: 'Camera',
              buttonText2: 'Gallery',
              onPressButton1: () async {
                await hotelProvider.captureRoomImage();
                Navigator.of(context).pop();
              },
              onPressButton2: () async {
                await hotelProvider.pickRoomImages();

                Navigator.of(context).pop();
              },
            );
          },
        ),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
    // Pick Image from Gallery
          // ElevatedButton(
          //   onPressed: () async {
          //     await hotelProvider.pickRoomImages(); // Picks multiple images
          //   },
          //   child: const Text('Pick Room Images from Gallery'),
          // ),
          // const SizedBox(height: 10),
          // // Capture Image from Camera
          // ElevatedButton(
          //   onPressed: () async {
          //     await hotelProvider
          //         .captureRoomImage(); // Captures image from camera
          //   },
          //   child: const Text('Capture Room Image with Camera'),
          // ),
               // ElevatedButton(
          //   onPressed: () async {
          //     final success = await hotelProvider.uploadRoomImages();
          //     if (success) {
          //       // If images uploaded successfully, submit the room data
          //       // await hotelProvider.submitRoom();
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('Room added successfully!')),
          //       );
          //       Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => RoomsSubmissionPage()),
          //       );
          //     } else {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('Failed to upload images')),
          //       );
          //     }
          //   },
          //   child: hotelProvider.isRoomUploading
          //       ? const CircularProgressIndicator(color: Colors.white)
          //       : const Text('Submit Images'),
          // ),