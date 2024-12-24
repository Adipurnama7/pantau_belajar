import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySchedule extends StatelessWidget {
  final String day;
  final List<ScheduleItem> scheduleItems;

  const MySchedule({
    Key? key,
    required this.day,
    required this.scheduleItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            day,
            style: GoogleFonts.poppins(
              fontSize: 15 + screenWidth * 0.01,
              color: const Color.fromARGB(255, 232, 122, 48),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Column(
          children: scheduleItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.all(15),
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.title,
                          style: GoogleFonts.poppins(
                            fontSize: 12 + screenWidth * 0.01,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: item.color,
                          ),
                          child: Text(
                            item.room,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jam',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              item.time,
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ScheduleItem {
  final String title;
  final String room;
  final String time;
  final Color color;

  ScheduleItem({
    required this.title,
    required this.room,
    required this.time,
    required this.color,
  });
}
