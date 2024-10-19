// main.dart
// (No changes to main.dart)

// image_upload_provider.dart
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class ImageUploadProvider with ChangeNotifier {
//   List<File> _images = [];
//   List<String> _imageUrls = [];
//   bool _isUploading = false;

//   List<File> get images => _images;
//   List<String> get imageUrls => _imageUrls;
//   bool get isUploading => _isUploading;

//   Future<void> pickImages() async {
//     final pickedFiles = await ImagePicker().pickMultiImage();
//     if (pickedFiles.isNotEmpty) {
//       _images.addAll(pickedFiles.map((file) => File(file.path)));
//       notifyListeners();
//     }
//   }

//   Future<void> captureImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _images.add(File(pickedFile.path));
//       notifyListeners();
//     }
//   }

//   Future<void> uploadImages() async {
//     if (_images.isEmpty) return;

//     _isUploading = true;
//     _imageUrls.clear();
//     notifyListeners();

//     try {
//       for (var image in _images) {
//         final ref = FirebaseStorage.instance
//             .ref()
//             .child('images/${DateTime.now().toString()}');
//         final uploadTask = ref.putFile(image);
//         final snapshot = await uploadTask.whenComplete(() {});
//         final url = await snapshot.ref.getDownloadURL();
//         _imageUrls.add(url);
//       }
//       _isUploading = false;
//       _images.clear(); // Clear the list after successful upload
//       notifyListeners();
//     } catch (e) {
//       print('Error uploading images: $e');
//       _isUploading = false;
//       notifyListeners();
//     }
//   }

//   void removeImage(int index) {
//     if (index >= 0 && index < _images.length) {
//       _images.removeAt(index);
//       notifyListeners();
//     }
//   }
// }

// image_upload_screen.dart

// class ImageUploadScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Multiple Image Upload'),
//       ),
//       body: Consumer<ImageUploadProvider>(
//         builder: (context, provider, child) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Expanded(
//                   child: provider.images.isEmpty
//                       ? Center(child: Text('No images selected'))
//                       : GridView.builder(
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 8,
//                             mainAxisSpacing: 8,
//                           ),
//                           itemCount: provider.images.length,
//                           itemBuilder: (context, index) {
//                             return Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 Image.file(provider.images[index],
//                                     fit: BoxFit.cover),
//                                 Positioned(
//                                   right: 0,
//                                   top: 0,
//                                   child: IconButton(
//                                     icon: Icon(Icons.remove_circle,
//                                         color: Colors.red),
//                                     onPressed: () =>
//                                         provider.removeImage(index),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: provider.pickImages,
//                       child: Text('Pick Images'),
//                     ),
//                     ElevatedButton(
//                       onPressed: provider.captureImage,
//                       child: Text('Take Photo'),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed:
//                       provider.isUploading ? null : provider.uploadImages,
//                   child: Text('Upload Images'),
//                 ),
//                 SizedBox(height: 16),
//                 if (provider.isUploading)
//                   Center(child: CircularProgressIndicator())
//                 else if (provider.imageUrls.isNotEmpty)
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: provider.imageUrls.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text('Image ${index + 1}'),
//                           subtitle: Text(provider.imageUrls[index]),
//                         );
//                       },
//                     ),
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
   // TextFormField(
                        //   controller: panNumberController,
                        //   decoration: const InputDecoration(labelText: 'PAN Number'),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter PAN number';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        // Property Number Field
                        // TextFormField(
                        //   controller: propertyNumberController,
                        //   decoration: const InputDecoration(labelText: 'Property Number'),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter property number';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        // GST Number Field
                        // TextFormField(
                        //   controller: gstNumberController,
                        //   decoration: const InputDecoration(labelText: 'GST Number'),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter GST number';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        // Leased Checkbox
                        // Row(
                        //   children: [
                        //     const Text('Leased: '),
                        //     Radio<bool>(
                        //       value: true, // Value for 'leased' being true
                        //       groupValue: hotelProvider
                        //           .hotelData['leased'], // Current value of 'leased'
                        //       onChanged: (value) {
                        //         hotelProvider.updateHotelData('leased', value);
                        //       },
                        //     ),
                        //     const Text('Yes'),
                        //     Radio<bool>(
                        //       value: false, // Value for 'leased' being false
                        //       groupValue: hotelProvider
                        //           .hotelData['leased'], // Current value of 'leased'
                        //       onChanged: (value) {
                        //         hotelProvider.updateHotelData('leased', value);
                        //       },
                        //     ),
                        //     const Text('No'),
                        //   ],
                        // )
                        // Row(
                        //   children: [
                        //     const Text('Leased: '),
                        //     Checkbox(
                        //       value: hotelProvider.hotelData['leased'] ?? false,
                        //       onChanged: (value) {
                        //         hotelProvider.updateHotelData('leased', value);
                        //       },
                        //     ),
                        //   ],
                        // ),
                              // ElevatedButton(
            //   onPressed: () {
            //     if (_formKey.currentState!.validate()) {
            //       // Update provider with finance information
            //       hotelProvider.updateHotelData(
            //         'pan_number',
            //         panNumberController.text,
            //       );
            //       hotelProvider.updateHotelData(
            //         'property_number',
            //         propertyNumberController.text,
            //       );

            //       hotelProvider.updateHotelData(
            //         'gst_number',
            //         gstNumberController.text,
            //       );

            //       // Navigate to the next page
            //       Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => const ImagesUploadingScreen(),
            //       ));
            //     }
            //   },
            //   child: const Text('Next'),
            // ),
                  // Row(
                        //   children: [
                        //     const Text('Registered: '),
                        //     Checkbox(
                        //       value: hotelProvider.hotelData['registartion'] ?? false,
                        //       onChanged: (value) {
                        //         hotelProvider.updateHotelData('registartion', value);
                        //       },
                        //     ),
                        //   ],
                        // ),

                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate()) {
                        //       // Update provider with finance information
                        //       hotelProvider.updateHotelData(
                        //         'pan_number',
                        //         panNumberController.text,
                        //       );
                        //       hotelProvider.updateHotelData(
                        //         'property_number',
                        //         propertyNumberController.text,
                        //       );

                        //       hotelProvider.updateHotelData(
                        //         'gst_number',
                        //         gstNumberController.text,
                        //       );

                        //       // Navigate to the next page
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) =>
                        //             const ImagesUploadingScreen(),
                        //       ));
                        //     }
                        //   },
                        //   child: const Text('Next'),
                        // ),
                            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: HotelButton(
            //     text: "Next",
            //     onTap: () {
            //       if (_formKey.currentState!.validate()) {
            //         // Update provider with finance information
            //         hotelProvider.updateHotelData(
            //           'pan_number',
            //           panNumberController.text,
            //         );
            //         hotelProvider.updateHotelData(
            //           'property_number',
            //           propertyNumberController.text,
            //         );

            //         hotelProvider.updateHotelData(
            //           'gst_number',
            //           gstNumberController.text,
            //         );

            //         // Navigate to the next page
            //         Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) => const ImagesUploadingScreen(),
            //         ));
            //       }
            //     },
            //     color: const Color(0xff1E91B6),
            //     textColor: Colors.white,
            //     borderRadius: 10.0,
            //     padding: const EdgeInsets.symmetric(
            //         vertical: 15.0, horizontal: 30.0),
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //     height: 50,
            //     width: 300,
            //   ),
            // ),
            
           // TextFormField(
              //   controller: hotelTypeController,
              //   decoration: const InputDecoration(labelText: 'Hotel Type'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter hotel type';
              //     }
              //     return null;
              //   },
              // ),
                  // appBar: AppBar(title: const Text('Hotel Basic Details')),
                         //////////////////
                    // DropdownButton<String>(
                    //   hint: const Text('Select an item'),
                    //   value: hotelProvider
                    //       .selectedItem, // Access selected item from provider
                    //   items: hotelProvider.items.map((String item) {
                    //     return DropdownMenuItem<String>(
                    //       value: item,
                    //       child: Text(item),
                    //     );
                    //   }).toList(),
                    //   onChanged: (String? newValue) {
                    //     hotelProvider.setSelectedItem(newValue);
                    //     // Update provider's value
                    //     hotelProvider.updateHotelData('hotel_type', newValue);
                    //   },
                    // ),
                    // const SizedBox(height: 20),
                    // Text(
                    //   hotelProvider.selectedItem != null
                    //       ? 'Selected: ${hotelProvider.selectedItem}'
                    //       : 'No item selected',
                    //   style: const TextStyle(fontSize: 18),
                    // ),
                                 // Property Setup Field
              // TextFormField(
              //   controller: propertySetupController,
              //   decoration: const InputDecoration(labelText: 'Property Setup'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter property setup';
              //     }
              //     return null;
              //   },
              // ),
                    // Checkbox(
                    //   value: hotelProvider.hotelData['entire_property'] ?? false,
                    //   onChanged: (value) {
                    //     hotelProvider.updateHotelData('entire_property', value);
                    //   },
                    // ),
                           // Row(
              //   children: [
              //     Checkbox(
              //       value: hotelProvider.hotelData['private_property'] ?? false,
              //       onChanged: (value) {
              //         hotelProvider.updateHotelData('private_property', value);
              //       },
              //     ),
              //     const Text('private_property'),
              //   ],
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       // hotelProvider.updateHotelData(
              //       //     'hotel_type', hotelTypeController.text);
              //       // hotelProvider.updateHotelData(
              //       //     'property_setup', propertySetupController.text);

              //       Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => BasicInformation(),
              //       ));
              //     }
              //   },
              //   child: const Text('Next'),
              // ),
                  // Checkbox(
                    //   value: hotelProvider.hotelData['entire_property'] ?? false,
                    //   onChanged: (value) {
                    //     hotelProvider.updateHotelData('entire_property', value);
                    //   },
                    // ),
                              // if (_formKey.currentState!.validate()) {
                  //   final email = emailController.text.trim();
                  //   final password = passwordController.text.trim();
                  //   context.read<AuthBloc>().add(
                  //         SignInEmailPasswordEvent(
                  //           email: email,
                  //           password: password,
                  //         ),
                  //       );
                  // }
                             // hotelProvider.updateHotelData(
                    //     'hotel_type', hotelTypeController.text);
                    // hotelProvider.updateHotelData(
                    //     'property_setup', propertySetupController.text);
                      // TextFormField(
              //   controller: cityController,
              //   decoration: const InputDecoration(labelText: 'City'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter city';
              //     }
              //     return null;
              //   },
              // ),

              // TextFormField(
              //   controller: stateController,
              //   decoration: const InputDecoration(labelText: 'State'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter state';
              //     }
              //     return null;
              //   },
              // ),

              // TextFormField(
              //   controller: countryController,
              //   decoration: const InputDecoration(labelText: 'Country'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter country';
              //     }
              //     return null;
              //   },
              // ),

              // TextFormField(
              //   controller: pincodeController,
              //   decoration: const InputDecoration(labelText: 'Pincode'),
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter pincode';
              //     }
              //     return null;
              //   },
              // ),
                    // hotelProvider.updateHotelData('location', {
                    //   'city': cityController.text,
                    //   'state': stateController.text,
                    //   'country': countryController.text,
                    //   'pincode': int.parse(pincodeController.text)
                    // },

                    // );

                    // Navigate to the next page (Finance Page)
                    // Navigator.pushNamed(context, '/fifthPage');
                         // ElevatedButton(
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate()) {
                        //       // Update provider with location data

                        //       hotelProvider.updateHotelData(
                        //           'city', cityController.text);
                        //       hotelProvider.updateHotelData(
                        //           'state', stateController.text);
                        //       hotelProvider.updateHotelData(
                        //           'country', countryController.text);

                        //       hotelProvider.updateHotelData(
                        //           'pincode', int.parse(pincodeController.text));

                        //       Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => PoliciesPage(),
                        //       ));
                        //     }
                        //   },
                        //   child: const Text('Next'),
                        // ),
                        // // Custom widget for image source dialog
// class CustomImageSourceDialog extends StatelessWidget {
//   const CustomImageSourceDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Choose an option'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.camera_alt),
//             title: const Text('Camera'),
//             onTap: () {
//               Provider.of<HotelProvider>(context, listen: false).captureImage();
//               Navigator.of(context).pop();
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.photo),
//             title: const Text('Gallery'),
//             onTap: () {
//               Provider.of<HotelProvider>(context, listen: false).pickImages();
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hotel_side/controllers/field_information/datas_page.dart';
// import 'package:hotel_side/models/image_functions.dart';
// import 'package:hotel_side/views/registration_page/final_review.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class HotelImages extends StatelessWidget {
//   const HotelImages({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hotelProvider = Provider.of<HotelProvider>(context);
//     final imageUploadService =
//         Provider.of<ImageUploadService>(context, listen: false);

