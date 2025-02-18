class RoomModel {
  String roomArea;
  String roomType;
  int propertySize;
  int selectExtraBedTypes;
  bool cupboard;
  bool wardrobe;
  bool freeBreakfast;
  bool freeLunch;
  bool freeDinner;
  int basePrice;
  int numberOfExtraAdultsAllowed;
  int numberOfExtraChildrenAllowed;
  bool laundry;
  bool elevator;
  bool airConditioner;
  bool houseKeeping;
  bool kitchen;
  bool wifi;
  bool parking;
  List<String> roomImages;

  RoomModel({
    required this.roomArea,
    required this.roomType,
    required this.propertySize,
    required this.selectExtraBedTypes,
    required this.cupboard,
    required this.wardrobe,
    required this.freeBreakfast,
    required this.freeLunch,
    required this.freeDinner,
    required this.basePrice,
    required this.numberOfExtraAdultsAllowed,
    required this.numberOfExtraChildrenAllowed,
    required this.laundry,
    required this.elevator,
    required this.airConditioner,
    required this.houseKeeping,
    required this.kitchen,
    required this.wifi,
    required this.parking,
    required this.roomImages,
  });

  Map<String, dynamic> toJson() {
    return {
      "room_area": roomArea,
      "room_type": roomType,
      "Property Size": propertySize,
      "Select Extra Bed Types": selectExtraBedTypes,
      "Cupboard": cupboard,
      "Wardrobe": wardrobe,
      "Free Breakfast": freeBreakfast,
      "Free Lunch": freeLunch,
      "Free Dinner": freeDinner,
      "Base Price": basePrice,
      "Number of Extra Adults Allowed": numberOfExtraAdultsAllowed,
      "Number of Extra Child Allowed": numberOfExtraChildrenAllowed,
      "Laundry": laundry,
      "Elevator": elevator,
      "Air Conditioner": airConditioner,
      "House Keeping": houseKeeping,
      "Kitchen": kitchen,
      "Wifi": wifi,
      "Parking": parking,
      "room_images": roomImages,
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomArea: json["room_area"] ?? '',
      roomType: json["room_type"] ?? '',
      propertySize: json["Property Size"] ?? 0,
      selectExtraBedTypes: json["Select Extra Bed Types"] ?? 0,
      cupboard: json["Cupboard"] ?? false,
      wardrobe: json["Wardrobe"] ?? false,
      freeBreakfast: json["Free Breakfast"] ?? false,
      freeLunch: json["Free Lunch"] ?? false,
      freeDinner: json["Free Dinner"] ?? false,
      basePrice: json["Base Price"] ?? 0,
      numberOfExtraAdultsAllowed: json["Number of Extra Adults Allowed"] ?? 0,
      numberOfExtraChildrenAllowed: json["Number of Extra Child Allowed"] ?? 0,
      laundry: json["Laundry"] ?? false,
      elevator: json["Elevator"] ?? false,
      airConditioner: json["Air Conditioner"] ?? false,
      houseKeeping: json["House Keeping"] ?? false,
      kitchen: json["Kitchen"] ?? false,
      wifi: json["Wifi"] ?? false,
      parking: json["Parking"] ?? false,
      roomImages: List<String>.from(json["room_images"] ?? []),
    );
  }
}
