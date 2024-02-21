import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    required this.fontWeight,
    required this.fontsize,
    this.color = Colors.black,
    this.textAlign,
    this.lineThrough,
    this.letterSpacing,
    this.overflow,
  }) : super(key: key);
  final String text;
  final double fontsize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final TextDecoration? lineThrough;
  final double? letterSpacing;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
        decoration: lineThrough,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
