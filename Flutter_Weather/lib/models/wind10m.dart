import 'package:flutter/foundation.dart';


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
