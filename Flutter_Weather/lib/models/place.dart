import 'package:flutter/foundation.dart';
import 'matched_substring.dart';
import 'term.dart';

@immutable
class Place {
  const Place({
    required this.description,
    required this.distanceMeters,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.terms,
    required this.types,
  });

  final String description;
  final int distanceMeters;
  final List<MatchedSubstring> matchedSubstrings;
  final String placeId;
  final String reference;
  final List<Term> terms;
  final List<String> types;

  static Place fromJson(Map<String, dynamic> json) => Place(
      description: json['description'] as String,
      distanceMeters: json['distance_meters'] as int,
      matchedSubstrings: (json['matched_substrings'] as List? ?? [])
          .map((e) => MatchedSubstring.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeId: json['place_id'] as String,
      reference: json['reference'] as String,
      terms: (json['terms'] as List? ?? [])
          .map((e) => Term.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List? ?? []).map((e) => e as String).toList());

  static List<Place> fromJsonList(List<dynamic> json) =>
      json.map((e) => Place.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'description': description,
        'distance_meters': distanceMeters,
        'matched_substrings': matchedSubstrings.map((e) => e.toJson()).toList(),
        'place_id': placeId,
        'reference': reference,
        'terms': terms.map((e) => e.toJson()).toList(),
        'types': types.map((e) => e.toString()).toList()
      };

  Place clone() => Place(
      description: description,
      distanceMeters: distanceMeters,
      matchedSubstrings: matchedSubstrings.map((e) => e.clone()).toList(),
      placeId: placeId,
      reference: reference,
      terms: terms.map((e) => e.clone()).toList(),
      types: types.toList());

  Place copyWith(
          {String? description,
          int? distanceMeters,
          List<MatchedSubstring>? matchedSubstrings,
          String? placeId,
          String? reference,
          List<Term>? terms,
          List<String>? types}) =>
      Place(
        description: description ?? this.description,
        distanceMeters: distanceMeters ?? this.distanceMeters,
        matchedSubstrings: matchedSubstrings ?? this.matchedSubstrings,
        placeId: placeId ?? this.placeId,
        reference: reference ?? this.reference,
        terms: terms ?? this.terms,
        types: types ?? this.types,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Place &&
          description == other.description &&
          distanceMeters == other.distanceMeters &&
          matchedSubstrings == other.matchedSubstrings &&
          placeId == other.placeId &&
          reference == other.reference &&
          terms == other.terms &&
          types == other.types;

  @override
  int get hashCode =>
      description.hashCode ^
      distanceMeters.hashCode ^
      matchedSubstrings.hashCode ^
      placeId.hashCode ^
      reference.hashCode ^
      terms.hashCode ^
      types.hashCode;
}
