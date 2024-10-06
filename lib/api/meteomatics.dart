import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_weather/common/geolocator.dart';
import 'package:the_weather/config.dart';
import 'package:the_weather/models/precipitation_response.dart';

Future<PrecipitationResponse> getPrecipitationData( 
    {required String timestamp, required double lat, required double lon}) async {
  final response = await http.get(
      Uri.parse(
          'https://${Config.meteomaticsUser}:${Config.meteomaticsPassword}@api.meteomatics.com/${timestamp}P1D:PT1H/precip_24h:mm/${lat},${lon}/json'),
      );

  if (response.statusCode == 200) {
    return PrecipitationResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load precipitation data');
  }
}
