import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final TextInputType typeKeyboard;
  final TextEditingController controller;
  final String text;
  final Color color;
  const TextFieldCustom({
    super.key,
    required this.controller,
    required this.text,
    required this.typeKeyboard,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: TextField(
        keyboardType: typeKeyboard,
        style: TextStyle(
          color: color,
        ),
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: color,
              width: 2.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
