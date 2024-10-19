// // image_upload_provider.dart
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageUploadProvider with ChangeNotifier {
//   final List<File> _images = [];
//   final List<String> _imageUrls = [];
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

//   void removeImage(int index) {
//     if (index >= 0 && index < _images.length) {
//       _images.removeAt(index);
//       notifyListeners();
//     }
//   }

//   Future<bool> uploadImages() async {
//     if (_images.isEmpty) return false;

//     _isUploading = true;
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
//       return true;
//     } catch (e) {
//       print('Error uploading images: $e');
//       _isUploading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   void clearImages() {
//     _images.clear();
//     _imageUrls.clear();
//     notifyListeners();
//   }
// }
