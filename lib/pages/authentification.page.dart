import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/button/button.connexion.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthentificationPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar
        ( centerTitle: true,

          title: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0,end: 1),
            duration: Duration(seconds: 2),
            builder: (context,double_val, chil){
              return Opacity(
                opacity: double_val,
                child: Text('Page Authentification',
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
            //******icon *****
            Container(
                padding: EdgeInsets.all(10),

                child: CircleAvatar(
                  backgroundImage :AssetImage("images/icons/login.png"),
                  radius:80,

                )



            ),

            Container(
                padding : const EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text (
                    " Utilisateur",
                    style: TextStyle(fontSize: 10 , color: Colors.purple ,
                    ),
                  ),
                )
            ),            //***************zone Identifiant ************
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: txt_login,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Identifiant",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width:1),
                    )
                ),
              ),
            ),

//***************zone Password ************
    Container(
      padding : const EdgeInsets.symmetric(horizontal: 25.0),
    child: Align(
    alignment: Alignment.centerLeft,
            child: Text (
              "Mot de Passe ",
              style: TextStyle(fontSize: 10 , color: Colors.purple ,
                  ),
            ),
    )
    ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                controller: txt_password,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    hintText: "Mot de passe",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width:1),
                    )
                ),
              ),
            ),
//**********configuration password
            //***************zone Password ************


            // ***************Button Inscription **********//

            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(

                  style: ElevatedButton.styleFrom(  backgroundColor: Colors.purple.shade100,

                      minimumSize: Size.fromHeight(50,)),
                  onPressed: (){
                    OnAuthentifier (context);
                  },
                  child: const Text(
                    "ConnexionI",
                    style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold ,),

                  )),
            ),
            //****************
            const SizedBox(height: 10,),
            Padding(
              padding : const EdgeInsets.symmetric(horizontal: 25.0),
              child :Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  Text(
                    'Mot passe oblier',
                    style:TextStyle(color:Colors.blue),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25,),
            //button  authentification
            Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    children: [
    Expanded(
    child: Divider(
    thickness: 0.5,
    color: Colors.blue,
    ),
    ),

            Padding(
            padding : const EdgeInsets.symmetric(horizontal: 10.0),
            child:
              TextButton(
                onPressed: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/inscription');
            },
                child: Text (
                  "Nouvel Utilisateur",
                  style: TextStyle(fontSize: 10 , color: Colors.pink ),
                ),
    ),
    ),
            Expanded(
                child: Divider(thickness: 0.5,
                  color: Colors.blue,
                )
                ),
          ],
        ),
    ),
                const SizedBox(height: 50),

    // google + Microsoft sign in buttons
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
    // google button
    ButtonConnexion( imagePath: 'images/icons/google.png',),

    SizedBox(width: 25),

    // apple button
    ButtonConnexion(imagePath: 'images/icons/microsoft.png')
    ],
    ),

    const SizedBox(height: 50),
    ],
                )
                );
  }

  Future<void> OnAuthentifier(BuildContext context) async {
    SnackBar snackBar = SnackBar(content: Text(""));
    if (!txt_login.text.isEmpty && !txt_password.text.isEmpty)
    {
      try
      {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: txt_login.text.trim(),
          password: txt_password.text.trim(),
        );
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      }
      on FirebaseAuthException catch (e)
      { if (e.code == 'user-not-found')
      { snackBar = SnackBar
        ( content: Text('Utilisateur inexistant'),
      );
      }
      else if (e.code == 'wrong-password')
      {
        snackBar = SnackBar(
          content: Text('Vérifier votre mot de passe'),
        );
      }
      }
      catch (e) {
        print(e);
      }
    }
    else {
      snackBar = SnackBar(
        content: Text('Id ou mot de passe vides'),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar); }
}
