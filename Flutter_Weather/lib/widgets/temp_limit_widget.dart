import 'package:flutter/material.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/resources/palette.dart';

class TempLimit extends StatelessWidget {
  final double upperLimitTemp;
  final double lowerLimitTemp;
  const TempLimit({
    Key? key,
    required this.lowerLimitTemp,
    required this.upperLimitTemp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_upward_sharp,
          color: Palette.white,
          size: 15,),
        HBox(10),
        Text(
            "$upperLimitTemp°C",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        HBox(20),
        Icon(Icons.arrow_downward_sharp,
          color: Palette.white,
          size: 15,),
        HBox(10),
        Text(
            "$lowerLimitTemp°C",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
      ],
    );
  }
}
