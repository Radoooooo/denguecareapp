import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputPasswordWidget extends StatelessWidget {
  const InputPasswordWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.obscureText,
      required this.iconButton});

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final IconButton iconButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: iconButton),
      ),
    );
  }
}
