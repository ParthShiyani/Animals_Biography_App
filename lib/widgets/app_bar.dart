import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

appBar() {
  return Row(
    children: [
      Column(
        children: [
          Text(
            "aplanet",
            style: GoogleFonts.poppins(
              fontSize: 25,
              color: Colors.white.withOpacity(0.65),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "We Love the Planet",
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.white.withOpacity(0.75),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      const Spacer(),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.menu,
          color: Colors.white.withOpacity(0.75),
        ),
      )
    ],
  );
}
