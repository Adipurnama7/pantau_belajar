import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pantau_belajar/pages/home_page.dart';
import 'package:pantau_belajar/pages/profile_page.dart';
import 'package:pantau_belajar/pages/schedule_page.dart';

class MainPage extends StatefulWidget {
  final int? bottomNavIdx;
  const MainPage({super.key, this.bottomNavIdx});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController searchController = TextEditingController();
  int myIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.bottomNavIdx != null) {
      myIndex = widget.bottomNavIdx!;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  final List<Widget> tabs = [
    HomePage(),
    SchedulePage(),
    ProfilePage(), // Halaman untuk notifikasi
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[myIndex], // Menampilkan halaman sesuai indeks
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color.fromARGB(255, 57, 42, 171),
        animationDuration: const Duration(milliseconds: 300),
        index: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
