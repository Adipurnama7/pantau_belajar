import 'package:flutter/material.dart';
import 'package:pantau_belajar/pages/home_page.dart';
import 'package:pantau_belajar/pages/login_page.dart';
<<<<<<< HEAD
import 'package:pantau_belajar/pages/lupa_password_page.dart';
import 'package:pantau_belajar/pages/register_page.dart';
=======
import 'package:pantau_belajar/pages/main_page.dart';
>>>>>>> fe00cd5a926867499e655ab143a885d34ed35ee4

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: LupaPasswordPage(),
=======
      home: MainPage(),
>>>>>>> fe00cd5a926867499e655ab143a885d34ed35ee4
    );
  }
}
