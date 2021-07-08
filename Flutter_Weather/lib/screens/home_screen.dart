import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/services/logger.dart';
import 'package:flutter_weather/storage/json_repositories/weather_data_repository.dart';
import 'package:flutter_weather/widgets/custom_app_bar.dart';
import 'package:flutter_weather/widgets/drawers/control_drawer.dart';
import 'package:flutter_weather/widgets/weather_info_widget.dart';

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
        leading: Builder(
          builder: (context){
            return IconButton(
              icon: Icon(Icons.menu_sharp, size: 40),
              onPressed: (){
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
        actions: [
          Builder(
            builder: (context){
              return IconButton(
                icon: Icon(Icons.add, size: 40),
                onPressed: () {},
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image(
            image: AssetImage(Assets.weatherImage),
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
      ),
      drawer: DrawerControlWidget()
    );
  }
}
