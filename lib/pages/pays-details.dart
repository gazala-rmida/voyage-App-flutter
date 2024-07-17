import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaysDetailsPage extends StatefulWidget {
  final String pays;

  PaysDetailsPage(this.pays);

  @override
  State<PaysDetailsPage> createState() => _PaysDetailsPageState();
}

class _PaysDetailsPageState extends State<PaysDetailsPage> {
  var paysData;

  @override
  void initState() {
    super.initState();
    getPaysData(widget.pays);
  }

  void getPaysData(String pays) {
    String url = "https://restcountries.com/v2/name/$pays";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.paysData = json.decode(resp.body);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Pays Details ${widget.pays}')),
      body: paysData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Image.network("${paysData[0]['flags']['png']}"),
          Text("${paysData[0]['name']}"),
          SizedBox(height: 10),
          Text("${paysData[0]['nativeName']}"),
          Text(
            "Administration",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text("Capitale : "),
              Text("${paysData[0]['capital']}"),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text("Language(s) : "),
              Text(
                  "${paysData[0]['languages'][0]['name']} , ${paysData[0]['languages'][0]['nativeName']}"),
            ],
          ),
        ],
      ),
    );
  }
}
