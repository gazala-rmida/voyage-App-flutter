import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/global.params.dart';
class MyDrawer extends StatelessWidget {
  late SharedPreferences  prefs;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
        child : ListView(
          children:  [
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors:[Colors.white,
                      Colors.purple])),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage :AssetImage("images/profil.jpg"),
                    radius:80,
                  ),
                )
            ),
//parcourrir les différents élements du menu
    ...GlobalParams.menus.map((item) {
    return Column(
    children:[
    Divider(height: 4,color:Colors.blue),
    ListTile(
    title: Text('${item['title']}',style: TextStyle(color:Colors.black,fontSize: 22),),
    leading: item['icon'],
    trailing: Icon(Icons.arrow_right,color: Colors.blue),
    onTap: () async{
    if ('${item['title']}'!="Déconnexion"){
    Navigator.pop(context);
    Navigator.pushNamed(context,"${item['route']}");
    }
    else
    {
      FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context,'/authentification',(route)=>false);

    }
    },
    ),
    ],
    );
    }
    )
    ],
    )
    );
  }
}
