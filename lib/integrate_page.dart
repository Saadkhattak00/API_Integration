import 'dart:convert';

import 'package:api_integration/newsinfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class integratePage extends StatefulWidget {
  static String id = "integratePage";
  @override
  _integratePageState createState() => _integratePageState();
}

class _integratePageState extends State<integratePage> {
  Image image;
  var _Data;
  Future<Welcome> getdata() async {
    var newsmodel;
    try {
      http.Response Respones = await http.get(
          "http://api.mediastack.com/v1/news?access_key=9fe735df278a55f0338426cf31c84e8c&languages=en");
      if (Respones.statusCode == 200) {
        return welcomeFromJson(Respones.body);
      }
    } catch (Exception) {
      print('error');
    }
  }

  @override
  void initState() {
    _Data = getdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('API Data'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<Welcome>(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.data.length);

                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.data[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: data.image == null
                              ? Icon(Icons.photo)
                              : Image.network(
                                  data.image,
                                  fit: BoxFit.cover,
                                ),
                          title: Text(
                            data.title,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            data.description,
                            maxLines: 3,
                          ),
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    ));
  }
}
