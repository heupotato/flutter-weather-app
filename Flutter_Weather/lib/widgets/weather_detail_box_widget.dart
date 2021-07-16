import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/models/weather_extension.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';

class WeatherDetailBox extends StatelessWidget {
  final DayWeather todayWeather;
  WeatherDetailBox({Key? key, required this.todayWeather}) : super(key: key);

  final TextStyle titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.bold
  );

  final TextStyle cellStyle = TextStyle(
    color: Colors.white,
    fontSize: 13,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Table(
            border: TableBorder.symmetric(),
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(5),
            },
            children: [
              TableRow(
                children: [
                  TableCell(child: SizedBox(height: 30, child: Text("Detail", style: titleStyle))),
                  TableCell(child: SizedBox(height: 30, child: Text(""))),
                  TableCell(child: SizedBox(height: 30, child: Text(""))),
                ]
              ),
              TableRow(
                children: [
                  TableCell(child: FittedBox(
                    child: WeatherTypeIcon(weather: todayWeather.weatherNow.weather),
                    alignment: Alignment.center,)),
                  Text(""),
                  TableCell(child: tableInfo())
                ]
              )
            ],
          ),
          VBox(15),
          todayText(),
          VBox(15),
          tonightText()
        ],
      ),
    );
  }

  Table tableInfo(){
    final WeatherData typicalWeather = todayWeather.typicalWeather;
    return Table(
      border: TableBorder.symmetric(),
      columnWidths: {
        0: FlexColumnWidth(5),
        1: FlexColumnWidth(5),
      },
      children: [
        TableRow(
            children: [
              TableCell(child: SizedBox(height: 30, child: Text("Cloud Cover", style: titleStyle))),
              TableCell(child: SizedBox(height: 30, child: Text("${typicalWeather.cloudCoverage}", style: cellStyle,))),
            ]
        ),
        TableRow(
            children: [
              TableCell(child: SizedBox(height: 30, child: Text("Humidity", style: titleStyle))),
              TableCell(child: SizedBox(height: 30, child: Text("${typicalWeather.rh2m}", style: cellStyle,))),
            ]
        ),
        TableRow(
            children: [
              TableCell(child: SizedBox(height: 30, child: Text("Lifted Index", style: titleStyle))),
              TableCell(child: SizedBox(height: 30, child: Text("${typicalWeather.liftedIndex}", style: cellStyle,))),
            ]
        ),
        TableRow(
            children: [
              TableCell(child: SizedBox(height: 30, child: Text("Precipation", style: titleStyle))),
              TableCell(child: SizedBox(height: 30, child: Text("${typicalWeather.precipitation}", style: cellStyle,))),
            ]
        ),
      ],
    );
  }

  Text todayText(){
    WeatherData todayData = todayWeather.todayTypicalWeather;
    return Text(
      "Today is ${todayData.weather} with a high of ${todayData.temp2m}° "
          "and a ${todayData.precipitation} chance of precipitation. "
          "Winds ${todayWeather.todayWindDirection} at ${todayData.windSpeed}",
      style: TextStyle(
        color: Colors.white,
        fontSize: 15
      ),
    );
  }

  Text tonightText(){
    WeatherData tonightData = todayWeather.tonightTypicalWeather;
    return Text(
        "Tonight is ${tonightData.weather}. "
            "Winds ${todayWeather.tonightWindDirection} at ${tonightData.windSpeed}."
            "The overnight low will be ${tonightData.temp2m}°.",
      style: TextStyle(
          color: Colors.white,
          fontSize: 15
      ),
    );
  }
}
