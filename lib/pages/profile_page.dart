import 'package:flutter/material.dart';
import 'package:pantau_belajar/components/my_menu_item.dart';
import 'package:pantau_belajar/services/user_service.dart';
import 'package:pantau_belajar/pages/user_detail_page.dart'; 

class ProfilePage extends StatelessWidget {
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
                  backgroundImage: AssetImage('images/profile.png'),
                ),
                SizedBox(height: 20),
                Text(
                  'Adi Purnama',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 57, 42, 171),
                  ),
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
                  icon: Icons.tune,
                  title: "Preferences",
                  onTap: () {
                  
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.settings,
                  title: "Setting",
                  onTap: () {
                
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.language,
                  title: "Language",
                  onTap: () {
                  
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.help_outline,
                  title: "Help",
                  onTap: () {
                  
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {
                    logout();
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
