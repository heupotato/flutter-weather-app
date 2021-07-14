import 'package:flutter/material.dart';
import 'package:flutter_weather/packages/dafluta/widgets/vbox.dart';
import 'package:flutter_weather/widgets/measure_size.dart';

class WeatherDayDetailList extends StatefulWidget {
  final List<Widget> weatherInfoDay;
  const WeatherDayDetailList({Key? key, required this.weatherInfoDay}) : super(key: key);

  @override
  _WeatherDayDetailListState createState() => _WeatherDayDetailListState();
}

class _WeatherDayDetailListState extends State<WeatherDayDetailList> {
  GlobalKey _key= GlobalKey();
  double defaultWidth = 100;
  var myChildSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          MeasureSize(
            onChange: (size) {
              setState(() {
                myChildSize = size;
              });
            },
            child: Row(
              key: _key,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...widget.weatherInfoDay
              ],
          )),
          VBox(20),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            height: 50,
            width: myChildSize.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black54),
          ),
        ]
    );
  }
}
