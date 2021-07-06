import 'package:application_icon/application_icon.dart';
import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter_weather/widgets/labels/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingDialog extends StatelessWidget {
  LoadingDialog(this.context, this.title, this.subtitle);
  final BuildContext context;
  final String title;
  final String? subtitle;

  static LoadingDialog loading(BuildContext context,
      {required String title, String? subtitle}) {
    final dialog = LoadingDialog(context, title, subtitle);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => dialog,
    );

    return dialog;
  }

  void close() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
            titlePadding: EdgeInsets.only(left: 16, right: 16, top: 16),
            contentPadding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: Row(children: [
              Container(width: 30, height: 30, child: AppIconImage()),
              SizedBox(width: 10),
              Expanded(
                  child: Label(
                      text: title,
                      align: TextAlign.left,
                      size: 16,
                      color: Palette.primary))
            ]),
            content: Row(children: [
              SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator()),
              SizedBox(width: 16),
              if (subtitle != null)
                Expanded(
                    child: Label(
                  color: Palette.primary,
                  text: subtitle!,
                  maxLines: 2,
                ))
            ])));
  }
}
