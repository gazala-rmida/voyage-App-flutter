//import 'dart:js';

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'config/global.params.dart';
import 'package:sqflite/sqflite.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/pages/Gallerie.page.dart';
import 'package:voyage/pages/contact.page.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/home.page.dart';
import 'package:voyage/pages/meteo.page.dart';
import 'package:voyage/pages/parametres.page.dart';
import 'package:voyage/pages/pays.page.dart';

ThemeData theme = ThemeData.light();
FirebaseDatabase fire =FirebaseDatabase.instance;
DatabaseReference ref =fire.ref();
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
 GlobalParams.themeActuel.setMode(await _onGetMode());
  runApp(MyApp()); }


class MyApp extends StatefulWidget {
  //theme dark
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = {
    '/home': (context) => HomePage(),
    '/inscription': (context) => InscriptionPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/meteo': (context) => Meteopage(),
    '/Gallerie': (context) => Galleriepage(),
    '/contact': (context) => ContactPage(),
    '/pays': (context) => Payspage(),
    '/parametres': (context) => ParametersPage(),
  };

  @override
  Widget build(BuildContext context) {
        return MaterialApp(

          title:"My app voyage",
          debugShowCheckedModeBanner: false,

          routes: routes,
         theme:  GlobalParams.themeActuel.getTheme(),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context,snapshot)
              {
                if(snapshot.hasData)
                return HomePage();
                else
                  return AuthentificationPage();
              } ),
        );
  }
  @override
  void iniState(){
    super.initState();
    GlobalParams.themeActuel.addListener((){

      setState(() {});
    });

  }
}
Future<String> _onGetMode()  async{
  final snapshort = await ref.child('mode').get();
  if (snapshort.exists)
    mode= snapshort.value.toString();
  else
    mode='jour';
  print(mode);
  return(mode);
}
