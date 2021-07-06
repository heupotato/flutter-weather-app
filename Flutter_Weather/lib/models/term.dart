import 'package:flutter/foundation.dart';

@immutable
class Term {
  const Term({
    required this.offset,
    required this.value,
  });

  final int offset;
  final String value;

  static Term fromJson(Map<String, dynamic> json) =>
      Term(offset: json['offset'] as int, value: json['value'] as String);

  Map<String, dynamic> toJson() => {'offset': offset, 'value': value};

  Term clone() => Term(offset: offset, value: value);

  Term copyWith({int? offset, String? value}) => Term(
        offset: offset ?? this.offset,
        value: value ?? this.value,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Term && offset == other.offset && value == other.value;

  @override
  int get hashCode => offset.hashCode ^ value.hashCode;
}
