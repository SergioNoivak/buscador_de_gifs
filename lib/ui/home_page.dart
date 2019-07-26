import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buscador_de_gifs/ui/gif_page.dart';
import 'package:share/share.dart';

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
          "https://api.giphy.com/v1/gifs/search?api_key=NJx8tjTo4S8KaDRLxGc8Eo6HWRtGWeEi&q=$search&limit=19&offset=$offset&rating=G&lang=en");

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
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.network(
              "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
          centerTitle: true),
      body: Padding(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise aqui",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()
                  ),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
           onSubmitted: (text){
              setState(() {

                this.search = text;
                this.offset=0;
              });



           }, ),
            Expanded(
              child: FutureBuilder(
                future: this._getGifs(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return createGifTable(context, snapshot);
                  }
                },
              ),
            )
          ],
        ),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }


  int getCount(List data){
    if(this.search==null)
      return (data.length);
    else return  data.length+1;
  }

  Widget createGifTable(BuildContext buildcontext, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10.0),
      itemCount: getCount(snapshot.data["data"]),
      itemBuilder: (context, index) {
        
        if(search==null || index<(snapshot.data['data'].length) )
        return GestureDetector(
          child: Image.network(
            snapshot.data["data"][index]["images"]["fixed_height"]["url"],
            height: 300.0,
            fit: BoxFit.cover,
          ),
          onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)  => GifPage(snapshot.data["data"][index]) ));
          },
          onLongPress: (){

                Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);


          },
        );

        else
          return Container(
              child: GestureDetector(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Icon(Icons.add,color:Colors.white,size:70),
                    Text("Carregar Mais",
                    style: TextStyle(color:Colors.white,fontSize: 22.0)
                    )


                  ],),
                
                  onTap: (){
                      setState(() {
                        this.offset+=19;

                      });


                  }
                
                ,),


          );
      },

    );
  }
}


