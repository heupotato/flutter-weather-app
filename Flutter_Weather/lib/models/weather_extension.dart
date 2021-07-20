import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/services/date_formatter.dart';
import 'package:flutter_weather/services/logger.dart';
import 'package:intl/intl.dart';

extension TimeHandlerWeather on Weather{
  DateTime get initDate => yearMonthDayHour(init);

  DateTime getTrueDate(int timePoint) => this.initDate.add(Duration(hours: timePoint));

  DateTime yearMonthDay(DateTime datetime) => DateTime(datetime.year, datetime.month, datetime.day);

  DateTime yearMonthDayHour(String initDate){
    final year = initDate.substring(0, 4);
    final month = initDate.substring(4, 6);
    final day = initDate.substring(6, 8);
    final hour = initDate.substring(8, initDate.length);
    return DateFormat('yyyy MM dd hh').parse("$year $month $day $hour", true);
  }
}

extension TimeHandlerWeatherData on WeatherData{
  DateTime getTrueDate(DateTime initDate) => initDate.add(Duration(hours:  this.timepoint));
  
  String localTime(DateTime initDate){
   return DateFormatter.time(this.getTrueDate(initDate));
  }
}

extension DayWeatherExtension on Weather{

  List<DayWeather> allDays() {
    List<DayWeather> allDays = [];
    final Map<DateTime, List<WeatherData>> allDaysData =
      groupBy(dataseries, (WeatherData data) {
        return this.yearMonthDay(this.getTrueDate(data.timepoint));
      });
    allDaysData.forEach((key, value) {allDays.add(DayWeather(weathers: value, initDate: this.initDate)); });
    return allDays;
  }

  List<DayWeather> allAvailableDays(){
    DateTime now = DateTime.now().add(Duration(minutes: this.timeOffset ?? 0));
    DateTime yesterday = DateTime(now.year, now.month, now.day).subtract(Duration(hours: 1));
    return this.allDays().where((day) =>
    yesterday.isBefore(this.getTrueDate(day.weathers.first.timepoint).toUtc())).toList();
  }
  DayWeather get today => this.allAvailableDays().first;

}

extension WeatherDataExtension on WeatherData{
  String get cloudCoverage{
    switch (cloudcover){
      case 1:
        return "0% - 6%";
      case 2:
        return "6% - 19%";
      case 3:
        return "19% - 31%";
      case 4:
        return "31% - 44%";
      case 5:
        return "44% - 56%";
      case 6:
        return "56% - 69%";
      case 7:
        return "69% - 81%";
      case 8:
        return "81% - 94%";
      case 9:
        return "94% - 100%";
      default:
        return "invalid";
    }
  }

  String get precipitation{
    switch (precAmount){
      case 1:
        return "0-0.25mm/hr";
      case 2:
        return "0.25-1mm/hr";
      case 3:
        return "1-4mm/hr";
      case 4:
        return "4-10mm/hr";
      case 5:
        return "10-16mm/hr";
      case 6:
        return "16-30mm/hr";
      case 7:
        return "30-50mm/hr";
      case 8:
        return "50-75mm/hr";
      case 9:
        return "Over 75mm/hr";
      default:
        return "None";
    }
  }

  String get windSpeed{
    int speed = wind10m.speed;
    switch (speed){
      case 1:
        return "below 0.3m/s ";
      case 2:
        return "0.3-3.4m/s";
      case 3:
        return "3.4-8.0m/s";
      case 4:
        return "8.0-10.8m/s";
      case 5:
        return "10.8-17.2m/s";
      case 6:
        return "17.2-24.5m/s";
      case 7:
        return "24.5-32.6m/s";
      case 8:
        return "Over 32.6m/s";
      default:
        return "invalid";
    }
  }

  String get windDirection => wind10m.direction;
}


class DayWeather{
  final DateTime initDate;
  final List<WeatherData> weathers;
  const DayWeather({required this.weathers, required this.initDate});

  String get weekDay{
    return DateFormatter.weekDay(initDate.add(Duration(hours: weathers.first.timepoint)));
  }

  WeatherData get weatherNow{
    DateTime now = DateTime.now().toUtc();
    WeatherData weatherNow = weathers.firstWhere((weatherData) =>
      now.difference(initDate.add(Duration(hours: weatherData.timepoint)).toUtc()).abs().inMinutes <= 90);
    return weatherNow;
  }

  WeatherData get typicalWeather{
    WeatherData typicalWeather = weathers.first;
    int max = 0;
    final Map<String, List<WeatherData>> allWeathers =
    groupBy(weathers, (WeatherData weather) {
      return weather.weather;
    });
    allWeathers.forEach((key, value) {
      if (value.length > max){
        max = value.length;
        typicalWeather = value.first;
      }
    });
    return typicalWeather;
  }

  int get upperLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(max);

  int get lowerLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(min);
  
  List<WeatherData> get todayWeathers{
    return weathers.where(
            (weather) => initDate.add(Duration(hours: weather.timepoint)).hour <18
                && initDate.add(Duration(hours: weather.timepoint)).hour >=6
    ).toList();
  }
  
