import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final TextEditingController textEditingController;
  final bool obscureText;
  final TextInputType? textInputType;
  final int? maxlength;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.textEditingController,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.maxlength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxlength,
      obscureText: obscureText,
      controller: textEditingController,
      cursorColor: Colors.grey[800],
      keyboardType: textInputType,
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
