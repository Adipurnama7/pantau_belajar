import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySchedule extends StatelessWidget {
  final String day;
  final List<ScheduleItem> scheduleItems;

  MySchedule({
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
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12 + screenWidth * 0.01,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              item.formattedTime, // Use the formattedTime getter
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: item.onEdit,
                              child: Container(
                                child: const Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 232, 122, 48),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: item.onDelete,
                              child: Container(
                                child: const Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 255, 0, 0),
                                ),
                              ),
                            ),
                          ],
                        )
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
  final String id;
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  void Function()? onEdit;
  void Function()? onDelete;

  ScheduleItem({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.onEdit,
    this.onDelete,
  });

  // Getter to format the start and end time
  String get formattedTime {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} - '
        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }

  // Convert TimeOfDay to String representation for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'startTime': _timeOfDayToString(startTime),
      'endTime': _timeOfDayToString(endTime),
    };
  }

  // Create ScheduleItem from Firestore data
  factory ScheduleItem.fromMap(Map<String, dynamic> map) {
    return ScheduleItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      startTime: _stringToTimeOfDay(map['startTime']),
      endTime: _stringToTimeOfDay(map['endTime']),
    );
  }

  // Helper function to convert TimeOfDay to a string format (HH:mm)
  String _timeOfDayToString(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  // Helper function to convert string back to TimeOfDay
  static TimeOfDay _stringToTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
