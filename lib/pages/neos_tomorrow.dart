import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neo/pages/neos_today.dart';

import 'package:neo/requisition/requisition.dart';
import 'package:neo/widgets/list_item.dart';

import '../entity/neo.dart';

class NeosTomorrowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NeosTomorrowPageState();
}

class NeosTomorrowPageState extends State<NeosTomorrowPage> {
  String dateTime = _setDate();
  List<Neo> neosContent = [];
  int index = 1;

  @override
  void initState() {
    super.initState();
    searchNeosByDate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      ),
                      Text(
                        setTextDateTime(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 7,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            searchNeosByDate();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.blueAccent,
                            ),
                          ),
                          child: const Text('Me mostre os NEOs de amanhã'),
                        ),
                      ),
                      showNeos(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _setDate() {
    DateTime now = DateTime.now();
    DateTime tomorrowDateTime = now.add(const Duration(days: 1));
    String date = tomorrowDateTime.toString().substring(0, 10);
    return date;
  }

  String setTextDateTime() {
    DateTime now = DateTime.now();
    DateTime tomorrowDateTime = now.add(const Duration(days: 1));
    return DateFormat('dd/MM/yyyy').format(tomorrowDateTime);
  }

  Future<void> searchNeosByDate() async {
    Requisiton req = Requisiton();
    showSnackBar('Solicitando dados...', 60, Colors.blueAccent);
    List<Neo> response = await req.fetch(dateTime);
    setState(() {
      ScaffoldMessenger.of(context).clearSnackBars();
      showSnackBar('NEOs encontrados!', 4, Colors.green);
      neosContent = response;
    });
    showErrorSnackBar();
  }

  void showErrorSnackBar() {
    if (neosContent.isEmpty == true) {
      ScaffoldMessenger.of(context).clearSnackBars();
      showSnackBar('Nenhum NEO foi mapeado para esta data!', 5, Colors.red);
    }
  }

  void showSnackBar(String text, int duration, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: duration),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Column showNeos() {
    if (neosContent.isNotEmpty) {
      return Column(
        children: [
          for (Neo neo in neosContent)
            ListItem(
              name: neo.returnName,
              absoluteMagnitudeH: neo.returnAbsoluteMagnitudeH,
              minEstimatedDiameter: neo.returnMinEstimatedDiameter,
              maxEstimatedDiameter: neo.returnMaxEstimatedDiameter,
              closeApproachDate: neo.returnCloseApproachDate,
              kilometersPerSecond: neo.returnKilometersPerSecond,
              missDistance: neo.returnMissDistance,
              isPotentiallyHazardousAsteroid:
                  neo.returnIsPotentiallyHazardousAsteroid,
            ),
        ],
      );
    } else {
      return Column();
    }
  }

  void alterPage(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return NeosTodayPage();
        }),
      );
    }
  }
}
