import 'dart:io';

import 'package:flutter_weather/resources/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './test_environment.dart';

Future initStateAndSetupEnvironmentTest() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  final directory = await Directory.systemTemp.createTemp();

  const MethodChannel('plugins.flutter.io/path_provider')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getApplicationDocumentsDirectory') {
      return directory.path;
    }
    return null;
  });

  const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    return null;
  });

  const MethodChannel('uk.spiralarm.flutter/devicelocale')
      .setMockMethodCallHandler((methodCall) async =>
          methodCall.method == 'preferredLanguages' ? ['en'] : null);

  await startMockServer();

  await initStateAndSetupEnvironment(TestEnvironment());
}

Future<dynamic> wait({required int seconds}) =>
    Future.delayed(Duration(seconds: seconds), () {});
