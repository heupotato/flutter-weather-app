import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter_weather/widgets/labels/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarLabel extends StatelessWidget {
  final String? text;
  AppBarLabel({required this.text});
  @override
  Widget build(BuildContext context) {
    return Label(
      text: text ?? '',
      weight: FontWeight.w600,
      size: 18,
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
                SystemUiOverlayStyle(statusBarColor: Colors.red),
            centerTitle: true,
            title: title,
            backgroundColor: backgroundColor,
            elevation: 0,
            leading: leading,
            leadingWidth: leadingWidth,
            actions: actions,
            automaticallyImplyLeading: true);
}
