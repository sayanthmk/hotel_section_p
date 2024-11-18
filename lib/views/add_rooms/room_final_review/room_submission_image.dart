import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:provider/provider.dart';

class RoomSubmissionImage extends StatelessWidget {
  const RoomSubmissionImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: provider.roomImageUrls.isEmpty
                ? [const Text('No images uploaded yet.')]
                : provider.roomImageUrls.map(
                    (url) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            url,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.error,
                                size: 120,
                                color: Colors.red,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ).toList(),
          ),
        );
      },
    );
  }
}
