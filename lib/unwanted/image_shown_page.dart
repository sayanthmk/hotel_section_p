// import 'package:flutter/material.dart';
// import 'package:hotel_side/controllers/field_information/datas_page.dart';
// import 'package:provider/provider.dart';

// class ImageNotifierPage extends StatelessWidget {
//   const ImageNotifierPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //  backgroundColor: const Color(0xffF5F9FF),
//       body: Consumer<HotelProvider>(
//         builder: (context, provider, child) {
//           return ListView(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.all(16),
//             children: [
//               const Text(
//                 'Upload Status',
//               ),
//               const SizedBox(height: 16),
//               if (provider.isUploading)
//                 const CircularProgressIndicator()
//               else if (provider.imageUrls.isEmpty)
//                 const Text('No images uploaded yet.')
//               else
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Uploaded Images:'),
//                     const SizedBox(height: 8),
//                     ...provider.imageUrls
//                         .map((url) => ListTile(
//                               leading: const Icon(Icons.image),
//                               title: const Text('Image Uploaded'),
//                               subtitle: Text(url),
//                             ))
//                         .toList(),
//                   ],
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
