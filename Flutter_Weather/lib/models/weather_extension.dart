import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/services/date_formatter.dart';
import 'package:intl/intl.dart';

extension ProcessMockJsonData on Weather{
  //int getInitTime() => int.parse(init.substring(init.length - 2, init.length));

  get initDate => yearMonthDayHour(init);//DateFormatter.yearMonthDay(init.substring(0, init.length -2));

  DateTime getTrueDate(int timePoint) => this.initDate.add(Duration(hours: timePoint));

  List<DateTime> getTrueDates(List<WeatherData> dataList)
  => dataList.map((data) => this.getTrueDate(data.timepoint)).toList();

  List<String> getWeekDays()
  => this.getTrueDates(this.getWeekData()).map((trueDate) => DateFormatter.weekDay(trueDate)).toList();

  List<int> getWeekDayIndex(){
    List<int> indexes = [0];
    int prev = 0;
    for (int i = 1; i < dataseries.length; i++){
      if (getTrueDate(dataseries[i].timepoint).day > getTrueDate(dataseries[prev].timepoint).day){
        prev = i;
        indexes.add(i);
      }
    }
    return indexes;
  }

  List<WeatherData> getWeekData(){
    final indexList = this.getWeekDayIndex();
    List<WeatherData> weekData = [];
    ///seven days of week
    for (int i = 0; i < 8; i++)
      weekData.add(dataseries[indexList[i]]);
    return weekData;
  }

  List<WeatherData> getDayData(){
    List<WeatherData> dayData= [];
    int day = this.initDate.day;
    for (int i = 0; i<dataseries.length; i++){
      if (this.getTrueDate(dataseries[i].timepoint).day != day)
        break;
      dayData.add(dataseries[i]);
    }
    ///5 time points are necessary, add more if today's time points aren't enough
    while (dayData.length < 5)
      dayData.add(dataseries[dayData.length]);
    return dayData;
  }

  DateTime yearMonthDayHour(String initDate){
    final year = initDate.substring(0, 4);
    final month = initDate.substring(4, 6);
    final day = initDate.substring(6, 8);
    final hour = initDate.substring(8, initDate.length);
    return DateFormat('yyyy MM dd hh').parse("$year $month $day $hour", true);
  }

  WeatherData nowData(int nowHour){
    final List<WeatherData> dayData = this.getDayData();
    WeatherData res = dayData[dayData.length - 1];
    for (int i = 0; i < dayData.length; i++){
      int hour = this.getTrueDate(dayData[i].timepoint).hour;
      if (hour > nowHour) {
        int prevHour = this.getTrueDate(dayData[i - 1].timepoint).hour;
        if ((hour - nowHour).abs() < (hour - prevHour).abs())
          return dayData[i];
        return dayData[i -1];
      }
    }
    return res;
  }

  get upperLimitTemp{
    final List<WeatherData> dayData = this.getDayData();
    int max = 0;
    dayData.forEach((hourData) {
      if (hourData.temp2m > max) max = hourData.temp2m;
    });
    return max;
  }

  get lowerLimitTemp{
    final List<WeatherData> dayData = this.getDayData();
    int min = 55;
    dayData.forEach((hourData) {
      if (hourData.temp2m < min) min = hourData.temp2m;
    });
    return min;
  }
}
