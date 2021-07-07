import 'package:flutter/material.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/services/logger.dart';

class DrawerControlWidget extends StatefulWidget {
  const DrawerControlWidget({Key? key}) : super(key: key);

  @override
  _DrawerControlWidgetState createState() => _DrawerControlWidgetState();
}


class _DrawerControlWidgetState extends State<DrawerControlWidget> {

  static const TextStyle headerTextStyle = TextStyle(color: Colors.white, fontSize: 25);
  static const TextStyle listTileTextStyle = TextStyle(color: Colors.white, fontSize: 20);
  static const TextStyle titleStyle = TextStyle(color: Colors.white, fontSize: 18);

  List<String> cityList = ["Da Nang", "Paris", "New York"];

  @override
  void initState(){
    Logger.logInfo(
        className: "DrawerControlWidget",
        methodName: "initState",
        message: "Open Control Drawer");
    super.initState();
  }

  List<ListTile> cityTiles(){
    return cityList.map((city) =>
        ListTile(
          tileColor: Colors.black38,
          title: Text(city, style: listTileTextStyle),
          leading: Icon(Icons.location_on, color: Colors.white,),
    )).toList();
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
          ...cityTiles(),
          Padding(padding: EdgeInsets.all(10), child: Text("APPS", style: titleStyle)),
          ListTile(
            tileColor: Colors.black38,
            title: Text("Gmail", style: listTileTextStyle),
            leading: ClipOval(
              child: Image.asset(Assets.gmailLogo),
            )
          ),
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
