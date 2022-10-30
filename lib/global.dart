import 'dart:ui';
import 'modals/animal.dart';

class Global {
  static List button = [
    {
      'icon': "🐻‍",
      'name': "BEAR",
    },
    {
      'icon': "🦁",
      'name': "LION",
    },
    {
      'icon': "🐍",
      'name': "SNAKE",
    },
    {
      'icon': "🐶",
      'name': "PETS",
    },
  ];

  static Color color = const Color(0xffC19E82);
  static String category = "";

  static List<Subscription> subscription = [
    Subscription(time: "Week", price: "1.99"),
    Subscription(time: "1 Month", price: "4.39"),
    Subscription(time: "3 Month", price: "9.99"),
    Subscription(time: "6 Month", price: "13.99"),
    Subscription(time: "12 Month", price: "19.99"),
  ];

  static List<Animal> animal = [
    Animal(
      name: "Zebra",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Zebra",
    ),
    Animal(
      name: "Elephant",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Elephant",
    ),
    Animal(
      name: "Black Bear",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Bear",
    ),
    Animal(
      name: "Brown Bear",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Bear",
    ),
    Animal(
      name: "Polar Bear",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Bear",
    ),
    Animal(
      name: "Asiatic Lion",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Lion",
    ),
    Animal(
      name: "Transvaal Lion",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Lion",
    ),
    Animal(
      name: "Black Mamba",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Snake",
    ),
    Animal(
      name: "Green Tree Python",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Snake",
    ),
    Animal(
      name: "Indian cobra",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Snake",
    ),
    Animal(
      name: "German Shepherd",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Dog",
    ),
    Animal(
      name: "LebraDor",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Dog",
    ),
    Animal(
      name: "Pit Bull",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Dog",
    ),
    Animal(
      name: "Pug",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
      category: "Dog",
    ),
  ];
}
