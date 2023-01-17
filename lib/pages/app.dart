import 'package:flutter/material.dart';
import 'package:neo/pages/neos_today.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NeosTodayPage(),
    );
  }
}
