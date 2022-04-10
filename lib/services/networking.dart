import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHandler{
  final String urls;

  NetworkHandler(this.urls);

  Future getData() async{
    var url =  Uri.parse(urls);
    http.Response response = await http.get(url);
    if(response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    else{
      return response.statusCode;
    }
  }
}

