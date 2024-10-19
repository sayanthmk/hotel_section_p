// image_upload_screen.dart
import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/datas_page.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/final_review_page/final_review.dart';
import 'package:hotel_side/widgets/home_page_widgets/alert_box.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:provider/provider.dart';

class ImagesUploadingScreen extends StatelessWidget {
  const ImagesUploadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        title: const Text('Upload Images'),
      ),
      body: Consumer<HotelProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: provider.images.isEmpty
                      ? const Center(child: Text('No images selected'))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: provider.images.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.file(provider.images[index],
                                    fit: BoxFit.cover),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        provider.removeImage(index),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
                if (provider.images.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: HotelButton(
                      text: "Next",
                      onTap: provider.isUploading
                          ? null
                          : () async {
                              bool success = await provider.uploadImages();

                              if (success) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const FinalReview(),
                                  ),
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Upload failed. Please try again.')),
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
                      width: 300,
                    ),
                  ),
              ],
            ),
          );
        },
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
              onPressButton1: () {
                Provider.of<HotelProvider>(context, listen: false)
                    .captureImage();
                Navigator.of(context).pop();
              },
              onPressButton2: () {
                Provider.of<HotelProvider>(context, listen: false).pickImages();
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
