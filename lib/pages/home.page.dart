import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/config/global.params.dart';
import 'package:voyage/menu/drawer.widget.dart';
import '../widget/homePageItemwi.widget.dart';
class HomePage extends StatelessWidget {


  @override
    Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(


        centerTitle: true,

        title: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(seconds: 2),
          builder: (context, double_val, chil) {
            return Opacity(
              opacity: double_val,
              child: Text('Homme Page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,


                ),
              ),
            );
          },
        ),

        backgroundColor: Colors.purple,),
      body:
      Column(
        children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Text("Utilisateur: ${user?.email}",
            style: TextStyle(fontSize: 22)),
      ),
          Center(
            child: Wrap(
              children: [
                HomePageItem(imagePath: 'images/icons/meteo.png',
                  onTap: () {
                    Navigator.pushNamed(context, '/meteo');
                  },),
                HomePageItem(imagePath: 'images/icons/gallerie.png',
                  onTap: () {
                    Navigator.pushNamed(context, '/Gallerie');
                  },),
                HomePageItem(imagePath: 'images/icons/pays.png',
                  onTap: () {
                    Navigator.pushNamed(context, '/pays');
                  },),
                HomePageItem(imagePath: 'images/icons/contact.png',
                  onTap: () {
                    Navigator.pushNamed(context, '/contact');
                  },),
                HomePageItem(imagePath: 'images/icons/parametres.png',
                  onTap: () {
                    Navigator.pushNamed(context, '/parametres');
                  },),
                HomePageItem(imagePath: 'images/icons/deconnexion.png',
                  onTap: () {
                    _Deconnexion(context);
                  },),
              ],
            ),
          ),
        ],
      ),
    );
  }


          // ***************Button Inscription **********//


  Future<void> _Deconnexion(context) async {
    FirebaseAuth.instance.signOut();
  Navigator.pushNamedAndRemoveUntil(context, '/authentification', (route) => false);
  }
}
