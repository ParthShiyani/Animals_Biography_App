import 'dart:typed_data';

class Subscription {
  final String time;
  final String price;

  Subscription({required this.time, required this.price});
}

class SubscriptionDB {
  final String time;
  final String price;
  final Uint8List image;

  SubscriptionDB({
    required this.time,
    required this.price,
    required this.image,
  });

  factory SubscriptionDB.fromData(e) {
    return SubscriptionDB(
        time: e["time"], price: e["price"], image: e["image"]);
  }
}

class Animal {
  final String name;
  final String description;
  final String category;

  Animal(
      {required this.name, required this.description, required this.category});
}

class AnimalDB {
  final String name;
  final String description;
  final String category;
  final Uint8List image;

  AnimalDB({
    required this.name,
    required this.description,
    required this.category,
    required this.image,
  });

  factory AnimalDB.fromData(Map data) {
    return AnimalDB(
        name: data["name"],
        description: data["description"],
        category: data["category"],
        image: data["image"]);
  }
}
