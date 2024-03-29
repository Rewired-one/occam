import 'package:flutter/material.dart';
import 'package:occam/constants/colors.dart';

/// Standard TextFormField Widget
class InputWidget extends StatefulWidget {
  const InputWidget({
    this.controller,
    this.labelText,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);
  final String? labelText;
  final TextEditingController? controller;
  final Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  final bool obscureText;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _obscureState = false;

  @override
  void initState() {
    _obscureState = widget.obscureText ? widget.obscureText : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureState,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureState = !_obscureState;
            });
          },
          icon: Icon(_obscureState ? Icons.visibility : Icons.visibility_off),
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          fontSize: 13,
          color: AppTheme.inactive,
          fontStyle: FontStyle.normal,
        ),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
