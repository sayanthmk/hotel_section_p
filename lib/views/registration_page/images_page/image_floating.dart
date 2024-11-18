import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/widgets/home_page_widgets/alert_box.dart';
import 'package:provider/provider.dart';

class ImageFloatingButton extends StatelessWidget {
  const ImageFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1E91B6).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: const Color(0xff1E91B6),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              contentText: 'Choose how you want to add photos',
              titleText: 'Add Photos',
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
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}
