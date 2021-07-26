import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart' as indexLib;
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';
import 'package:flutter_weather/services/logger.dart';
import 'package:flutter_weather/storage/json_repositories/autocomplete_repository.dart';
import 'package:flutter_weather/storage/json_repositories/weather_data_repository.dart';
import 'package:flutter_weather/widgets/custom_app_bar.dart';
import 'package:flutter_weather/widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ValueNotifier <List<indexLib.Place>> _filteredPlaceList = ValueNotifier(<indexLib.Place>[]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: Text("Add New Location", style: TextStyle(color: Colors.white),),
        ),
      body: Column(
        children: [
          SearchBox(onChanged: _onChanged),
          FutureBuilder<indexLib.Autocomplete>(
              future: _getMockAutocompleteData(),
              builder: (context, snapshot){
                Widget child = Container();
                if (snapshot.hasData){
                  Logger.logInfo(
                      className: "SearchScreen",
                      methodName: "Build",
                      message: "Retrieve data successfully");
                  if (snapshot.data == null) return child;
                  //List<indexLib.Place> places = snapshot.data!.features;
                  child  = ValueListenableBuilder<List<indexLib.Place>>(
                      valueListenable: _filteredPlaceList,
                      builder: (context, places, _){
                        return Expanded(
                            child: ListView.builder(
                                itemCount: _filteredPlaceList.value.length,
                                itemBuilder: (context, index){
                                  print(_filteredPlaceList.value.length);
                                  final indexLib.Place place = _filteredPlaceList.value[index];
                                  return placeCard(place);
                                },
                            ));
                      });
                }
                else if (snapshot.hasError){
                  Logger.logError(
                      className: "SearchScreen",
                      methodName: "build",
                      message: snapshot.error.toString()
                  );
                }
                return child;
              }
          )
        ],
      )
    );
  }

  _onChanged(String value) async{
    indexLib.Autocomplete dataAutocomplete = await _getMockAutocompleteData();
   print(value);
    List<indexLib.Place> places = dataAutocomplete.features;
    _filteredPlaceList.value = places.where((place)
    => (place.placeName.toLowerCase().contains(value.toLowerCase()))).toList();
  }

  Future<indexLib.Autocomplete> _getMockAutocompleteData() async
  => await AutoCompleteRepository.getData();

  final TextStyle titleStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18
  );

  final TextStyle subtitleStyle = TextStyle(
      color: Colors.white,
      fontSize: 15
  );

  Card placeCard(indexLib.Place place){
    return Card(
        color: Colors.black,
        shadowColor: Colors.white,
        elevation: 2,
        child: ListTile(
          title: Text(place.text, style: titleStyle),
          subtitle: Text(place.placeName, style: subtitleStyle),
          onTap: _onTapCard,
        ));
  }

  _onTapCard() async{
    final GetWeatherDataCity gwc = GetWeatherDataCity();
    print("Retrieving data... wait");
    final HttpResult<Weather> result = await gwc.call();
    Weather weather = await result.data;
    print(weather.init);
  }
}
