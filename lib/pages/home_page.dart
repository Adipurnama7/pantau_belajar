import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Untuk memformat tanggal dalam bahasa Indonesia
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pantau_belajar/components/my_custom_card.dart';
import 'package:pantau_belajar/pages/main_page.dart';
import 'package:pantau_belajar/pages/profile_page.dart';
import 'package:pantau_belajar/services/schedule_service.dart';
import 'package:pantau_belajar/services/user_service.dart';
import 'package:pantau_belajar/models/app_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService userService = UserService();
  final ScheduleService scheduleService = ScheduleService();
  String? todayDay; // Variabel untuk nama hari
  Future<AppUser?>? userData;
  String today = DateFormat('y/d/m').format(DateTime.now()).toString();

  @override
  void initState() {
    super.initState();
    todayDay = DateFormat('EEEE', 'id_ID')
        .format(DateTime.now())
        .toLowerCase(); // Menyimpan nama hari hari ini dalam bahasa Indonesia
    userData = userService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 110, 110, 110),
                          ),
                        ),
                        FutureBuilder<AppUser?>(
                          future: userData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text(
                                'Error: ${snapshot.error}',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data == null) {
                              return Text(
                                "User data not found",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              );
                            }

                            // Access the AppUser data
                            AppUser user = snapshot.data!;
                            return Text(
                              user.username,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 57, 42, 171),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Image.asset(
                      'images/avatar.png',
                      height: 80,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MyCustomCard(
                  title: todayDay!, // Menampilkan nama hari saat ini
                  heading: 'Tanggal',
                  subheading: today,
                  description: 'Nikmati setiap detik perjalanan hari ini',
                  screenWidth: screenWidth,
                ),
                const SizedBox(height: 20),
                Text(
                  'Jadwal Hari Ini',
                  style: GoogleFonts.poppins(
                    fontSize: 15 + screenWidth * 0.01,
                    color: const Color.fromARGB(255, 232, 122, 48),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder<AppUser?>(
                        future: userData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return SizedBox();
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return const SizedBox();
                          }

                          // Access the AppUser data
                          AppUser user = snapshot.data!;
                          return StreamBuilder<List<Map<String, dynamic>>>(
                            stream: scheduleService.getSchedulesForToday(
                                todayDay!, user.uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Text('Tidak ada jadwal untuk hari ini.');
                              } else {
                                List<Map<String, dynamic>> schedules =
                                    snapshot.data!;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: schedules.length,
                                  itemBuilder: (context, index) {
                                    var schedule = schedules[index];
                                    return _buildClassCard(
                                      screenWidth,
                                      schedule['title'],
                                      schedule['startTime'],
                                      schedule['endTime'],
                                    );
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClassCard(double screenWidth, String className,
      Timestamp startTime, Timestamp endTime) {
    // Mengonversi Timestamp ke DateTime
    DateTime startDateTime =
        DateTime.fromMillisecondsSinceEpoch(startTime.seconds * 1000);
    DateTime endDateTime =
        DateTime.fromMillisecondsSinceEpoch(endTime.seconds * 1000);

    // Memformat DateTime untuk hanya menampilkan jam dan menit
    String formattedStartTime = DateFormat('HH:mm').format(startDateTime);
    String formattedEndTime = DateFormat('HH:mm').format(endDateTime);

    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.topLeft,
      width: screenWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                className,
                style: GoogleFonts.poppins(
                  fontSize: 12 + screenWidth * 0.01,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Jam'),
              Row(
                children: [
                  Text(
                      formattedStartTime), // Menampilkan startTime yang sudah diformat
                  Text(' - '),
                  Text(formattedEndTime),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
