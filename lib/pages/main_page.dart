import 'package:flutter/material.dart';

import 'package:neo/requisition/requisition.dart';
import 'package:neo/widgets/list_item.dart';

import '../entity/neo.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  String selectedDateTime = DateTime.now().toString().substring(0, 10);
  List<Neo> neosContent = [];

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Bem-vindo ao NEO'),
      content: const Text('Este aplicativo tem como objetivo informar quais os NEOs (Objetos Próximos da Terra) no dia de hoje.'),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text('Entendi'),),
      ],
    )));
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Near Earth Objects'),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 7),
                  child: ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000),
                      ).then((date) {
                        String stringDate = date.toString();
                        setState(() {
                          this.selectedDateTime = stringDate.substring(0, 10);
                        });
                        searchNeosByDate();
                        print(this.selectedDateTime);
                      });
                    },
                    child: const Text('Selecione uma data'),
                  ),
                ),
                Text('Data selecionada: ${this.selectedDateTime}'),
                Flexible(
                  child: showListView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> searchNeosByDate() async {
    Requisiton req = Requisiton();
    showSnackBar('Solicitando informações da NASA...', 30, Colors.lightBlue);
    List<Neo> response = await req.fetch(this.selectedDateTime!);
    setState(() {
      ScaffoldMessenger.of(context).clearSnackBars();
      showSnackBar('NEOs encontrados!', 4, Colors.green);
      this.neosContent = response;
    });
    showErrorSnackBar();
  }

  void showErrorSnackBar() {
    if (this.neosContent.isEmpty == true) {
      ScaffoldMessenger.of(context).clearSnackBars();
      showSnackBar('Nenhum NEO foi mapeado para esta data!', 5, Colors.red);
    }
  }


  void showSnackBar(String text, int duration, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${text}'),
        duration: Duration(seconds: duration),
        backgroundColor: backgroundColor,
      ),
    );
  }

  ListView showListView() {
    if (!this.neosContent.isEmpty) {
      return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          for (Neo neo in this.neosContent)
            ListItem(
              title: neo.returnName,
              absoluteMagnitudeH: neo.returnAbsoluteMagnitudeH,
              isPotentiallyHazardousAsteroid:
                  neo.returnIsPotentiallyHazardousAsteroid,
              isSentryObject: neo.returnIsSentryObject,
            ),
        ],
      );
    } else {
      return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
      );
    }
  }
}
