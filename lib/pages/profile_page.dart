import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pantau_belajar/components/my_menu_item.dart';
import 'package:pantau_belajar/models/app_user.dart';
import 'package:pantau_belajar/pages/auth_page.dart';
import 'package:pantau_belajar/services/user_service.dart';
import 'package:pantau_belajar/pages/user_detail_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService userService = UserService();
  Future<AppUser?>? userData;

  @override
  void initState() {
    super.initState();
    userData = userService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.blue.shade100,
                  backgroundImage: const AssetImage('images/profile.png'),
                ),
                const SizedBox(height: 20),
                FutureBuilder<AppUser?>(
                  future: userData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 57, 42, 171),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ProfileMenuItem(
                  icon: Icons.person,
                  title: "Account",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailPage(),
                      ),
                    );
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {
                    logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void logout() async {
    UserService userService = UserService();
    await userService.logout();
  }
}
