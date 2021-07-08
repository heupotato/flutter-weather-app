import 'package:flutter/foundation.dart';


@immutable
class WeatherData {

  const WeatherData({
    required this.timepoint,
    required this.cloudcover,
    required this.liftedIndex,
    required this.precType,
    required this.precAmount,
    required this.temp2m,
    required this.rh2m,
    required this.wind10m,
    required this.weather,
  });

  final int timepoint;
  final int cloudcover;
  final int liftedIndex;
  final String precType;
  final int precAmount;
  final int temp2m;
  final String rh2m;
  final Wind10m wind10m;
  final String weather;

  factory WeatherData.fromJson(Map<String,dynamic> json) => WeatherData(
    timepoint: json['timepoint'] as int,
    cloudcover: json['cloudcover'] as int,
    liftedIndex: json['lifted_index'] as int,
    precType: json['prec_type'] as String,
    precAmount: json['prec_amount'] as int,
    temp2m: json['temp2m'] as int,
    rh2m: json['rh2m'] as String,
    wind10m: Wind10m.fromJson(json['wind10m'] as Map<String, dynamic>),
    weather: json['weather'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'timepoint': timepoint,
    'cloudcover': cloudcover,
    'lifted_index': liftedIndex,
    'prec_type': precType,
    'prec_amount': precAmount,
    'temp2m': temp2m,
    'rh2m': rh2m,
    'wind10m': wind10m.toJson(),
    'weather': weather
  };

  WeatherData clone() => WeatherData(
    timepoint: timepoint,
    cloudcover: cloudcover,
    liftedIndex: liftedIndex,
    precType: precType,
    precAmount: precAmount,
    temp2m: temp2m,
    rh2m: rh2m,
    wind10m: wind10m.clone(),
    weather: weather
  );


  WeatherData copyWith({
    int? timepoint,
    int? cloudcover,
    int? liftedIndex,
    String? precType,
    int? precAmount,
    int? temp2m,
    String? rh2m,
    Wind10m? wind10m,
    String? weather
  }) => WeatherData(
    timepoint: timepoint ?? this.timepoint,
    cloudcover: cloudcover ?? this.cloudcover,
    liftedIndex: liftedIndex ?? this.liftedIndex,
    precType: precType ?? this.precType,
    precAmount: precAmount ?? this.precAmount,
    temp2m: temp2m ?? this.temp2m,
    rh2m: rh2m ?? this.rh2m,
    wind10m: wind10m ?? this.wind10m,
    weather: weather ?? this.weather,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is WeatherData && timepoint == other.timepoint && cloudcover == other.cloudcover && liftedIndex == other.liftedIndex && precType == other.precType && precAmount == other.precAmount && temp2m == other.temp2m && rh2m == other.rh2m && wind10m == other.wind10m && weather == other.weather;

  @override
  int get hashCode => timepoint.hashCode ^ cloudcover.hashCode ^ liftedIndex.hashCode ^ precType.hashCode ^ precAmount.hashCode ^ temp2m.hashCode ^ rh2m.hashCode ^ wind10m.hashCode ^ weather.hashCode;

  @override
  String toString() {
    super.toString();
    return("$timepoint $cloudcover");
  }
}

@immutable
class Wind10m {

  const Wind10m({
    required this.direction,
    required this.speed,
  });

  final String direction;
  final int speed;

  factory Wind10m.fromJson(Map<String,dynamic> json) => Wind10m(
    direction: json['direction'] as String,
    speed: json['speed'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'direction': direction,
    'speed': speed
  };

  Wind10m clone() => Wind10m(
    direction: direction,
    speed: speed
  );


  Wind10m copyWith({
    String? direction,
    int? speed
  }) => Wind10m(
    direction: direction ?? this.direction,
    speed: speed ?? this.speed,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Wind10m && direction == other.direction && speed == other.speed;

  @override
  int get hashCode => direction.hashCode ^ speed.hashCode;


}