//     List<File> selectedImages = [];

//     Future<void> pickImage() async {
//       final imageSource = await showDialog<ImageSource>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Select Image Source'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(ImageSource.camera),
//               child: const Text('Camera'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
//               child: const Text('Gallery'),
//             ),
//           ],
//         ),
//       );

//       if (imageSource != null) {
//         log('caaled');
//         File? pickedImage = imageSource == ImageSource.camera
//             ? await imageUploadService.pickImageFromCamera()
//             : await imageUploadService.pickImageFromGallery();

//         if (pickedImage != null) {
//           selectedImages.add(pickedImage);
//         }
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text('Select Images')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             const Text('Select images for your hotel:'),
//             const SizedBox(height: 20),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: selectedImages.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index == selectedImages.length) {
//                     // Button to pick new image
//                     return GestureDetector(
//                       onTap: pickImage,
//                       child: Container(
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.add_a_photo),
//                       ),
//                     );
//                   } else {
//                     final imageFile = selectedImages[index];
//                     return Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Image.file(
//                           imageFile,
//                           fit: BoxFit.cover,
//                         ),
//                         Positioned(
//                           top: 5,
//                           right: 5,
//                           child: GestureDetector(
//                             onTap: () {
//                               selectedImages.removeAt(index);
//                             },
//                             child: const Icon(
//                               Icons.remove_circle,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 // Save images to Firebase and update the provider
//                 await hotelProvider.uploadImages(
//                     selectedImages, imageUploadService);
//                 // Navigate to the final review page
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const FinalReview(),
//                 ));
//               },
//               child: const Text('Next'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
       // const SizedBox(height: 16),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //       onPressed: provider.pickImages,
                //       child: const Text('Pick Images'),
                //     ),
                //     ElevatedButton(
                //       onPressed: provider.captureImage,
                //       child: const Text('Take Photo'),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),
                // Show "Upload Images" button only if images have been added
                // if (provider.images.isNotEmpty)
                //   ElevatedButton(
                //     onPressed: provider.isUploading
                //         ? null
                //         : () async {
                //             bool success = await provider.uploadImages();

                //             if (success) {
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                   builder: (context) => const FinalReview(),
                //                 ),
                //               );
                //             } else {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 const SnackBar(
                //                     content: Text(
                //                         'Upload failed. Please try again.')),
                //               );
                //             }
                //           },
                //     child: const Text('Upload Images'),
                //   ),
                // // Custom widget for image source dialog
