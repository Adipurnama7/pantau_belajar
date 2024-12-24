import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final TextEditingController textEditingController;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      cursorColor: Colors.grey[800],
      decoration: InputDecoration(
        hintText: hintText,
        icon: icon,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
