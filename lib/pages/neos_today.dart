import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neo/pages/neos_tomorrow.dart';

import 'package:neo/requisition/requisition.dart';
import 'package:neo/widgets/list_item.dart';

import '../entity/neo.dart';

class NeosTodayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NeosTodayPageState();
}

class _NeosTodayPageState extends State<NeosTodayPage>
    with AutomaticKeepAliveClientMixin<NeosTodayPage> {
  String dateTime = DateTime.now().toString().substring(0, 10);
  List<Neo> neosContent = [];
  int index = 0;

  @override
  void initState() {
    showInitialMessage();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

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
                      const Padding(
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
                          child: const Text('Me mostre os NEOs de hoje'),
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

  Future<void> loadNeosData() async {}

  void showInitialMessage() {
    Future.delayed(
      Duration.zero,
      () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Bem-vindo ao NEO'),
          content: const Text(
            'Este aplicativo tem como objetivo informar quais os NEOs (Objetos Próximos da Terra) no dia de hoje e no dia seguinte.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Entendi'),
            ),
          ],
        ),
      ),
    );
  }

  String setTextDateTime() {
    DateTime dateTime = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(dateTime);
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
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return NeosTomorrowPage();
        }),
      );
    }
  }
}
