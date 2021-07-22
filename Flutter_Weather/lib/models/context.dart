import 'package:flutter/foundation.dart';


@immutable
class Context {

  const Context({
    required this.id,
    required this.wikidata,
    required this.text,
  });

  final String id;
  final String wikidata;
  final String text;

  factory Context.fromJson(Map<String,dynamic> json) => Context(
    id: json['id'] as String,
    wikidata: json['wikidata'] as String,
    text: json['text'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'wikidata': wikidata,
    'text': text
  };

  Context clone() => Context(
    id: id,
    wikidata: wikidata,
    text: text
  );


  Context copyWith({
    String? id,
    String? wikidata,
    String? text
  }) => Context(
    id: id ?? this.id,
    wikidata: wikidata ?? this.wikidata,
    text: text ?? this.text,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Context && id == other.id && wikidata == other.wikidata && text == other.text;

  @override
  int get hashCode => id.hashCode ^ wikidata.hashCode ^ text.hashCode;
}
