import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/widgets/place_card.dart';

class SearchBox extends StatelessWidget {
  Function(String) getData;
  Function(Place) gotoHomeScreen;
  SearchBox({Key? key, required this.getData, required this.gotoHomeScreen}) : super(key: key);

  final TextEditingController _searchTextController = TextEditingController();

  final OutlineInputBorder outlineTextField = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.grey,
    ),
  );

  final OutlineInputBorder focusedTextField = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
    borderSide: BorderSide(color: Colors.blue),
  );

  InputDecoration _searchFieldDecoration(String label){
    return InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.search, color: Colors.white,size: 30),
        suffixIcon: IconButton(
          icon: Icon(Icons.cancel, color: Colors.white, size: 30),
          onPressed: _searchTextController.clear,
        ),
        enabledBorder: outlineTextField,
        focusedBorder: focusedTextField,
        fillColor: Colors.black,
        filled: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
              ),
              decoration: _searchFieldDecoration("Type a city name"),
              controller: _searchTextController,
              cursorColor: Colors.white
          ),
          suggestionsCallback: (pattern) async {
            final data = await getData(pattern);
            return data.features;
          },
          itemBuilder: (context, suggestion){
            return PlaceCard(place: suggestion as Place);
          },
          onSuggestionSelected: (suggestion) => gotoHomeScreen(suggestion as Place),
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            color: Colors.black
          ),
        )
    );
  }
}