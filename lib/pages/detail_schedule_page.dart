import 'package:flutter/material.dart';
import 'package:pantau_belajar/components/my_custom_card.dart';
import 'package:pantau_belajar/components/my_popup.dart';
import 'package:pantau_belajar/components/my_schedule.dart';
import 'package:pantau_belajar/models/detail_schedule.dart';
import 'package:pantau_belajar/models/schedule.dart';
import 'package:pantau_belajar/pages/add_detail_schedule_page.dart';
import 'package:pantau_belajar/services/detail_schedule_service.dart';

class DetailSchedulePage extends StatefulWidget {
  final Schedule schedule;
  const DetailSchedulePage({super.key, required this.schedule});

  @override
  State<DetailSchedulePage> createState() => _DetailSchedulePageState();
}

class _DetailSchedulePageState extends State<DetailSchedulePage> {
  Schedule? schedule;
  DetailScheduleService _detailScheduleService = DetailScheduleService();

  @override
  void initState() {
    super.initState();
    schedule = widget.schedule;
  }

  // Helper function to get weekday from TimeOfDay
  int getWeekdayFromDayString(String dayString) {
    switch (dayString.toLowerCase()) {
      case 'senin':
        return 1; // Monday
      case 'selasa':
        return 2; // Tuesday
      case 'rabu':
        return 3; // Wednesday
      case 'kamis':
        return 4; // Thursday
      case 'jumat':
        return 5; // Friday
      case 'sabtu':
        return 6; // Saturday
      case 'minggu':
        return 7; // Sunday
      default:
        return 1; // Default to Monday if unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 57, 42, 171),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDetailSchedulePage(
                  schedule: schedule,
                ),
              ),
            ),
            child: const Icon(Icons.calendar_today, color: Colors.white),
          ),
          body: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MyCustomCard(
                      title: schedule?.title ?? 'No Title',
                      heading: schedule?.heading ?? 'No Heading',
                      subheading: schedule?.subheading ?? 'No Subheading',
                      description: schedule?.description ?? 'No Description',
                      screenWidth: screenWidth,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 232, 122, 48),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ListView for schedule items
              StreamBuilder<List<DetailSchedule>>(
                stream: _detailScheduleService
                    .getDetailScheduleByScheduleIdStream(schedule!.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No schedule items available.'));
                  } else {
                    List<DetailSchedule> scheduleItems = snapshot.data!;

                    // Organize the schedule items by day (1 to 7)
                    Map<int, List<DetailSchedule>> groupedByDay = {
                      1: [], // Monday
                      2: [], // Tuesday
                      3: [], // Wednesday
                      4: [], // Thursday
                      5: [], // Friday
                      6: [], // Saturday
                      7: [], // Sunday
                    };

                    // Group schedule items by day
                    for (var item in scheduleItems) {
                      int weekday = getWeekdayFromDayString(item.day);
                      groupedByDay[weekday]?.add(item);
                    }

                    // Sort the schedule items for each day by startTime in ascending order
                    groupedByDay.forEach((key, value) {
                      value.sort((a, b) {
                        // Assuming startTime is a TimeOfDay, compare it
                        return a.startTime.compareTo(b.startTime);
                      });
                    });

                    return Expanded(
                      child: ListView.builder(
                        itemCount: 7, // There are always 7 days in a week
                        itemBuilder: (context, index) {
                          // Map index to weekday number
                          int day = index + 1; // 0 -> Monday, 6 -> Sunday

                          // Map weekday number to actual day name
                          String dayName = '';
                          switch (day) {
                            case 1:
                              dayName = 'Senin';
                              break;
                            case 2:
                              dayName = 'Selasa';
                              break;
                            case 3:
                              dayName = 'Rabu';
                              break;
                            case 4:
                              dayName = 'Kamis';
                              break;
                            case 5:
                              dayName = 'Jumat';
                              break;
                            case 6:
                              dayName = 'Sabtu';
                              break;
                            case 7:
                              dayName = 'Minggu';
                              break;
                            default:
                              dayName = 'Unknown';
                          }

                          // Retrieve the list of schedule items for this day
                          List<DetailSchedule> itemsForDay = groupedByDay[day]!;

                          // If no items exist for this day, show a message
                          if (itemsForDay.isEmpty) {
                            return SizedBox();
                          }

                          // Convert DetailSchedule to ScheduleItem
                          List<ScheduleItem> scheduleItemsForDay =
                              itemsForDay.map((item) {
                            return ScheduleItem(
                              id: item.id,
                              title: item.title,
                              startTime: item.startTime,
                              endTime: item.endTime,
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return AddDetailSchedulePage(
                                        schedule: schedule,
                                        detailSchedule: item,
                                      );
                                    },
                                  ),
                                );
                              },
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => MyPopup(
                                    message:
                                        'Apakah anda yakin ingin menghapus',
                                    onConfirm: () {
                                      _detailScheduleService
                                          .deleteDetailSchedule(
                                        item.scheduleId,
                                        item.id,
                                      );
                                      Navigator.pop(context);
                                    },
                                    onCancel: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          }).toList();

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: MySchedule(
                              day: dayName,
                              scheduleItems: scheduleItemsForDay,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on TimeOfDay {
  int compareTo(TimeOfDay startTime) {
    final int totalMinutesThis = hour * 60 + minute;
    final int totalMinutesOther = startTime.hour * 60 + startTime.minute;
    return totalMinutesThis.compareTo(totalMinutesOther);
  }
}
