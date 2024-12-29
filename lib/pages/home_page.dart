import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pantau_belajar/components/my_custom_card.dart';
import 'package:pantau_belajar/pages/profile_page.dart';
import 'package:pantau_belajar/services/user_service.dart';
import 'package:pantau_belajar/models/app_user.dart'; // Pastikan model AppUser diimport

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService userService = UserService();
  Future<AppUser?>? userData;

  @override
  void initState() {
    super.initState();
    userData = userService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
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
                        "Good Morning",
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
                          } else if (!snapshot.hasData || snapshot.data == null) {
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
                            user.username, // Replace 'username' with the actual property name in AppUser
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return  ProfilePage();
                          },
                        ),
                      );
                    },
                    child: Image.asset(
                      'images/avatar.png',
                      height: 80,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              MyCustomCard(
                title: 'Senin',
                heading: 'Due Date',
                subheading: '2024-12-26', // Replace with dynamic data if available
                description: 'Tugas Matematika belum selesai!',
                screenWidth: screenWidth,
              ),
              const SizedBox(height: 20),
              Text(
                'Kelas Hari Ini',
                style: GoogleFonts.poppins(
                  fontSize: 15 + screenWidth * 0.01,
                  color: const Color.fromARGB(255, 232, 122, 48),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                child: Column(
                  children: [
                    _buildClassCard(
                      screenWidth,
                      'Embedded System',
                      '10:20 - 12:00',
                      '301',
                      const Color.fromARGB(255, 65, 163, 254),
                    ),
                    const SizedBox(height: 15),
                    _buildClassCard(
                      screenWidth,
                      'Kewirausahaan',
                      '15:30 - 17:10',
                      '401',
                      const Color.fromARGB(255, 93, 173, 110),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClassCard(double screenWidth, String className, String time,
      String room, Color color) {
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color,
                ),
                child: Text(
                  room,
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Jam'),
                  Text(time),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
