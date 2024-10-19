import 'package:flutter/material.dart';

class RoomTile extends StatelessWidget {
  final String room;
  final String status;
  final bool isOccupied;
  final String? guestName;
  final String? checkOut;
  final String? type;
  final String? price;

  const RoomTile({
    Key? key,
    required this.room,
    required this.status,
    required this.isOccupied,
    this.guestName,
    this.checkOut,
    this.type,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isOccupied ? Colors.red[50] : Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.hotel,
              color: isOccupied ? Colors.red[400] : Colors.green[400],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      room,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isOccupied ? Colors.red[50] : Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color:
                              isOccupied ? Colors.red[700] : Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                if (guestName != null)
                  Text(
                    guestName!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                if (checkOut != null)
                  Text(
                    checkOut!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                if (type != null)
                  Text(
                    type!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                if (price != null)
                  Text(
                    price!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOccupied ? Colors.red[400] : Colors.green[400],
            ),
          ),
        ],
      ),
    );
  }
}
