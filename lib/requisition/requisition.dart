import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:neo/entity/neo.dart';

class Requisiton {
  final String _baseUrl = 'api.nasa.gov';
  final String _unencodedPath = '/neo/rest/v1/feed';
  final Map<String, String> queryParameters = {
    'api_key': 'kZTbCFbznzUisBTg0d8d1Hn4taz7AhA4A0V5d7qs'
  };

  Future<List<Neo>> fetch(String? dateTime) async {
    Uri url = Uri.http(_baseUrl, _unencodedPath, queryParameters);

    var response = await http.get(url);
    Map json = convert.jsonDecode(response.body);
    Map content = json['near_earth_objects'];
    Iterable iterableDates = content.keys; // dates

    List<Neo> neos = [];
    if (iterableDates.contains(dateTime)) {
      var dateContent = content[dateTime];
      for (int i = 0; i < dateContent.length; i++) {
        Map neoMap = dateContent[i];
        Neo neo = Neo(
          neoMap['name'],
          neoMap['absolute_magnitude_h'],
          neoMap['estimated_diameter']['kilometers']['estimated_diameter_min'],
          neoMap['estimated_diameter']['kilometers']['estimated_diameter_max'],
          neoMap['close_approach_data'][0]['close_approach_date_full'],
          neoMap['close_approach_data'][0]['relative_velocity']
              ['kilometers_per_second'],
          neoMap['close_approach_data'][0]['miss_distance']['kilometers'],
          neoMap['is_potentially_hazardous_asteroid'],
          neoMap['is_sentry_object'],
        );
        neos.add(neo);
      }
      return neos;
    } else {
      print('Não achei a data');
      return neos;
    }

    //print(content['2023-01-11']); // Retorna um mapa com tos os neos da data
    //print(content['2023-01-11'][0]); // Retorna um mapa
    //print(content['2023-01-11'][0]['name']);
  }
}
