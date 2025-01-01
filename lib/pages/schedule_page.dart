import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pantau_belajar/components/my_custom_card.dart';
import 'package:pantau_belajar/components/my_popup.dart';
import 'package:pantau_belajar/pages/add_schedule_page.dart';
import 'package:pantau_belajar/pages/detail_schedule_page.dart';
import 'package:pantau_belajar/models/schedule.dart';
import 'package:pantau_belajar/services/schedule_service.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final ScheduleService _scheduleService = ScheduleService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSchedulePage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "Jadwal",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 57, 42, 171),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: StreamBuilder<List<Schedule>>(
            stream: _scheduleService.getSchedulesStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Terjadi kesalahan.'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Belum ada jadwal.'));
              } else {
                final schedules = snapshot.data!;
                return ListView.builder(
                  itemCount: schedules.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final schedule = schedules[index];
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSchedulePage(
                                  schedule: schedule,
                                ),
                              ),
                            );
                          },
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddSchedulePage(
                                          schedule: schedule,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icons.edit,
                                  backgroundColor: Colors.amber,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => MyPopup(
                                        message:
                                            'Apakah anda yakin ingin menghapus jadwal dan semua isinya?',
                                        onConfirm: () {
                                          _scheduleService
                                              .deleteSchedule(schedule.id);
                                        },
                                      ),
                                    );
                                  },
                                  icon: Icons.delete,
                                  backgroundColor: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ],
                            ),
                            child: MyCustomCard(
                              title: schedule.title,
                              heading: schedule.heading,
                              subheading: schedule.subheading,
                              description: schedule.description,
                              screenWidth: screenWidth,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
