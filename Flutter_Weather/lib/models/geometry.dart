import 'package:flutter/foundation.dart';


@immutable
class Geometry {

  const Geometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory Geometry.fromJson(Map<String,dynamic> json) => Geometry(
    type: json['type'] as String,
    coordinates: (json['coordinates'] as List? ?? []).map((e) => double.parse(e.toString())).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'type': type,
    'coordinates': coordinates.map((e) => e.toString()).toList()
  };

  Geometry clone() => Geometry(
    type: type,
    coordinates: coordinates.toList()
  );


  Geometry copyWith({
    String? type,
    List<double>? coordinates
  }) => Geometry(
    type: type ?? this.type,
    coordinates: coordinates ?? this.coordinates,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Geometry && type == other.type && coordinates == other.coordinates;

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode;
}
