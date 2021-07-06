import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'labels/label.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double minWidth;
  final Color backgroundColor;
  final bool loading;
  final VoidCallback? onPressed;

  const CustomButton(
      {required this.title,
      this.minWidth = 60,
      this.backgroundColor = Palette.primary,
      this.onPressed,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      disabledColor: Palette.primary.withOpacity(0.5),
      minWidth: minWidth,
      height: 46,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) =>
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
            minimumSize: MaterialStateProperty.resolveWith<Size>(
                (states) => Size(minWidth, 36)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return backgroundColor.withOpacity(0.5);
              } else {
                return backgroundColor;
              }
            })),
        child: loading
            ? SizedBox(
                child: CircularProgressIndicator(
                    color: Palette.white, strokeWidth: 2.5),
                height: 20,
                width: 20,
              )
            : Label(
                text: title,
                size: 16,
                weight: FontWeight.w600,
                align: TextAlign.center,
                color: Palette.white),
      ),
    );
  }
}
