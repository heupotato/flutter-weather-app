import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/screens/search_screen.dart';
import 'package:flutter_weather/services/logger.dart';
import 'package:flutter_weather/storage/json_repositories/weather_data_repository.dart';
import 'package:flutter_weather/widgets/custom_app_bar.dart';
import 'package:flutter_weather/widgets/dialogs/loading_dialog.dart';
import 'package:flutter_weather/widgets/drawers/control_drawer.dart';
import 'package:flutter_weather/widgets/weather_day_detail_widget.dart';
import 'package:flutter_weather/widgets/weather_detail_box_widget.dart';
import 'package:flutter_weather/widgets/weather_info_widget.dart';
import 'package:flutter_weather/models/weather_extension.dart';
import 'package:flutter_weather/widgets/weather_week_detail_widget.dart';
import 'package:flutter_weather/models/index.dart' as indexLib;

class HomeScreen extends StatefulWidget {
  final indexLib.Place place;
  const HomeScreen({Key? key, required this.place}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
    Logger.logInfo(
        className: "Home Screen",
        methodName: "initState",
        message: "Open Home Screen");
  }

  Future<Weather> _getMockData() async
  => await WeatherDataRepository.getData();

  Future<Weather> _getData() async{
    List<double> coordinates = widget.place.geometry.coordinates;

    final GetWeatherDataCity gwc = GetWeatherDataCity();
    final HttpResult<Weather> result = await gwc.call(coordinates.first, coordinates.last);
    Weather retrievedWeather = result.data;
    retrievedWeather.timeOffset = widget.place.timeOffset ?? 0;
    return retrievedWeather;
}

  _gotoSearchScreen(){
    Navigator.push(context,
        CustomPageTransition(type: PageTransitionType.rightToLeft, child: SearchScreen()));
  }

  Container _loadingPage(){
    return Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Loading result...'),
                )
              ],
            )
        ));
  }


  @override
  Widget build(BuildContext context) {
    String cityTitle = widget.place.text;
    int timeOffset = widget.place.timeOffset ?? 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppBarLabel(city: cityTitle, timeOffset: timeOffset),
        leading: Builder(
          builder: (context){
            return IconButton(
              icon: Icon(Icons.menu_sharp, size: 40),
              onPressed: () => Scaffold.of(context).openDrawer()
          );
        },
      ),
        actions: [
          Builder(
            builder: (context){
              return IconButton(
                icon: Icon(Icons.add, size: 40),
                onPressed: () => _gotoSearchScreen(),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Weather>(
        future: _getData(),
        builder: (context, snapshot){
          Widget child = Container(child: Text("loading"));
          if (snapshot.hasData){
            Logger.logInfo(
                className: "Home Screen",
                methodName: "Build",
                message: "Retrieve data successfully");
            Weather mockWeatherData = snapshot.data!;
            DayWeather todayData = mockWeatherData.today;
            WeatherData ? nowData = todayData.weatherNow;
            List<DayWeather> weekData = mockWeatherData.allAvailableDays();
            if (nowData != null )
              child = Stack(
                children: [
                  Image(
                    image: AssetImage(Assets.weatherImage),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(decoration: BoxDecoration(color: Colors.black26)),
                  DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      maxChildSize: 0.85,
                      minChildSize: 0.5,
                      builder: (context, scrollController){
                        return ListView(
                          padding: EdgeInsets.all(0),
                          controller: scrollController,
                          children: [WeatherInfo(
                            weatherType: nowData.weather,
                            upperLimitTemp: todayData.upperLimitTemp*1.0,
                            lowerLimitTemp: todayData.lowerLimitTemp*1.0,
                            currentTemp: nowData.temp2m*1.0,
                          ),
                            WeatherDayDetail(mockWeatherData: mockWeatherData),
                            WeatherWeekDetail(mockWeatherData: mockWeatherData),
                            WeatherDetailBox(weekWeather: weekData)
                          ],
                        );
                      }
                  )
                ],
              );
            else child = Container(
                child: Center(child: Text("Cannot retrieve data")));
          }
          else if (snapshot.hasError){
            Logger.logError(
                className: "HomeScreen",
                methodName: "build",
                message: snapshot.error.toString()
            );
            child = Container(
              child: Text("Error"),
            );
          }
          else child = _loadingPage();
          return child;
        }
      ),
      drawer: DrawerControlWidget()
    );
  }
}
