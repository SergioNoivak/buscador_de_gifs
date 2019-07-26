import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buscador_de_gifs/ui/home_page.dart';
import 'package:buscador_de_gifs/ui/gif_page.dart';


void main() {
  runApp(MaterialApp(home: Home(),  theme:ThemeData(hintColor: Colors.white)
));
}
