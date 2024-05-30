import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_application_2/weather/weather.dart';


// class HttpHelper {
//   String domainName = "api.openweathermap.org";
//   String path = "data/2.5/weather";
//   String apiKey = "b2ffdc51f9cf000f1d73c1d3d33ccfd9";
//   String lat = "31.573152";
//   String lon = "74.3078585";

//   Future<Weather> getWeatherOfGCU() async {
//     Map<String, dynamic> parameters = {"lat": lat, "lon": lon, "appid": apiKey};

//     Uri apiURL = Uri.https(domainName, path, parameters);

//     http.Response response = await http.get(apiURL);

//     String responseString = response.body;
//     Map<String, dynamic> data = json.decode(responseString);

//     Weather obj = Weather.fromJson(data);

//     return obj;
//   }
// }




class HttpHelper {
  // https://api.openweathermap.org/data/2.5/weather?lat=31.573152&lon=74.3078585&appid=b2ffdc51f9cf000f1d73c1d3d33ccfd9

  final String domainName = "api.openweathermap.org";
  final String path = "data/2.5/weather";
  final apiKey = "be582b7aaf0b840f204e42ea6343951a";
  Future<Weather> getWeatherofGCU(String lat, String lon) async {
    Map<String, dynamic> parameters = {"lat": lat, "lon": lon, "appid": apiKey};
    Uri url = Uri.https(domainName, path, parameters);
    http.Response response = await http.get(url);
    var data = json.decode(response.body);

    Weather obj = Weather.fromJson(data);

    return obj;
  }
}
