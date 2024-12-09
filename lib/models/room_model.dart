// class RoomModel {
//   final String roomId;
//   final String roomArea;
//   final String roomType;
//   final int propertySize;
//   final int extraBedType;
//   final bool cupboard;
//   final bool wardrobe;
//   final bool freeBreakfast;
//   final bool freeLunch;
//   final bool freeDinner;
//   final int basePrice;
//   final int extraAdultsAllowed;
//   final int extraChildrenAllowed;
//   final bool laundry;
//   final bool elevator;
//   final bool airConditioner;
//   final bool houseKeeping;
//   final bool kitchen;
//   final bool wifi;
//   final bool parking;
//   final List<String> images;

//   RoomModel({
//     required this.roomId,
//     required this.roomArea,
//     required this.roomType,
//     required this.propertySize,
//     required this.extraBedType,
//     required this.cupboard,
//     required this.wardrobe,
//     required this.freeBreakfast,
//     required this.freeLunch,
//     required this.freeDinner,
//     required this.basePrice,
//     required this.extraAdultsAllowed,
//     required this.extraChildrenAllowed,
//     required this.laundry,
//     required this.elevator,
//     required this.airConditioner,
//     required this.houseKeeping,
//     required this.kitchen,
//     required this.wifi,
//     required this.parking,
//     required this.images,
//   });

//   factory RoomModel.fromMap(Map<String, dynamic> map) {
//     return RoomModel(
//       roomId: map['roomId'] ?? '',
//       roomArea: map['room_area'] ?? '',
//       roomType: map['room_type'] ?? '',
//       propertySize: map['Property Size'] ?? 0,
//       extraBedType: map['Select Extra Bed Types'] ?? 0,
//       cupboard: map['Cupboard'] ?? false,
//       wardrobe: map['Wardrobe'] ?? false,
//       freeBreakfast: map['Free Breakfast'] ?? false,
//       freeLunch: map['Free Lunch'] ?? false,
//       freeDinner: map['Free Dinner'] ?? false,
//       basePrice: map['Base Price'] ?? 0,
//       extraAdultsAllowed: map['Number of Extra Adults Allowed'] ?? 0,
//       extraChildrenAllowed: map['Number of Extra Child Allowed'] ?? 0,
//       laundry: map['Laundry'] ?? false,
//       elevator: map['Elevator'] ?? false,
//       airConditioner: map['Air Conditioner'] ?? false,
//       houseKeeping: map['House Keeping'] ?? false,
//       kitchen: map['Kitchen'] ?? false,
//       wifi: map['Wifi'] ?? false,
//       parking: map['Parking'] ?? false,
//       images: List<String>.from(map['room_images'] ?? []),
//     );
//   }
// }
