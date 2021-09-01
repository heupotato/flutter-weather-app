import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/screens/home_screen.dart';
import 'package:flutter_weather/services/logger.dart';
import 'package:flutter_weather/storage/repositories/places_repositories.dart';

class DrawerControlWidget extends StatefulWidget {
  const DrawerControlWidget({Key? key}) : super(key: key);

  @override
  _DrawerControlWidgetState createState() => _DrawerControlWidgetState();
}


class _DrawerControlWidgetState extends State<DrawerControlWidget> {

  static const TextStyle headerTextStyle = TextStyle(color: Colors.white, fontSize: 25);
  static const TextStyle listTileTextStyle = TextStyle(color: Colors.white, fontSize: 20);
  static const TextStyle titleStyle = TextStyle(color: Colors.white, fontSize: 18);

  @override
  void initState(){
    Logger.logInfo(
        className: "DrawerControlWidget",
        methodName: "initState",
        message: "Open Control Drawer");
    super.initState();
  }

  List<ListTile> cityTiles(){
    List<Place> citylist = PlacesRepositories.getAllPlaces();
    return citylist.map((city) =>
        ListTile(
          tileColor: Colors.black38,
          title: Text(city.text, style: listTileTextStyle),
          leading: Icon(Icons.location_on, color: Colors.white,),
          trailing: IconButton(
            icon: Icon(Icons.delete_outline_outlined, color: Colors.white),
            onPressed: (){
              Navigator.of(context).pop();
              int index = citylist.indexOf(city);
              PlacesRepositories.removePlace(index);
            },
          ),
          onTap: () => cityWeather(city),
    )).toList();
  }

  cityWeather(Place place){
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(place: place)));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(height: 150, child: DrawerHeader(
              child: ListTile(
                title: Text("Sign In", style: headerTextStyle),
                leading: ClipOval(
                  child: Image.asset(Assets.avatarPlaceholder, color: Colors.white,),
                )
              ))),
          ListTile(
            tileColor: Colors.black38,
            title: Text("Edit Location", style: listTileTextStyle),
            leading: Icon(Icons.add_location, color: Colors.yellow,),
          ),
          ListTile(
            tileColor: Colors.black38,
            title: Text("Current Location", style: listTileTextStyle),
            leading: Icon(Icons.location_searching, color: Colors.white,),
          ),
          Padding(padding: EdgeInsets.all(10), child: Text("LOCATIONS", style: titleStyle)),
          ...cityTiles(),
          // Padding(padding: EdgeInsets.all(10), child: Text("APPS", style: titleStyle)),
          // ListTile(
          //   tileColor: Colors.black38,
          //   title: Text("Gmail", style: listTileTextStyle),
          //   leading: ClipOval(
          //     child: Image.asset(Assets.gmailLogo),
          //   )
          // ),
          Padding(padding: EdgeInsets.all(10), child: Text("TOOLS", style: titleStyle)),
          ListTile(
              tileColor: Colors.black38,
              title: Text("Settings", style: listTileTextStyle),
              leading: Icon(Icons.settings, color: Colors.cyan)
          )
        ],
      ),
    );
  }
}
