import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/button/button.connexion.dart';

class InscriptionPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();
  TextEditingController txt_confirmPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(seconds: 2),
          builder: (context, double_val, chil) {
            return Opacity(
              opacity: double_val,
              child: Text(
                'Page Inscription',
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
              backgroundImage: AssetImage("images/icons/background.jpg"),
              radius: 80,
            ),
          ),
          //***************zone Identifiant ************
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Utilisateur ",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Identifiant",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
          ),
          //*************** Password ************
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mot de Passe ",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.purple,
                ),
              ),
            ),
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
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirmer le  mot de passe ",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              controller: txt_confirmPassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                hintText: "Confirmer le  mot de passe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
          ),
          // ***************Button Inscription **********//
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: () {
                OnInscrire(context);
              },
              child: Text(
                "Inscription",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          //mot passe oblier
          //ou bien connecte avec
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/authentification');
                    },
                    child: Text(
                      "j'ai déja un compte",
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.blue,
                  ),
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
              ButtonConnexion(imagePath: 'images/icons/google.png'),
              SizedBox(width: 25),
              // apple button
              ButtonConnexion(imagePath: 'images/icons/microsoft.png'),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Future<void> OnInscrire(BuildContext context) async {
    SnackBar snackBar;
    try {
      if (txt_login.text.trim().isEmpty || txt_password.text.trim().isEmpty || txt_confirmPassword.text.trim().isEmpty) {
        snackBar = SnackBar(content: Text("Id ou mot de passe vides"));
      } else if (txt_password.text.trim() != txt_confirmPassword.text.trim()) {
        snackBar = SnackBar(content: Text("Les mots de passe ne correspondent pas"));
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: txt_login.text.trim(),
          password: txt_password.text.trim(),
        );
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snackBar = SnackBar(content: Text('Mot de passe faible'));
      } else if (e.code == 'email-already-in-use') {
        snackBar = SnackBar(content: Text('Email déjà existant'));
      } else {
        snackBar = SnackBar(content: Text('Erreur: ${e.message}'));
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
