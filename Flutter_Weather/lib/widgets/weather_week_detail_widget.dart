import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/models/weather_extension.dart';
import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter_weather/widgets/custom_expansion_tile.dart';
import 'package:flutter_weather/widgets/custom_flex_row.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';
import 'package:flutter_weather/widgets/weather_info_day.dart';

class WeatherWeekDetail extends StatefulWidget {
  final Weather mockWeatherData;
  const WeatherWeekDetail({Key? key, required this.mockWeatherData}) : super(key: key);

  @override
  _WeatherWeekDetailState createState() => _WeatherWeekDetailState();
}

class _WeatherWeekDetailState extends State<WeatherWeekDetail> {
  bool testExpand = false;
  final TextStyle titleStyle = TextStyle(
    color: Colors.white, 
    fontSize: 17,
    fontWeight: FontWeight.bold
  );

  final TextStyle cellStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
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
      child: SizedBox(height: 300 ,child: ListView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          weekDetailTitle(),
          ...weatherRows(allAvailableDays)
        ],
      ))
    );
  }

  ListTile weekDetailTitle(){
    return  ListTile(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        leading: Icon(Icons.add, color: Colors.transparent),
        title: CustomFlexRow(
            flex1: 3, child1: Text(""),
            flex2: 3, child2: Text(""),
            flex3: 2, child3: Text("High", style: titleStyle),
            flex4: 2, child4: Text("Low", style: titleStyle)));
  }

  List<CustomExpansionTile> weatherRows(List<DayWeather> allAvailableDays){
    return allAvailableDays.map((dayWeather) => weatherRow(dayWeather)).toList();
  }

  CustomExpansionTile weatherRow(DayWeather dayWeather){
    List<Widget> weatherInfoDay = WeatherInfoDay.weatherInfoDay(dayWeather, dayWeather.initDate);
    return CustomExpansionTile(
      tilePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      childrenPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Palette.transparent,
      title: CustomFlexRow(
        flex1: 3, child1: Text(dayWeather.weekDay, style: cellStyle),
        flex2: 3, child2: WeatherTypeIcon(weather: dayWeather.typicalWeather),
        flex3: 2, child3: Text("${dayWeather.upperLimitTemp}°", style: cellStyle),
        flex4: 2, child4: Text("${dayWeather.lowerLimitTemp}°", style: cellStyle)),
      children: [
        Padding(
        padding: EdgeInsets.fromLTRB(0,0,0, 0),
          child: SizedBox(
              height: dayWeather.upperLimitTemp*5 + 10,
              child: ListView.builder(
                itemCount: weatherInfoDay.length,
                itemBuilder: (context, index) => Column(
                  children: [weatherInfoDay[index]],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                scrollDirection: Axis.horizontal,
              )
          ))
      ]
    );
  }
  //     Table(
  //       border: TableBorder.symmetric(),
  //       columnWidths: {
  //         0: FlexColumnWidth(4),
  //         1: FlexColumnWidth(3),
  //         2: FlexColumnWidth(1.5),
  //         3: FlexColumnWidth(1.5)
  //       },
  //       children: [
  //         TableRow(
  //           children: [
  //             TableCell(child: SizedBox(height: 30, child: Text(""))),
  //             TableCell(child: SizedBox(height: 30, child: Text(""))),
  //             TableCell(child: SizedBox(height: 30, child: Text("High", style: titleStyle))),
  //             TableCell(child: SizedBox(height: 30, child: Text("Low", style: titleStyle)))
  //           ],
  //         ),
  //         ...weatherRows(allAvailableDays)
  //       ],
  //     ),
  //   );
  // }
  //
  // List<TableRow> weatherRows(List<DayWeather> allAvailableDays){
  //   return allAvailableDays.map((weatherDay) => weatherRow(weatherDay)).toList();
  // }
  //
  // TableRow weatherRow(DayWeather weatherDay){
  //   return TableRow(
  //     children: [
  //       TableCell(child: SizedBox(height: 40, child: Text(weatherDay.weekDay, style: cellStyle))),
  //       TableCell(child: SizedBox(height: 40, child:WeatherTypeIcon(weather: weatherDay.typicalWeather))),
  //       TableCell(child: SizedBox(height: 40, child:Text("${weatherDay.upperLimitTemp}°", style: cellStyle))),
  //       TableCell(child: SizedBox(height: 40, child:Text("${weatherDay.lowerLimitTemp}°", style: cellStyle)))
  //     ]
  //   );
  // }
}
