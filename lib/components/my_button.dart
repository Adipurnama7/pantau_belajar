import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color? color;
  final Widget? child;
  MyButton({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Center(
          child: child
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
