import 'package:flutter/material.dart';

import 'meteo-details.page.dart';
import 'package:voyage/config/global.params.dart';
import 'package:voyage/menu/drawer.widget.dart';
import '../widget/homePageItemwi.widget.dart';
class Meteopage extends StatelessWidget{
  TextEditingController txt_ville =  new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(


          centerTitle: true,

          title: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0,end: 1),
            duration: Duration(seconds: 2),
            builder: (context,double_val, chil){
              return Opacity(
                opacity: double_val,
                child: Text('Page Météo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,


                  ),
                ),
              );
            },
          ),

          backgroundColor: Colors.purple,

        ),

      body: Column(
        children: [


          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_ville,
              decoration: InputDecoration(
                prefixIcon:Icon(Icons.location_city),
              hintText:"Ville",
              border:OutlineInputBorder(borderSide:
              BorderSide(width: 1),
              borderRadius: BorderRadius.circular(10)
              ),
            ),
            ),
          ),
          Container(

            padding: EdgeInsets.all(10),

            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple,
                minimumSize: const Size.fromHeight(50)
              ),
              onPressed: (){
                _onGetMeteoDetails(context);
              },
              child: Text('Chercher',style: TextStyle(color:Colors.white,fontSize: 22))),
          ), ],
    )

    );

    // TODO: implement build
    throw UnimplementedError();
  }

  void _onGetMeteoDetails(BuildContext context) {
    String v = txt_ville.text;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MeteoDetailsPage(v)));
    txt_ville.text = "";
  }
}

