import 'package:flutter/material.dart';
import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter_weather/widgets/custom_app_bar.dart';
import 'package:flutter_weather/widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: Text("Add New Location", style: TextStyle(color: Colors.white),),
        ),
      body: Container(
        color: Colors.black54,
        child: SearchBox(onChanged: _onChanged)),
    );
  }

  _onChanged(String string) {}
}
