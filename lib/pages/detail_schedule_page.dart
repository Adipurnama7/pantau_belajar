import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pantau_belajar/components/my_custom_card.dart';
import 'package:pantau_belajar/components/my_schedule.dart';

class DetailSchedulePage extends StatefulWidget {
  const DetailSchedulePage({super.key});

  @override
  State<DetailSchedulePage> createState() => _DetailSchedulePageState();
}

class _DetailSchedulePageState extends State<DetailSchedulePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MyCustomCard Component
                MyCustomCard(
                  day: 'Belajar Flutter',
                  dueDate: '2023-12-25',
                  message: 'Hari ini tidak ada kuliah',
                  screenWidth: screenWidth,
                ),
                const SizedBox(height: 20),
                // MySchedule Component
                MySchedule(
                  day: 'Senin',
                  scheduleItems: [
                    ScheduleItem(
                      title: 'Embedded System',
                      room: '301',
                      time: '10:20 - 12:00',
                      color: const Color.fromARGB(255, 65, 163, 254),
                    )
                  ],
                ),
                MySchedule(
                  day: 'Selasa',
                  scheduleItems: [
                    ScheduleItem(
                      title: 'Embedded System',
                      room: '301',
                      time: '10:20 - 12:00',
                      color: const Color.fromARGB(255, 65, 163, 254),
                    )
                  ],
                ),
                MySchedule(
                  day: 'Rabu',
                  scheduleItems: [
                    ScheduleItem(
                      title: 'Embedded System',
                      room: '301',
                      time: '10:20 - 12:00',
                      color: const Color.fromARGB(255, 65, 163, 254),
                    )
                  ],
                ),
                MySchedule(
                  day: 'Kamis',
                  scheduleItems: [
                    ScheduleItem(
                      title: 'Embedded System',
                      room: '301',
                      time: '10:20 - 12:00',
                      color: const Color.fromARGB(255, 65, 163, 254),
                    )
                  ],
                ),
                MySchedule(
                  day: 'Jumat',
                  scheduleItems: [
                    ScheduleItem(
                      title: 'Embedded System',
                      room: '301',
                      time: '10:20 - 12:00',
                      color: const Color.fromARGB(255, 65, 163, 254),
                    )
                  ],
                ),
                MySchedule(
                  day: 'Sabtu',
                  scheduleItems: [
                    ScheduleItem(
                      title: 'Embedded System',
                      room: '301',
                      time: '10:20 - 12:00',
                      color: const Color.fromARGB(255, 65, 163, 254),
                    )
                  ],
                ),
                MySchedule(
                  day: 'Minggu',
                  scheduleItems: [
                    ScheduleItem(
                      title: 'Embedded System',
                      room: '301',
                      time: '10:20 - 12:00',
                      color: const Color.fromARGB(255, 65, 163, 254),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