// class CustomImageSourceDialog extends StatelessWidget {
//   const CustomImageSourceDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Choose an option'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.camera_alt),
//             title: const Text('Camera'),
//             onTap: () {
//               Provider.of<HotelProvider>(context, listen: false).captureImage();
//               Navigator.of(context).pop();
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.photo),
//             title: const Text('Gallery'),
//             onTap: () {
//               Provider.of<HotelProvider>(context, listen: false).pickImages();
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hotel_side/controllers/field_information/datas_page.dart';
// import 'package:hotel_side/models/image_functions.dart';
// import 'package:hotel_side/views/registration_page/final_review.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class HotelImages extends StatelessWidget {
//   const HotelImages({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hotelProvider = Provider.of<HotelProvider>(context);
//     final imageUploadService =
//         Provider.of<ImageUploadService>(context, listen: false);

//     List<File> selectedImages = [];

//     Future<void> pickImage() async {
//       final imageSource = await showDialog<ImageSource>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Select Image Source'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(ImageSource.camera),
//               child: const Text('Camera'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
//               child: const Text('Gallery'),
//             ),
//           ],
//         ),
//       );

//       if (imageSource != null) {
//         log('caaled');
//         File? pickedImage = imageSource == ImageSource.camera
//             ? await imageUploadService.pickImageFromCamera()
//             : await imageUploadService.pickImageFromGallery();

