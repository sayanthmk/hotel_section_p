import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_side/controllers/location_provider/location_provider.dart';
import 'package:provider/provider.dart';

class CurrentLocationSection extends StatelessWidget {
  const CurrentLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return GestureDetector(
          onTap: () async {
            await locationProvider.getCurrentLocation();
            if (locationProvider.error.isNotEmpty) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(locationProvider.error)),
                );
                locationProvider.clearError();
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                locationProvider.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xff1E91B6),
                        ),
                      )
                    : const Icon(
                        FontAwesomeIcons.locationCrosshairs,
                        color: Color(0xff1E91B6),
                        size: 20,
                      ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    locationProvider.currentAddress.isNotEmpty
                        ? locationProvider.currentAddress
                        : 'Use Current Location',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
