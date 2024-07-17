

import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'ajout_modif_contact.page.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import '../model/contact.model.dart';
import '../services/contact.service.dart';
class ContactPage extends StatefulWidget{
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactService contactService = ContactService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(seconds: 2),
          builder: (context, double_val, child) {
            return Opacity(
              opacity: double_val,
              child: Text(
                'page Contact',
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
       body: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [ Colors.white ,Colors.white,Colors.purple],
           ),
         ),
         child: Center(
           child: Column(
             children: [
               SizedBox(height: 10,),
               Align( alignment :Alignment.centerRight,
               child: FormHelper.submitButton("Ajout",
                   (){
                 Navigator.push(context,
                   MaterialPageRoute(
                     builder: (context)=> AjoutModifContactPage(),
                   ),).then((value) {setState(() {});
                   });
                 },
               borderRadius: 10,
               btnColor: Colors.purple,
               borderColor:Colors.purpleAccent,
               ),
               ),
               SizedBox(
                 height: 10,),
           _fetchData(),
             ],
           ),
         ),
       ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
  _fetchData(){
    return FutureBuilder(
      future: contactService.listeContacts(),
    builder: (context, snapshot) {
        if(snapshot.hasData)
          return _buildDataTable(snapshot.data!);
        return Center(child:
          CircularProgressIndicator());
    },
      );
  }
_buildDataTable(List<Contact> listContacts) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
  child: ListUtils.buildDataTable(
    context,
    ["Nom","Telephone","Action"],
    ["nom","tel",""],
    false,
    0,
    listContacts,
      (Contact c ){
      //modifier contact
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:(context) => AjoutModifContactPage(
          modifMode: true,
          contact: c,
        ),
        ),
        ).then((value) {
          setState((){});
  });
      },
      (Contact c){
      //supprimer contact
        return showDialog(
          context: context,
            builder:(BuildContext context){
  return AlertDialog(
  title: const Text("Supprimer Contact"),
  content: const Text(
  "Etes vous sur de vouloir supprimer ce contact?"),
  actions:[
  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      FormHelper.submitButton(
      "Oui",
      (){
      contactService.supprimerContact(c).then((value){
      setState(()
      {
      Navigator.of(context).pop();
      });
      });
      },
      width: 100,
      borderRadius: 5,
      btnColor: Colors.green,
      borderColor: Colors.green,
      ),
      const SizedBox(
      width: 20,
      ),
      FormHelper.submitButton(
      "Non",
      (){
      Navigator.of(context).pop();
      },
  width: 100,
  borderRadius: 5,
  ),
  ],

  )
  ],
  );
  },

        );
            },
    headingRowColor: Colors.purple,
    isScrollable: true,
    columnTextFontSize: 20,
    columnTextBold: false,
    columnSpacing: 50,
    onSort: (columnIndex, columnName, asc){},
  ),);
}
}