import 'package:flutter/foundation.dart';
import 'place.dart';

@immutable
class Autocomplete {
  const Autocomplete({
    required this.status,
    required this.predictions,
  });

  final String status;
  final List<Place> predictions;

  static Autocomplete fromJson(Map<String, dynamic> json) => Autocomplete(
      status: json['status'] as String,
      predictions: (json['predictions'] as List? ?? [])
          .map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList());

  Map<String, dynamic> toJson() => {
        'status': status,
        'predictions': predictions.map((e) => e.toJson()).toList()
      };

  Autocomplete clone() => Autocomplete(
      status: status, predictions: predictions.map((e) => e.clone()).toList());

  Autocomplete copyWith({String? status, List<Place>? predictions}) =>
      Autocomplete(
        status: status ?? this.status,
        predictions: predictions ?? this.predictions,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Autocomplete &&
          status == other.status &&
          predictions == other.predictions;

  @override
  int get hashCode => status.hashCode ^ predictions.hashCode;
}
