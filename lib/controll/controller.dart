import 'dart:convert';

import 'package:crud/model/useremodels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Screencontroller with ChangeNotifier {
  Publicapiresponse? responsedata;
  bool isloading = false;
  fetchdata({String? searchquery = "trending"}) async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$searchquery&apiKey=c5e2f5e2b2c04bdfa3105fbc6e239c89");
    var response = await http.get(url);
    var decodedata = (jsonDecode(response.body));

    print(response.statusCode);

    responsedata = Publicapiresponse.fromJson(decodedata);

    notifyListeners();
  }
}
