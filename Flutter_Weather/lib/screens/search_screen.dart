import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_weather/models/index.dart' as indexLib;
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';
import 'package:flutter_weather/screens/home_screen.dart';
import 'package:flutter_weather/services/logger.dart';
import 'package:flutter_weather/storage/json_repositories/autocomplete_repository.dart';
import 'package:flutter_weather/storage/json_repositories/weather_data_repository.dart';
import 'package:flutter_weather/storage/local_storage/place_local_storage.dart';
import 'package:flutter_weather/storage/repositories/places_repositories.dart';
import 'package:flutter_weather/widgets/custom_app_bar.dart';
import 'package:flutter_weather/widgets/dialogs/loading_dialog.dart';
import 'package:flutter_weather/widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Completer completer = Completer<List<indexLib.Place>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: Text("Add New Location", style: TextStyle(color: Colors.white),),
        ),
      body: SearchBox(getData: _getApiData, gotoHomeScreen: _gotoHomeScreen,)
    );
  }

  Future<indexLib.Autocomplete> _getMockAutocompleteData() async
  => await AutoCompleteRepository.getMockData();

  _gotoHomeScreen(indexLib.Place place) async {
    int timeOffset = await _getTimeOffset(place);
    place.timeOffset = timeOffset;
    PlacesRepositories.savePlace(place);
    Navigator.push(context,
        CustomPageTransition(type: PageTransitionType.leftToRight, child: HomeScreen(place: place)));
  }

  Future<int> _getTimeOffset(indexLib.Place place) async{
    List<double> coordinates = place.geometry.coordinates;
    final GetTimezone gt = GetTimezone();
    final HttpResult<Timezone> timezoneRes = await gt.call(coordinates.first, coordinates.last);
    if (timezoneRes.success == true)
      return timezoneRes.data.timezoneOffset;
    else return 0;
  }

  _savePlace(indexLib.Place place) async {
    try{
      await PlaceLocalStorage().writeItems([place]);
    }
    catch (err) {
      print(err);
    }
  }

  _readPlace() async{
    try{
      List<indexLib.Place> places = await PlaceLocalStorage().readItems();
      print(places);
    }
    catch (err){
      print(err);
    }
  }

  Future<indexLib.Autocomplete> _getApiData(String pattern) async{
    final GetAutocompleteData gad = GetAutocompleteData();
    final HttpResult<indexLib.Autocomplete> result = await gad.call(pattern);
    return result.data;
  }

}
