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
    fontSize: 17,
  );
  
  @override
  Widget build(BuildContext context) {
    final Weather mockWeatherData = widget.mockWeatherData;
    final List<DayWeather> allAvailableDays = mockWeatherData.allAvailableDays();

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          weekDetailTitle(),
          ...weatherRows(allAvailableDays)
        ],
      )
    );
  }

  ListTile weekDetailTitle(){
    return  ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        leading: Icon(Icons.add, color: Colors.transparent),
        title: Transform.translate(offset: Offset(-16, 0),
            child: Align(alignment: Alignment.centerLeft,child: CustomFlexRow(
              flex1: 3, child1: Text(""),
              flex2: 3, child2: Text(""),
              flex3: 2, child3: Align(
                alignment: Alignment.centerLeft,
                child:Text("High", style: titleStyle)),
              flex4: 2, child4: Align(
                alignment: Alignment.centerLeft,
                child: Text("Low", style: titleStyle))))));
  }

  List<Theme> weatherRows(List<DayWeather> allAvailableDays){
    return allAvailableDays.map((dayWeather) => weatherRow(dayWeather)).toList();
  }

  Theme weatherRow(DayWeather dayWeather){
    WeatherInfoDay weatherInfoDay = WeatherInfoDay(dayData: dayWeather);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CustomExpansionTile(
          tilePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          childrenPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          backgroundColor: Colors.white12,
          collapsedBackgroundColor: Colors.transparent,
          title: Transform.translate(offset: Offset(-10, 0), child: CustomFlexRow(
            flex1: 3, child1: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(dayWeather.weekDay, style: cellStyle, textAlign: TextAlign.left)),
            flex2: 3, child2: WeatherTypeIcon(weather: dayWeather.typicalWeather),
            flex3: 2, child3: Align(
              alignment: Alignment.centerLeft,
              child:Text("${dayWeather.upperLimitTemp}°", style: cellStyle)),
            flex4: 2, child4: Align(
              alignment: Alignment.centerLeft,
              child: Text("${dayWeather.lowerLimitTemp}°", style: cellStyle)))),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5,10,5, 10),
              child:
                weatherInfoDay)
          ]
      )));
  }
}
