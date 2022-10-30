import 'package:flutter/material.dart';

nextArrow() {
  return Container(
    height: 75,
    width: 85,
    alignment: Alignment.bottomRight,
    padding: const EdgeInsets.only(right: 20, bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(100),
      ),
    ),
    child: const Icon(
      Icons.arrow_forward_rounded,
      color: Colors.white,
      size: 30,
    ),
  );
}
