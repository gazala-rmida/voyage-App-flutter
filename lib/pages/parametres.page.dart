import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'package:firebase_database/firebase_database.dart';
import '../config/global.params.dart';

String mode = "Jour";
FirebaseDatabase fire = FirebaseDatabase.instance;
DatabaseReference ref = fire.ref();

class ParametersPage extends StatefulWidget {
  @override
  State<ParametersPage> createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Page Paramètres'),
      ),
    //  backgroundColor: Colors.purple,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.white, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Mode', style: TextStyle(fontSize: 22)),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Jour'),
                  leading: IconButton(
                    icon: Icon(Icons.wb_sunny),
                    color: mode == "Jour" ? Colors.yellowAccent : Colors.grey,
                    onPressed: () {
                      setState(() {
                        mode = "Jour";
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Nuit'),
                  leading: IconButton(
                    icon: Icon(Icons.nights_stay),
                    color: mode == "Nuit" ? Colors.black : Colors.grey,
                    onPressed: () {
                      setState(() {
                        mode = "Nuit";
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(   backgroundColor: Colors.purple.shade100,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  _onSaveMode();
                },
                child: Text('Enregistrer', style: TextStyle(fontSize: 22,color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onSaveMode() async {
    GlobalParams.themeActuel.setMode(mode);
    await ref.set({"mode": mode});
    print("mode appliqué $mode");
    Navigator.pop(context);
  }
}
