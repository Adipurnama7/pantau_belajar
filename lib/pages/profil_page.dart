import 'package:flutter/material.dart';
class profilePage extends StatelessWidget {
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
                ProfileMenuItem(icon: Icons.person, title: "Account"),
                ProfileMenuItem(icon: Icons.tune, title: "Preferences"),
                ProfileMenuItem(icon: Icons.settings, title: "Setting"),
                ProfileMenuItem(icon: Icons.language, title: "Language"),
                ProfileMenuItem(icon: Icons.help_outline, title: "Help"),
                ProfileMenuItem(icon: Icons.logout, title: "Logout"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  ProfileMenuItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            leading: Icon(icon, color: Colors.black),
            title: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            thickness: 1,
            color: Colors.grey.shade300,
            height: 1,
          ),
        ),
      ],
    );
  }
}