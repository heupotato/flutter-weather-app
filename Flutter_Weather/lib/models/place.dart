import 'package:flutter/foundation.dart';
import 'geometry.dart';
import 'context.dart';


@immutable
class Place {

  const Place({
    required this.id,
    required this.type,
    required this.placeType,
    required this.relevance,
    required this.properties,
    required this.text,
    required this.placeName,
    required this.bbox,
    required this.center,
    required this.geometry,
    required this.context,
  });

  final String id;
  final String type;
  final List<String> placeType;
  final int relevance;
  final Properties properties;
  final String text;
  final String placeName;
  final List<double> bbox;
  final List<double> center;
  final Geometry geometry;
  final List<Context> context;

  factory Place.fromJson(Map<String,dynamic> json) => Place(
    id: json['id'] as String,
    type: json['type'] as String,
    placeType: (json['place_type'] as List? ?? []).map((e) => e as String).toList(),
    relevance: json['relevance'] as int,
    properties: Properties.fromJson(json['properties'] as Map<String, dynamic>),
    text: json['text'] as String,
    placeName: json['place_name'] as String,
    bbox: (json['bbox'] as List? ?? []).map((e) => e as double).toList(),
    center: (json['center'] as List? ?? []).map((e) => e as double).toList(),
    geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    context: (json['context'] as List? ?? []).map((e) => Context.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'place_type': placeType.map((e) => e.toString()).toList(),
    'relevance': relevance,
    'properties': properties.toJson(),
    'text': text,
    'place_name': placeName,
    'bbox': bbox.map((e) => e.toString()).toList(),
    'center': center.map((e) => e.toString()).toList(),
    'geometry': geometry.toJson(),
    'context': context.map((e) => e.toJson()).toList()
  };

  Place clone() => Place(
    id: id,
    type: type,
    placeType: placeType.toList(),
    relevance: relevance,
    properties: properties.clone(),
    text: text,
    placeName: placeName,
    bbox: bbox.toList(),
    center: center.toList(),
    geometry: geometry.clone(),
    context: context.map((e) => e.clone()).toList()
  );


  Place copyWith({
    String? id,
    String? type,
    List<String>? placeType,
    int? relevance,
    Properties? properties,
    String? text,
    String? placeName,
    List<double>? bbox,
    List<double>? center,
    Geometry? geometry,
    List<Context>? context
  }) => Place(
    id: id ?? this.id,
    type: type ?? this.type,
    placeType: placeType ?? this.placeType,
    relevance: relevance ?? this.relevance,
    properties: properties ?? this.properties,
    text: text ?? this.text,
    placeName: placeName ?? this.placeName,
    bbox: bbox ?? this.bbox,
    center: center ?? this.center,
    geometry: geometry ?? this.geometry,
    context: context ?? this.context,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Place && id == other.id && type == other.type && placeType == other.placeType && relevance == other.relevance && properties == other.properties && text == other.text && placeName == other.placeName && bbox == other.bbox && center == other.center && geometry == other.geometry && context == other.context;

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ placeType.hashCode ^ relevance.hashCode ^ properties.hashCode ^ text.hashCode ^ placeName.hashCode ^ bbox.hashCode ^ center.hashCode ^ geometry.hashCode ^ context.hashCode;
}

@immutable
class Properties {

  const Properties({
    required this.wikidata,
  });

  final String wikidata;

  factory Properties.fromJson(Map<String,dynamic> json) => Properties(
    wikidata: json['wikidata'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'wikidata': wikidata
  };

  Properties clone() => Properties(
    wikidata: wikidata
  );


  Properties copyWith({
    String? wikidata
  }) => Properties(
    wikidata: wikidata ?? this.wikidata,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Properties && wikidata == other.wikidata;

  @override
  int get hashCode => wikidata.hashCode;
}
