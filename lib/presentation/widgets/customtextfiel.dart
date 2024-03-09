import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String text;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.text,
    required this.labelText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 15),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )),
        ),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.black38),
          cursorColor: Colors.black87,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black38),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.black87),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ),
      ],
    );
  }
}
