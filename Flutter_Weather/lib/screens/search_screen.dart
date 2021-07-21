import 'package:flutter/material.dart';
import 'package:flutter_weather/widgets/custom_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: Text("Add New City", style: TextStyle(color: Colors.white),),
        ),
      body: Container(),
    );
  }
}
