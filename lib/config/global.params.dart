import 'package:flutter/material.dart';
import 'package:voyage/notifier/theme.dart';
class GlobalParams {

  static List<Map<String,dynamic>>menus=[
    {"title":"Accueil","icon":Icon(Icons.home,color:Colors.blue,),
      "route":"/home"
    },
    {"title":"Météo","icon":Icon(Icons.sunny_snowing,color:Colors.blue,),
      "route":"/meteo"
    },
    {"title":"Gallerie","icon":Icon(Icons.home,color:Colors.blue,),
      "route":"/Gallerie"
    },
    {"title":"Pays","icon":Icon(Icons.location_city,color:Colors.blue,),
      "route":"/Pays"
    },
    {"title":"Contact","icon":Icon(Icons.contact_page,color:Colors.blue,),
      "route":"/Contact"
    },
    {"title":"Paramétres","icon":Icon(Icons.settings,color:Colors.blue,),
      "route":"/paramétres"
    },
    {"title":"Déconnexion","icon":Icon(Icons.logout,color:Colors.blue,),
      "route":"/authentification"
    },

  ];

  static List<Map<String,dynamic>>accueil=[
    {'imaage':AssetImage('images/icons/meteo.png',),"route":"/meteo"},
    {'imaage':AssetImage('images/icons/gallerie.png',),"route":"/Gallerie"},
    {'imaage':AssetImage('images/icons/pays.png',),"route":"/pays"},
    {'imaage':AssetImage('images/icons/contact.png',),"route":"/contact"},
    {'imaage':AssetImage('images/icons/parametres.png',),"route":"/parametres"},
    {'imaage':AssetImage('images/icons/deconnexion.png',),"route":"/authentification"},
  ];
  static MonTheme themeActuel=MonTheme();
}