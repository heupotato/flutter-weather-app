import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final GestureTapCallback? onTap;

  const Label({
    required this.text,
    this.color = Palette.primaryText,
    this.size = 14,
    this.weight = FontWeight.normal,
    this.align,
    this.maxLines,
    this.overflow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        maxLines: maxLines,
        textAlign: align,
        overflow: overflow,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
        ),
      ),
    );
  }
}
