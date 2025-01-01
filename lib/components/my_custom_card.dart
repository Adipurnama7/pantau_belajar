import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomCard extends StatelessWidget {
  final String title;
  final String heading;
  final String subheading;
  final String description;

  const MyCustomCard({
    Key? key,
    required this.title,
    required this.heading,
    required this.subheading,
    required this.description,
    double? screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      width: _screenWidth,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 57, 42, 171),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            heading,
            style: GoogleFonts.poppins(
              fontSize: 11 + _screenWidth * 0.01,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subheading,
            style: GoogleFonts.poppins(
              fontSize: 12 + _screenWidth * 0.01,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: _screenWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 232, 122, 48),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 9 + _screenWidth * 0.01,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
