// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    required this.labelText,
    this.hintText,
    this.onChange,
    this.validator,
  });
  final String labelText;
  final String? hintText;
  final Function(String?)? onChange;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.greenAccent,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xff7B8789),
          fontFamily: 'Brown',
          fontStyle: FontStyle.normal,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.pinkAccent,
          fontFamily: 'Brown',
          fontStyle: FontStyle.normal,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff4C5067),
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        fillColor: const Color(0xff1F2128),
        filled: true,
      ),
      onChanged: onChange,
      validator: validator,
    );
  }
}
