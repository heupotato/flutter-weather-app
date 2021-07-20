import 'package:flutter/foundation.dart';
import 'weather_data.dart';

@immutable
class Weather {

  Weather({
    required this.product,
    required this.init,
    required this.dataseries,
    this.timeOffset,
  });

  final String product;
  final String init;
  final List<WeatherData> dataseries;
  int ? timeOffset = 0;

  factory Weather.fromJson(Map<String,dynamic> json) => Weather(
    product: json['product'] as String,
    init: json['init'] as String,
    dataseries: (json['dataseries'] as List? ?? []).map((e) => WeatherData.fromJson(e as Map<String, dynamic>)).toList(),
    timeOffset: json['timeOffset']!=null ? json['timeOffset'] as int : 0
  );
  
  Map<String, dynamic> toJson() => {
    'product': product,
    'init': init,
    'dataseries': dataseries.map((e) => e.toJson()).toList(),
    'timeOffset': timeOffset
  };

  Weather clone() => Weather(
    product: product,
    init: init,
    dataseries: dataseries.map((e) => e.clone()).toList(),
      timeOffset: timeOffset
  );


  Weather copyWith({
    String? product,
    String? init,
    List<WeatherData>? dataseries,
    int? timeOffset
  }) => Weather(
    product: product ?? this.product,
    init: init ?? this.init,
    dataseries: dataseries ?? this.dataseries,
    timeOffset: timeOffset ?? this.timeOffset
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Weather && product == other.product && init == other.init && dataseries == other.dataseries;

  @override
  int get hashCode => product.hashCode ^ init.hashCode ^ dataseries.hashCode;

}
