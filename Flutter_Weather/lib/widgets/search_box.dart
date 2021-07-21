import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final Function(String) onChanged;
  SearchBox({Key? key, required this.onChanged}) : super(key: key);

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
        child: TextFormField(
          decoration: _searchFieldDecoration("Type a city name or an area code"),
          onChanged: onChanged,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: _searchTextController,
        )
    );
  }
}