//         if (pickedImage != null) {
//           selectedImages.add(pickedImage);
//         }
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text('Select Images')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             const Text('Select images for your hotel:'),
//             const SizedBox(height: 20),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: selectedImages.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index == selectedImages.length) {
//                     // Button to pick new image
//                     return GestureDetector(
//                       onTap: pickImage,
//                       child: Container(
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.add_a_photo),
//                       ),
//                     );
//                   } else {
//                     final imageFile = selectedImages[index];
//                     return Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Image.file(
//                           imageFile,
//                           fit: BoxFit.cover,
//                         ),
//                         Positioned(
//                           top: 5,
//                           right: 5,
//                           child: GestureDetector(
//                             onTap: () {
//                               selectedImages.removeAt(index);
//                             },
//                             child: const Icon(
//                               Icons.remove_circle,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 // Save images to Firebase and update the provider
//                 await hotelProvider.uploadImages(
//                     selectedImages, imageUploadService);
//                 // Navigate to the final review page
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const FinalReview(),
//                 ));
//               },
//               child: const Text('Next'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
       // const SizedBox(height: 16),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //       onPressed: provider.pickImages,
                //       child: const Text('Pick Images'),
                //     ),
                //     ElevatedButton(
                //       onPressed: provider.captureImage,
                //       child: const Text('Take Photo'),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),
                // Show "Upload Images" button only if images have been added
                // if (provider.images.isNotEmpty)
                //   ElevatedButton(
                //     onPressed: provider.isUploading
                //         ? null
                //         : () async {
                //             bool success = await provider.uploadImages();

                //             if (success) {
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                   builder: (context) => const FinalReview(),
                //                 ),
                //               );
                //             } else {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 const SnackBar(
                //                     content: Text(
                //                         'Upload failed. Please try again.')),
                //               );
                //             }
                //           },
                //     child: const Text('Upload Images'),
                //   ),
