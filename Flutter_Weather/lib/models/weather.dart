import 'package:flutter/foundation.dart';
import 'weather_data.dart';

@immutable
class Weather {

  const Weather({
    required this.product,
    required this.init,
    required this.dataseries,
  });

  final String product;
  final String init;
  final List<WeatherData> dataseries;

  factory Weather.fromJson(Map<String,dynamic> json) => Weather(
    product: json['product'] as String,
    init: json['init'] as String,
    dataseries: (json['dataseries'] as List? ?? []).map((e) => WeatherData.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'product': product,
    'init': init,
    'dataseries': dataseries.map((e) => e.toJson()).toList()
  };

  Weather clone() => Weather(
    product: product,
    init: init,
    dataseries: dataseries.map((e) => e.clone()).toList()
  );


  Weather copyWith({
    String? product,
    String? init,
    List<WeatherData>? dataseries
  }) => Weather(
    product: product ?? this.product,
    init: init ?? this.init,
    dataseries: dataseries ?? this.dataseries,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Weather && product == other.product && init == other.init && dataseries == other.dataseries;

  @override
  int get hashCode => product.hashCode ^ init.hashCode ^ dataseries.hashCode;

}
