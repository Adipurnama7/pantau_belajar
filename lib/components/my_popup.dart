import 'package:flutter/material.dart';

class MyPopup extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const MyPopup({
    super.key,
    required this.message,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Konfirmasi Hapus'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text('Hapus'),
        ),
      ],
    );
  }
}
