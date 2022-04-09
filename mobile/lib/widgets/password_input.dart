import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    required this.labelText,
    this.onChange,
    this.hintText,
    this.validator,
  });
  final String labelText;
  final String? hintText;
  final Function(String?)? onChange;
  final String? Function(String?)? validator;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final textController = TextEditingController();

  bool obscureState = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureState,
      style: const TextStyle(
        color: Colors.greenAccent,
      ),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureState = !obscureState;
            });
          },
          icon: Icon(obscureState ? Icons.visibility : Icons.visibility_off),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0xff7B8789),
          fontFamily: 'Brown',
          fontStyle: FontStyle.normal,
        ),
        labelText: widget.labelText,
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
      onChanged: widget.onChange,
      validator: widget.validator,
    );
  }
}
