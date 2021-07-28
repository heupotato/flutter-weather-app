import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/models/weather_extension.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';

class WeatherDetailBox extends StatelessWidget {
  final List<DayWeather> weekWeather;
  WeatherDetailBox({Key? key, required this.weekWeather}) : super(key: key);

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
    DayWeather todayWeather = weekWeather.first;
    DayWeather ? tomorrowWeather = (weekWeather.length > 1) ? weekWeather[1] : null;
    final DateTime now = DateTime.now().toUtc().add(Duration(hours: todayWeather.timeOffset ));
    List<Widget> weatherText = (now.hour < 18) ? List.from(dayTimeDetail(todayWeather, tomorrowWeather))
                                : List.from(nightDetail(todayWeather, tomorrowWeather));
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
                  TableCell(child: tableInfo(todayWeather))
                ]
              )
            ],
          ),
          ...weatherText
        ],
      ),
    );
  }

  Table tableInfo(DayWeather todayWeather){
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

  Text todayText(DayWeather todayWeather){
    WeatherData todayData = todayWeather.todayTypicalWeather;
    return Text(
      "Today is ${todayData.weather} with a high of ${todayWeather.todayMaxTemp}° "
          "and a ${todayData.precipitation} chance of precipitation. "
          "Winds ${todayWeather.todayWindDirection} at ${todayData.windSpeed}",
      style: TextStyle(
        color: Colors.white,
        fontSize: 15
      ),
    );
  }

  Text tonightText(DayWeather todayWeather, DayWeather ? tomorrowWeather){
    WeatherData tonightData = todayWeather.tonightTypicalWeather(tomorrowWeather);
    return Text(
        "Tonight is ${tonightData.weather}. "
            "Winds ${todayWeather.tonightWindDirection(tomorrowWeather)} at ${tonightData.windSpeed}."
            "The overnight low will be ${todayWeather.tonightMinTemp(tomorrowWeather)}°.",
      style: TextStyle(
          color: Colors.white,
          fontSize: 15
      ),
    );
  }

  Text tomorrowText(DayWeather ? tomorrowWeather){
    if (tomorrowWeather == null)
      return Text("There isn't any weather forecast for tomorrow",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15));
    WeatherData tomorrowData = tomorrowWeather.todayTypicalWeather;
    return Text(
      "Tomorrow will be ${tomorrowData.weather} with a high of ${tomorrowWeather.todayMaxTemp}° "
          "and a ${tomorrowData.precipitation} chance of precipitation. "
          "Winds ${tomorrowWeather.todayWindDirection} at ${tomorrowData.windSpeed}",
      style: TextStyle(
          color: Colors.white,
          fontSize: 15
      ),
    );
  }

  List<Widget> dayTimeDetail(DayWeather todayWeather, DayWeather ? tomorrowWeather){
    return[
      VBox(15),
      todayText(todayWeather),
      VBox(15),
      tonightText(todayWeather, tomorrowWeather)
    ];
  }

  List<Widget> nightDetail(DayWeather todayWeather, DayWeather ? tomorrowWeather){
    return [
      VBox(15),
      tonightText(todayWeather, tomorrowWeather),
      VBox(15),
      tomorrowText(tomorrowWeather)
    ];
  }
}
