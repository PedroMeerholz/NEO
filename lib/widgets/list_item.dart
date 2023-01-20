import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.name,
    required this.absoluteMagnitudeH,
    required this.minEstimatedDiameter,
    required this.maxEstimatedDiameter,
    required this.closeApproachDate,
    required this.kilometersPerSecond,
    required this.missDistance,
    required this.isPotentiallyHazardousAsteroid,
  });

  final String name;
  final double absoluteMagnitudeH;
  final double minEstimatedDiameter;
  final double maxEstimatedDiameter;
  final String closeApproachDate;
  final String kilometersPerSecond;
  final String missDistance;
  final bool isPotentiallyHazardousAsteroid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showNeoInfo(context);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNeoInfo(BuildContext context) {
    const double sizedBoxHeight = 20;
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text(name),
          content: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 290,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildFormatedRichText(
                    context,
                    'Magnitude absoluta:\n',
                    TextSpan(
                      text: absoluteMagnitudeH.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: sizedBoxHeight,
                  ),
                  buildFormatedRichText(
                    context,
                    'Diâmetro aproximado:\n',
                    TextSpan(
                      text:
                          '${doubleDecimalRound(minEstimatedDiameter)} ~ ${doubleDecimalRound(maxEstimatedDiameter)} Km',
                    ),
                  ),
                  const SizedBox(
                    height: sizedBoxHeight,
                  ),
                  buildFormatedRichText(
                    context,
                    'Maior aproximação em:\n',
                    TextSpan(text: closeApproachDate),
                  ),
                  const SizedBox(
                    height: sizedBoxHeight,
                  ),
                  buildFormatedRichText(
                    context,
                    'Distância mais próxima da Terra:\n',
                    TextSpan(
                      text: stringDecimalRound(missDistance),
                    ),
                  ),
                  const SizedBox(
                    height: sizedBoxHeight,
                  ),
                  buildFormatedRichText(
                    context,
                    'Velocidade do Asteróide: \n',
                    TextSpan(text: '$kilometersPerSecond (Km/s)'),
                  ),
                  const SizedBox(
                    height: sizedBoxHeight,
                  ),
                  buildFormatedRichText(
                    context,
                    'Apresenta perigo: ',
                    TextSpan(
                        text: isPotentiallyHazardousAsteroid == true
                            ? 'Sim'
                            : 'Não'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  String stringDecimalRound(String string) {
    return double.parse(string).toStringAsFixed(4);
  }

  String doubleDecimalRound(double number) {
    return number.toStringAsFixed(4);
  }

  RichText buildFormatedRichText(
      BuildContext context, String principalText, TextSpan secondaryText) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: principalText,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          secondaryText,
        ],
      ),
    );
  }
}