  WeatherData get todayTypicalWeather{
    WeatherData typicalWeather = this.todayWeathers.first;
    int max = 0;
    final Map<String, List<WeatherData>> allWeathers =
    groupBy(this.todayWeathers, (WeatherData weather) {
      return weather.weather;
    });
    allWeathers.forEach((key, value) {
      if (value.length > max){
        max = value.length;
        typicalWeather = value.first;
      }
    });
    return typicalWeather;
  }

  int get todayMaxTemp{
    int maxTemp = todayTypicalWeather.temp2m;
    todayWeathers.forEach((weather) {
      if (weather.temp2m > maxTemp){
        maxTemp = weather.temp2m;
      }
    });
    return maxTemp;
  }

  String get todayWindDirection{
    Map<String, List<WeatherData>> windDirections =
    groupBy(todayWeathers, (WeatherData weather) {
      return weather.windDirection;
    });
    if (windDirections.length > 2) return "are variable";
    else if (windDirections.length == 2){
      String firstDirection = todayWeathers.first.windDirection;
      String changedDirection = todayWeathers.firstWhere(
              (weather) => weather.windDirection != firstDirection).windDirection;
      return "from $firstDirection to $changedDirection}";
    }
    else return "to ${todayWeathers.first.windDirection}";
  }

  List<WeatherData> tonightWeathers(DayWeather ? tomorrow){
    List<WeatherData> tonightWeathers = weathers.where((weather) => initDate.add(Duration(hours: weather.timepoint)).hour <23
    && initDate.add(Duration(hours: weather.timepoint)).hour >= 18).toList();
    if (tomorrow != null) tonightWeathers.addAll(
        tomorrow.weathers.where((weather) => initDate.add(Duration(hours: weather.timepoint)).hour < 6)
    );
    return tonightWeathers;
  }

  WeatherData tonightTypicalWeather(DayWeather ? tomorrow){
    List<WeatherData> tonightWeathersList = List.from(tonightWeathers(tomorrow));
    WeatherData typicalWeather = tonightWeathersList.first;
    int max = 0;
    final Map<String, List<WeatherData>> allTonightWeathers =
    groupBy(tonightWeathersList, (WeatherData weather) {
      return weather.weather;
    });
    allTonightWeathers.forEach((key, value) {
      if (value.length > max){
        max = value.length;
        typicalWeather = value.first;
      }
    });
    return typicalWeather;
  }

  int tonightMinTemp(DayWeather ? tomorrow){
    List<WeatherData> tonightWeathersList = List.from(tonightWeathers(tomorrow));
    int minTemp = tonightTypicalWeather(tomorrow).temp2m;
    tonightWeathersList.forEach((weather) {
      if (weather.temp2m < minTemp){
        minTemp = weather.temp2m;
      }
    });
    return minTemp;
  }

  String tonightWindDirection(DayWeather ? tomorrow){
    List<WeatherData> tonightWeathersList = List.from(tonightWeathers(tomorrow));
    Map<String, List<WeatherData>> windDirections =
    groupBy(tonightWeathersList, (WeatherData weather) {
      return weather.windDirection;
    });
    if (windDirections.length > 2) return "are variable";
    else if (windDirections.length == 2){
      String firstDirection = tonightWeathersList.first.windDirection;
      String changedDirection = tonightWeathersList.firstWhere(
              (weather) => weather.windDirection != firstDirection).windDirection;
      return "from $firstDirection to $changedDirection";
    }
    else return "are to ${tonightWeathersList.first.windDirection}";
  }
}

extension WeekWeatherExtension on Weather{
  List<String> get weekDays
  => this.getTrueDates(this.weekDayIndexes).map((trueDate) => DateFormatter.weekDay(trueDate)).toList();

  List<DayWeather> allDays() {
    List<DayWeather> allDays = [];
    final Map<DateTime, List<WeatherData>> allDaysData =
      groupBy(dataseries, (WeatherData data) {
        return this.yearMonthDay(this.getTrueDate(data.timepoint));
      });
    allDaysData.forEach((key, value) {allDays.add(DayWeather(weathers: value, initDate: this.initDate)); });
    return allDays;
  }

  List<DayWeather> allAvailableDays(){
    return this.allDays().where((day) =>
    DateTime.now().isBefore(this.getTrueDate(day.weathers[0].timepoint))).toList();
  }

  DayWeather get today => this.allAvailableDays().first;
}

class DayWeather{
  final DateTime initDate;
  final List<WeatherData> weathers;
  const DayWeather({required this.weathers, required this.initDate});

  String get weekDay{
    return DateFormatter.weekDay(initDate.add(Duration(hours: weathers.first.timepoint)));
  }

  WeatherData get weatherNow{
    DateTime now = DateTime.now().toUtc();
    WeatherData weatherNow = weathers.firstWhere((weatherData) =>
      now.difference(initDate.add(Duration(hours: weatherData.timepoint)).toUtc()).abs().inMinutes <= 90);
    return weatherNow;
  }

  String get typicalWeather{
    String typicalWeather = "";
    int max = 0;
    final Map<String, List<WeatherData>> allWeathers =
    groupBy(weathers, (WeatherData weather) {
      return weather.weather;
    });
    allWeathers.forEach((key, value) {
      if (value.length > max){
        max = value.length;
        typicalWeather = key;
      }
    });
    return typicalWeather;
  }

  int get upperLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(max);

  int get lowerLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(min);
}