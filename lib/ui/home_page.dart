import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String search;
  int offset = 0;
  Future<Map> _getGifs() async {
    http.Response response;
    if (search == null)
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=NJx8tjTo4S8KaDRLxGc8Eo6HWRtGWeEi&limit=20&rating=G");
    else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=NJx8tjTo4S8KaDRLxGc8Eo6HWRtGWeEi&q=$search&limit=25&offset=$offset&rating=G&lang=en");

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((data) {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
            title: Image.network("https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
            centerTitle: true),
    );
  }
}
