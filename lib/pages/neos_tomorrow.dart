import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neo/pages/neos_today.dart';

import 'package:neo/requisition/requisition.dart';
import 'package:neo/widgets/list_item.dart';

import '../entity/neo.dart';

class NeosTomorrowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NeosTomorrowPageState();
}

class _NeosTomorrowPageState extends State<NeosTomorrowPage>
    with AutomaticKeepAliveClientMixin<NeosTomorrowPage> {
  String dateTime = _setDate();
  List<Neo> neosContent = [];
  int index = 1;

  @override
  void initState() {
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
    if (response.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      showErrorMessage();
    } else {
      setState(() {
        ScaffoldMessenger.of(context).clearSnackBars();
        showSnackBar('NEOs encontrados!', 4, Colors.green);
        neosContent = response;
      });
    }
  }

  void showErrorMessage() {
    if (neosContent.isEmpty == true) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Nenhum NEO encontrado!'),
            content: SizedBox(
              height: 155,
              child: Column(
                children: const [
                  Text(
                      'Existem dois motivos para não encontrarmos nenhum NEO:\n'),
                  Text('1 - Nenhum NEO foi mapeado para o dia de hoje'),
                  Text(
                      '2 - A fonte de dados que utilizamos foi atualizada e não mostram mais os NEOS de hoje'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),
              ),
            ]),
      );
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
