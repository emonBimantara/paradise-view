import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? imageAsset;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    this.imageAsset,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: 15, color: Color(0xFF1C1C1C)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.5)),

        prefixIcon: imageAsset != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(imageAsset!, width: 25, height: 25),
              )
            : null,

        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}
