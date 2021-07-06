import 'package:flutter/material.dart';

void main() {}

class FakeApp extends StatelessWidget {
  final Widget body;

  const FakeApp(this.body);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }
}
