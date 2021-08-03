import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  PlaceCard({Key? key, required this.place}) : super(key: key);

  final TextStyle titleStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18
  );

  final TextStyle subtitleStyle = TextStyle(
      color: Colors.white,
      fontSize: 15
  );

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.black,
        shadowColor: Colors.white,
        elevation: 0.5,
        child: ListTile(
          title: Text(place.text, style: titleStyle),
          subtitle: Text(place.placeName, style: subtitleStyle),
        ));
  }
}
