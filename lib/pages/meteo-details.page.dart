import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:voyage/menu/drawer.widget.dart';
import '../widget/homePageItemwi.widget.dart';

class MeteoDetailsPage extends StatefulWidget{
  String ville ="";
  MeteoDetailsPage(this.ville);



  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;
  @override
  void initState(){
    super.initState();
    getMeteoData(widget.ville);


  }

  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(

         title: Text("Page Meteo Detail ${widget.ville}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 , color: Colors.white ,
         ),
         ),
backgroundColor: Colors.purple,
       ),
        body:
        (meteoData==null)?
            Center(child: CircularProgressIndicator(
              color: Colors.white,
            )):
        ListView.builder(
          itemCount: (meteoData==null)? 0:meteoData['list'].length,
            itemBuilder: (context,index){
            return Card(
                child: Container(
                decoration: BoxDecoration(
                gradient: LinearGradient(
                colors: [Colors.purple, Colors.lightBlue.shade50],
            ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row( children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "images/icons/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"
                      ),
                    ),
                    Column(children: [
                      Text("${new DateFormat('E-dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt']*1000*1000))}"
                        ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 , color: Colors.white,)
                      ),
                      //${meteoData['List'][index]['dt']}
                      Text("${new DateFormat('HH:mm:ss').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt']*1000*1000))} |"
                        "${meteoData['list'][index]['weather'][0]['main'].toString()}"
                        ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 , color: Colors.white,
                      ),
                      ),
                    ],)

                  ],),
                  Text("${(meteoData['list'][index]['main']['temp']-273.15).round()}°C"
                    ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 , color: Colors.black,
              ),)
                ],
              ),
                ),
            );


            },

        ),
    );
    backgroundColor: Colors.blueAccent;
  }


  Future<void> getMeteoData(String ville) async {
  String url="https://api.openweathermap.org/data/2.5/forecast?q=$ville&appid=c109c07bc4df77a88c923e6407aef864";

  await http.get(Uri.parse(url)).then((resp) {
    setState(() {
      this.meteoData = json.decode(resp.body);

    });
     print(this.meteoData);
  });
    //.catchError(err){
   // print(err);
   // });
  }
}