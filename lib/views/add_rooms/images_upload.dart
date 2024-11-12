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
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Upload Room Images',
          style: TextStyle(
            color: Color(0xff1E91B6),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xff1E91B6)),
      ),
      body: Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            const SizedBox(height: 16),
            if (hotelProvider.roomImages.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No images added yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    itemCount: hotelProvider.roomImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      File image = hotelProvider.roomImages[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(
                                image,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.3),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red, size: 20),
                                    onPressed: () {
                                      hotelProvider.removeRoomImage(index);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (hotelProvider.roomImages.isNotEmpty)
                    HotelButton(
                      text: "Continue to Review",
                      onTap: () async {
                        final success = await hotelProvider.uploadRoomImages();
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RoomsSubmissionPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to upload images'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      color: const Color(0xff1E91B6),
                      textColor: Colors.white,
                      borderRadius: 10.0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      height: 50,
                      width: double.infinity,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: hotelProvider.roomImages.length < 10
          ? FloatingActionButton(
              onPressed: () {
                // Show the custom alert dialog using showDialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog(
                      contentText: 'Choose how you want to add images',
                      titleText: 'Add Images',
                      buttonText1: 'Take Photo',
                      buttonText2: 'Choose from Gallery',
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
                );
              },
              backgroundColor: const Color(0xff1E91B6),
              child: const Icon(Icons.add_a_photo),
            )
          : null,
    );
  }
}

  // void _showImagePickerDialog(
  //     BuildContext context, RoomProvider hotelProvider) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CustomAlertDialog(
  //         contentText: 'Choose how you want to add images',
  //         titleText: 'Add Images',
  //         buttonText1: 'Take Photo',
  //         buttonText2: 'Choose from Gallery',
  //         onPressButton1: () async {
  //           await hotelProvider.captureRoomImage();
  //           Navigator.of(context).pop();
  //         },
  //         onPressButton2: () async {
  //           await hotelProvider.pickRoomImages();
  //           Navigator.of(context).pop();
  //         },
  //       );
  //     },
  //   );
  // }

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
               // Container(
            //   padding: const EdgeInsets.all(16),
            //   color: Colors.white,
            //   child: Column(
            //     children: [
            //       const Text(
            //         'Add Photos of Your Room',
            //         style: TextStyle(
            //           fontSize: 24,
            //           fontWeight: FontWeight.bold,
            //           color: Color(0xff1E91B6),
            //         ),
            //       ),
            //       const SizedBox(height: 8),
            //       Text(
            //         'Upload high-quality images to showcase your room (${hotelProvider.roomImages.length}/10)',
            //         style: TextStyle(
            //           fontSize: 14,
            //           color: Colors.grey[600],
            //         ),
            //         textAlign: TextAlign.center,
            //       ),
            //     ],
            //   ),
            // ),
                 // const SizedBox(height: 8),
                      // ElevatedButton.icon(
                      //   onPressed: () =>
                      //       _showImagePickerDialog(context, hotelProvider),
                      //   icon: const Icon(Icons.add_a_photo),
                      //   label: const Text('Add Images'),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: const Color(0xff1E91B6),
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 20, vertical: 12),
                      //   ),
                      // ),