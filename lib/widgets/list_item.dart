import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final double absoluteMagnitudeH;
  final bool isPotentiallyHazardousAsteroid;
  final bool isSentryObject;

  const ListItem({
    super.key,
    required this.title,
    required this.absoluteMagnitudeH,
    required this.isPotentiallyHazardousAsteroid,
    required this.isSentryObject,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: const Color.fromRGBO(215, 215, 215, 1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                this.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Text(
              'Magnitude absoluta: ${this.absoluteMagnitudeH.toString()}',
            ),
            Text(
              this.isPotentiallyHazardousAsteroid == true
                  ? 'Asteroide potencialmente perigoso: Sim'
                  : 'Asteroide potencialmente perigoso: Não',
            ),
            Text(
                this.isSentryObject == true ? 'Objeto sentinela: Sim' : 'Objeto sentinela: Não',
            ),
          ],
        ),
      ),
    );
  }
}
