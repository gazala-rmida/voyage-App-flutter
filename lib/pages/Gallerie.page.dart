import 'package:flutter/material.dart';
import 'package:voyage/pages/Gallerie-Details.page.dart';
import '../menu/drawer.widget.dart';

class Galleriepage extends StatelessWidget {
  TextEditingController txt_gallery = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(seconds: 2),
          builder: (context, double_val, child) {
            return Opacity(
              opacity: double_val,
              child: Text(
                'Gallerie',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            );
          },
        ),
        backgroundColor: Colors.purple, // Set background to transparent
      ),
      body: Container(
        // Gradient decoration for the body
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ Colors.white ,Colors.white,Colors.purple],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: txt_gallery,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.photo_library),
                  hintText: "Keyword",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () => _onGetGallerieDetailsPage(context),
                child: Text(
                  'Chercher',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGetGallerieDetailsPage(BuildContext context) {
    String Keyword = txt_gallery.text;
    Navigator.push(context, MaterialPageRoute(builder: (context) => GallerieDetailsPage(Keyword)));
    txt_gallery.text = "";
  }
}
