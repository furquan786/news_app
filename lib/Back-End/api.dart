import 'dart:convert';

import 'package:news_app/Back-End/urls.dart';
import 'package:news_app/Models/requestdata.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<RequestData> getNews() async {
    try {
      final response = await http.get(Uri.parse(url2));
      print("response is = ${response.statusCode} ");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("data is ${data}");
        return RequestData.fromjson(data);
      } else {
        return RequestData();
      }
    } catch (e) {
      print("an exception occur in getNews api $e");
      return RequestData();
    }
  }
}
