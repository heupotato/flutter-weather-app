import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter_weather/services/date_formatter.dart';
import 'package:flutter_weather/services/logger.dart';
import 'package:flutter_weather/widgets/custom_app_bar.dart';
import 'package:flutter_weather/widgets/weather_info_widget.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    Logger.logInfo(
        className: "Home Screen",
        methodName: "initState",
        message: "Open Home Screen");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: AppBarLabel(city: "Da Nang City"),
        leading: Icon(Icons.menu_outlined, size: 30),
      ),
      body: Stack(
        children: [
          Image(
            image: AssetImage(Assets.WeatherImage),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(decoration: BoxDecoration(color: Colors.black26)),
          WeatherInfo(
            weatherType: "Partly Cloudy",
            upperLimitTemp: 35,
            lowerLimitTemp: 30,
            currentTemp: 32,
          )
        ],
      )
    );
  }
}
