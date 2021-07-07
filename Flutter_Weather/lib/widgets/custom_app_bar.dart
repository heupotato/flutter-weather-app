import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter_weather/services/date_formatter.dart';
import 'package:flutter_weather/widgets/labels/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarLabel extends StatelessWidget {
  final String city;
  AppBarLabel({required this.city});
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children: [
              TextSpan(
                  text:"Da Nang City",
                  style: TextStyle(fontSize: 25)
              ),
              TextSpan(text: "\n${DateFormatter.dateTime(DateTime.now())}")
            ]
        )
    );
  }
}

class CustomAppBar extends AppBar {
  CustomAppBar(
      {Widget? title,
      Widget? leading,
      double leadingWidth = 60,
      List<Widget>? actions,
      Color backgroundColor = Palette.primary,
      bool showPingStatusIcon = false,
      bool showPendingOrdersIcon = false})
      : super(
            backwardsCompatibility: false,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Palette.primary),
            centerTitle: true,
            title: title,
            backgroundColor: Palette.transparent,
            elevation: 0,
            leading: leading,
            leadingWidth: leadingWidth,
            actions: actions,
            automaticallyImplyLeading: true);
}
