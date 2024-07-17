import 'package:flutter/material.dart';
import 'package:voyage/pages/pays-details.dart';
import '../menu/drawer.widget.dart';

class Payspage extends StatelessWidget {
  final TextEditingController txt_pays = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Pays'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.white, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: txt_pays,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on_sharp),
                    hintText: "Pays",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),  // Corrected border color property
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade100,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    _onGetPaysDetails(context);
                  },
                  child: Text(
                    'Chercher',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onGetPaysDetails(BuildContext context) {
    String p = txt_pays.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaysDetailsPage(p),
      ),
    );
    txt_pays.clear();
  }
}
