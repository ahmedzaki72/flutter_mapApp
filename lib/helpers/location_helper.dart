import 'dart:convert';

import 'package:http/http.dart' as http;
const GOOGLE_API_KEY = 'AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24KRuAYI';


class LocationHeper {
  static String generateLocationPreviewImage({double latitude , double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap &markers=color:red%7Clabel:A%$latitude,$longitude &key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lon) async {
     final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$GOOGLE_API_KEY';
     final response = await http.get(url);
     return json.decode(response.body)['result'][0]['formatted_address'];
  }
}