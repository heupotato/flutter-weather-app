import 'package:flutter/material.dart';

class CurrentTemp extends StatelessWidget {
  final double currentTemp;
  const CurrentTemp({Key? key, required this.currentTemp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
          "$currentTemp°",
          style: TextStyle(
            color: Colors.white,
            fontSize: 100,
          )
      ),
    );
  }
}
