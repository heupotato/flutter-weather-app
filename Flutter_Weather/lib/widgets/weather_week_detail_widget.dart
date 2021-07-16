import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/models/weather_extension.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';

class WeatherWeekDetail extends StatefulWidget {
  final Weather mockWeatherData;
  const WeatherWeekDetail({Key? key, required this.mockWeatherData}) : super(key: key);

  @override
  _WeatherWeekDetailState createState() => _WeatherWeekDetailState();
}

class _WeatherWeekDetailState extends State<WeatherWeekDetail> {
  final TextStyle titleStyle = TextStyle(
    color: Colors.white, 
    fontSize: 17,
    fontWeight: FontWeight.bold
  );

  final TextStyle cellStyle = TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
  
  @override
  Widget build(BuildContext context) {
    final Weather mockWeatherData = widget.mockWeatherData;
    final List<DayWeather> allAvailableDays = mockWeatherData.allAvailableDays();
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Table(
        border: TableBorder.symmetric(),
        columnWidths: {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(1.5),
          3: FlexColumnWidth(1.5)
        },
        children: [
          TableRow(
            children: [
              TableCell(child: SizedBox(height: 30, child: Text("Daily Forecast", style: titleStyle))),
              TableCell(child: SizedBox(height: 30, child: Text(""))),
              TableCell(child: SizedBox(height: 30, child: Text("High", style: titleStyle))),
              TableCell(child: SizedBox(height: 30, child: Text("Low", style: titleStyle)))
            ],
          ),
          ...weatherRows(allAvailableDays)
        ],
      ),
    );
  }

  List<TableRow> weatherRows(List<DayWeather> allAvailableDays){
    return allAvailableDays.map((weatherDay) => weatherRow(weatherDay)).toList();
  }

  TableRow weatherRow(DayWeather weatherDay){
    return TableRow(
      children: [
        TableCell(child: SizedBox(height: 40, child: Text(weatherDay.typicalWeather, style: cellStyle))),
        TableCell(child: SizedBox(height: 40, child:WeatherTypeIcon(weather: weatherDay.typicalWeather))),
        TableCell(child: SizedBox(height: 40, child:Text("${weatherDay.upperLimitTemp}°", style: cellStyle))),
        TableCell(child: SizedBox(height: 40, child:Text("${weatherDay.lowerLimitTemp}°", style: cellStyle)))
      ]
    );
  }
}
