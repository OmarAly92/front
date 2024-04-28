// lib/widgets/BuildTextfield.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BuildTextFormField(String label, TextEditingController controller,
    String? Function(String?)? validator, TextInputType type, IconData icons) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    autofocus: false,
    decoration: InputDecoration(
      prefixIcon: Icon(icons),
      filled: true,
      fillColor: const Color(0xFFF2F3F5),
      hintStyle: const TextStyle(color: Color(0xFF666666)),
      hintText: label,
      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    validator: validator,
  );
}