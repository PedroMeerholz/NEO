import 'package:flutter/material.dart';
import 'package:neo/pages/neos_today.dart';
import 'package:neo/pages/neos_tomorrow.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Near Earth Objects',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              centerTitle: true,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.rocket_launch),
                    text: 'NEOs de Hoje',
                  ),
                  Tab(
                    icon: Icon(Icons.rocket_launch),
                    text: 'NEOs de Amanhã',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [NeosTodayPage(), NeosTomorrowPage()],
            ),
          ),
        ),
      ),
    );
  }
}
