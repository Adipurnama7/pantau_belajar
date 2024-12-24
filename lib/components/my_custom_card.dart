import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomCard extends StatelessWidget {
  final String day;
  final String dueDate;
  final String message;

  const MyCustomCard({
    Key? key,
    required this.day,
    required this.dueDate,
    required this.message, required double screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      width: screenWidth,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 57, 42, 171),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: GoogleFonts.poppins(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Due Date',
            style: GoogleFonts.poppins(
              fontSize: 11 + screenWidth * 0.01,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            dueDate,
            style: GoogleFonts.poppins(
              fontSize: 12 + screenWidth * 0.01,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: screenWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 232, 122, 48),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 9 + screenWidth * 0.01,
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
