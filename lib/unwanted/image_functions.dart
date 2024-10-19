// // image_upload_service.dart

// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

// class ImageUploadService {
//   final ImagePicker _picker = ImagePicker();

//   // Function to pick image from gallery
//   Future<File?> pickImageFromGallery() async {
//     log('pickImageFromGallery function called');
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     }
//     return null;
//   }

//   // Function to pick image from camera
//   Future<File?> pickImageFromCamera() async {
//     log('pickImageFromcamera function called');

//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     }
//     return null;
//   }

//   // Function to upload image to Firebase Storage
//   Future<String> uploadImageToFirebase(File imageFile) async {
//     try {
//       log('firephoto called');
//       String fileName = basename(imageFile.path); // Get the file name
//       Reference storageRef =
//           FirebaseStorage.instance.ref().child('hotel_images/$fileName');
//       UploadTask uploadTask = storageRef.putFile(imageFile);
//       TaskSnapshot taskSnapshot = await uploadTask;
//       return await taskSnapshot.ref.getDownloadURL(); // Return the download URL
//     } catch (e) {
//       print('Error uploading image: $e');
//       return '';
//     }
//   }

//   // Function to save selected images to Firebase and return their URLs
//   Future<List<String>> saveImagesToFirebase(List<File> selectedImages) async {
//     List<String> imageUrls = [];
//     for (var imageFile in selectedImages) {
//       String downloadUrl = await uploadImageToFirebase(imageFile);
//       if (downloadUrl.isNotEmpty) {
//         imageUrls.add(downloadUrl);
//       }
//     }
//     return imageUrls;
//   }
// }
