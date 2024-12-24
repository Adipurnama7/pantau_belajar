import 'package:flutter/material.dart';
import 'package:pantau_belajar/pages/login_page.dart';
import 'package:pantau_belajar/pages/lupa_password_page.dart';
import 'package:pantau_belajar/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LupaPasswordPage(),
    );
  }
}
