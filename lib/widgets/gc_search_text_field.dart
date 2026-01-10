// ==========================
// lib/widgets/gc_search_text_field.dart
// ==========================
import 'package:flutter/material.dart';

class GCSearchTextField extends StatelessWidget {
  const GCSearchTextField({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF66CFCB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
          suffixIcon: const Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }
}
