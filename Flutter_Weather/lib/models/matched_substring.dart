import 'package:flutter/foundation.dart';

@immutable
class MatchedSubstring {
  const MatchedSubstring({
    required this.length,
    required this.offset,
  });

  final int length;
  final int offset;

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      MatchedSubstring(
          length: json['length'] as int, offset: json['offset'] as int);

  Map<String, dynamic> toJson() => {'length': length, 'offset': offset};

  MatchedSubstring clone() => MatchedSubstring(length: length, offset: offset);

  MatchedSubstring copyWith({int? length, int? offset}) => MatchedSubstring(
        length: length ?? this.length,
        offset: offset ?? this.offset,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchedSubstring &&
          length == other.length &&
          offset == other.offset;

  @override
  int get hashCode => length.hashCode ^ offset.hashCode;
}
