// lib/components/my_texrfield.dart
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText; // Add obscureText parameter

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.obscureText, required void Function() onChanged, // Initialize obscureText parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      obscureText: obscureText, // Pass obscureText to TextField
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        filled: true,
        fillColor: Color(0xFFF2F3F5),
        hintStyle: TextStyle(color: Color(0xFF666666)),
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
