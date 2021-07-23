import 'package:flutter/foundation.dart';
import 'geometry.dart';

@immutable
class Place {

  const Place({
    required this.id,
    required this.type,
    required this.placeType,
    required this.text,
    required this.placeName,
    required this.geometry,
  });

  final String id;
  final String type;
  final List<String> placeType;
  final String text;
  final String placeName;
  final Geometry geometry;

  factory Place.fromJson(Map<String,dynamic> json) => Place(
    id: json['id'] as String,
    type: json['type'] as String,
    placeType: (json['place_type'] as List? ?? []).map((e) => e as String).toList(),
    text: json['text'] as String,
    placeName: json['place_name'] as String,
    geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'place_type': placeType.map((e) => e.toString()).toList(),
    'text': text,
    'place_name': placeName,
    'geometry': geometry.toJson()
  };

  Place clone() => Place(
    id: id,
    type: type,
    placeType: placeType.toList(),
    text: text,
    placeName: placeName,
    geometry: geometry.clone()
  );


  Place copyWith({
    String? id,
    String? type,
    List<String>? placeType,
    String? text,
    String? placeName,
    Geometry? geometry
  }) => Place(
    id: id ?? this.id,
    type: type ?? this.type,
    placeType: placeType ?? this.placeType,
    text: text ?? this.text,
    placeName: placeName ?? this.placeName,
    geometry: geometry ?? this.geometry,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Place && id == other.id && type == other.type && placeType == other.placeType && text == other.text && placeName == other.placeName && geometry == other.geometry;

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ placeType.hashCode ^ text.hashCode ^ placeName.hashCode ^ geometry.hashCode;
}
