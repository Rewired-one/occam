import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:occam/constants/colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    this.text = '',
    this.onPressed,
    this.fontSize = 19.0,
    this.padding = EdgeInsets.zero,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      disabledColor: const Color.fromRGBO(99, 99, 99, 0.1),
      disabledTextColor: AppTheme.inactive,
      color: const Color.fromRGBO(99, 99, 99, 0.1),
      textColor: const Color(0xFFCB4EE8),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      padding: padding,
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
