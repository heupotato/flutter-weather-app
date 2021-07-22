import 'package:flutter/foundation.dart';
import 'place.dart';

@immutable
class AutocompleteCity {

  const AutocompleteCity({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  final String type;
  final List<String> query;
  final List<Place> features;
  final String attribution;

  factory AutocompleteCity.fromJson(Map<String,dynamic> json) => AutocompleteCity(
    type: json['type'] as String,
    query: (json['query'] as List? ?? []).map((e) => e as String).toList(),
    features: (json['features'] as List? ?? []).map((e) => Place.fromJson(e as Map<String, dynamic>)).toList(),
    attribution: json['attribution'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'type': type,
    'query': query.map((e) => e.toString()).toList(),
    'features': features.map((e) => e.toJson()).toList(),
    'attribution': attribution
  };

  AutocompleteCity clone() => AutocompleteCity(
    type: type,
    query: query.toList(),
    features: features.map((e) => e.clone()).toList(),
    attribution: attribution
  );


  AutocompleteCity copyWith({
    String? type,
    List<String>? query,
    List<Place>? features,
    String? attribution
  }) => AutocompleteCity(
    type: type ?? this.type,
    query: query ?? this.query,
    features: features ?? this.features,
    attribution: attribution ?? this.attribution,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is AutocompleteCity && type == other.type && query == other.query && features == other.features && attribution == other.attribution;

  @override
  int get hashCode => type.hashCode ^ query.hashCode ^ features.hashCode ^ attribution.hashCode;
}
