
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GifPage extends StatelessWidget {

  final Map gifdata;

  GifPage(this.gifdata);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(gifdata["title"]),backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(gifdata["images"]["fixed_height"]["url"]),


      )
    
    
    ,);
  }
}