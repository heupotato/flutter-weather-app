import 'package:flutter_weather/environments/environment.dart';
import 'package:flutter_weather/mock_endpoints/auto_complete_endpoint.dart';
import 'package:flutter_weather/packages/mockserver/mockserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future _intState() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  //getIt.registerSingleton;
}

Future startMockServer() async {
  final List<EndPoint> endPoints = [AutoCompleteEndPoint()];

  final MockServer mockServer =
      MockServer(port: 8080, endPoints: endPoints, endPointDelay: 2000);
  await mockServer.start();
}

Future initStateAndSetupEnvironment(Environment environment) async {
  await _intState();
  getIt.registerSingleton<Environment>(environment);
}
