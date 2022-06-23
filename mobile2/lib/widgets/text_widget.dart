import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    this.textOverflow,
    this.fontWeight = FontWeight.w500,
    this.fontSize,
    this.height,
    this.color,
    Key? key,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? height;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      ),
      overflow: textOverflow,
    );
  }
}
