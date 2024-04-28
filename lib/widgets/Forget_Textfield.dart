// lib/widgets/Forget_Textfield.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ForgetField(String label, TextEditingController controller, TextInputType? type, IconData icons) {
  return TextField(
    controller: controller,
    keyboardType: type,
    autofocus: false,
    decoration: InputDecoration(
      suffixIcon: Icon(
        icons,
        color: Colors.grey,
      ),
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Color(0xFF666666)),
      hintText: label,
      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        gapPadding: 2,
      ),
    ),
  );
}