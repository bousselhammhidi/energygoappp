import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
    };
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enegry go',
      theme: new ThemeData(primarySwatch: Colors.green,),
      home: new MyHomePage(title: 'RAPPORT DE VISITE TECHNIQUE'),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  final _formKeyp = GlobalKey<FormState>();


  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _availableToMentor = false;
  bool _needsMentoring = false;
  bool _acceptedTermsAndConditions = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Email cannot be empty"; // TODO: Add regex based validation
    }
    return null;
  }

  String _validatePassword(String value) {if (value.isEmpty) {
      return "Password cannot be empty"; // TODO: Add regex based validation
    }
    return null;
  }

  void _toggleAvailableToMentor(bool value) {
    setState(() {
      _availableToMentor = !_availableToMentor;
    });
  }

  void _toggleNeedsMentoring(bool value) {
    setState(() {
      _needsMentoring = !_needsMentoring;
    });
  }

  void _toggleTermsAndConditions(bool value) {
    setState(() {
      _acceptedTermsAndConditions = !_acceptedTermsAndConditions;
    });
  }

  Future<List> senddata() async {
    print ("We are connected");
    final response = await http.post("http://10.188.162.251/flutter/insertdata.php",
        body: {"instalateur": _nameController.text, "clientnom": _emailController.text,  "adresse":_usernameController.text,});
    var datauser = json.decode(response.body);
  }



    @override
    Widget build(BuildContext context) {
    return new Scaffold(

        appBar: new AppBar( title: new Text(widget.title),),

      body: Center(
        child: SingleChildScrollView( child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container( constraints: BoxConstraints.expand( height: Theme.of(context).textTheme.headline4.fontSize * 1.1 + 20.0,),
        padding: const EdgeInsets.all(8.0),
        color: Colors.green,
        alignment: Alignment.center,
        child: Text('Informations Client', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white)),
        transform: Matrix4.rotationZ(0.0),), SizedBox( height: 10,),

      new Card( elevation: 12.0,  child: Column(children: <Widget>[

        Form( key: _formKey,
        child: Column(
          children: [
            TextFormField( controller: _nameController,  validator: _validateName, decoration: InputDecoration(labelText: "Installateur/Technicien ", border: OutlineInputBorder(),),),
            SizedBox(height: 10.0),
            TextFormField(controller: _usernameController, validator: _validateName, decoration: InputDecoration(labelText: "Nom du client", border: OutlineInputBorder(),),),
            SizedBox(height: 10.0),
            TextFormField(controller: _emailController, validator: _validateEmail, decoration: InputDecoration(labelText: "Adresse", border: OutlineInputBorder(),),),
            SizedBox(height: 10.0),
            TextFormField(controller: _emailController, validator: _validateEmail, decoration: InputDecoration(labelText: "Code postal & Ville", border: OutlineInputBorder(),),),
            SizedBox(height: 10.0),
            TextFormField(controller: _emailController, validator: _validateEmail, decoration: InputDecoration(labelText: "N° de téléphone", border: OutlineInputBorder(),),),
            SizedBox(height: 10.0),
          ],),
      )


      ],),),

       SizedBox( height: 10,),


       Container( constraints: BoxConstraints.expand( height: Theme.of(context).textTheme.headline4.fontSize * 1.1 + 20.0,),
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.teal,
                  alignment: Alignment.center,
                  child: Text('Descriptif Travaux', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white)),
                  transform: Matrix4.rotationZ(0.0),),


          new Card( elevation: 12.0,  child: Column(children: <Widget>[

            Form( key: _formKeyp,
              child: Column(
                children: [
                  TextFormField( controller: _nameController,  validator: _validateName, decoration: InputDecoration(labelText: "Marque et référence de l’isolant", border: OutlineInputBorder(),),),
                  SizedBox(height: 10.0),
                  TextFormField(controller: _usernameController, validator: _validateName, decoration: InputDecoration(labelText: "Marque de l’enduit", border: OutlineInputBorder(),),),
                  SizedBox(height: 10.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(padding: EdgeInsets.all(8), child: Text("Finition:"),),
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("RPE"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Autre"),],
                      ),
                    ],
                  ),

                  TextFormField(controller: _usernameController, validator: _validateName, decoration: InputDecoration(labelText: "Choix du coloris (RAL) :", border: OutlineInputBorder(),),),
                  SizedBox(height: 10.0),

                  Padding(padding: EdgeInsets.all(8), child: Text("Changement de la couleur existant:"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("Oui"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Non"),],
                      ),
                    ],
                  ),

                  Padding(padding: EdgeInsets.all(8), child: Text("Modiﬁcation de l’apparence de la façade:"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("Oui"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Non"),],
                      ),
                    ],
                  ),

                  Padding(padding: EdgeInsets.all(8), child: Text("Pompe à chaleur (groupe extérieur) à démonte:"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("Oui"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Non"),],
                      ),
                    ],
                  ),

                  Padding(padding: EdgeInsets.all(8), child: Text("Pompe à chaleur (groupe extérieur) à démonte:"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("Oui"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Non"),],
                      ),
                    ],
                  ),

                  TextFormField(controller: _usernameController, validator: _validateName, decoration: InputDecoration(labelText: "Si Non - espace disponible derrière le groupe extérieur (cm) :",),),
                  SizedBox(height: 10.0),

                  Padding(padding: EdgeInsets.all(8), child: Text("Demande intervention ENEDIS / France Telecom:"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("Oui"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Non"),],
                      ),
                    ],
                  ),

                  Padding(padding: EdgeInsets.all(8), child: Text("Besoin d’un échaﬀaudage:"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("Oui"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Non"),],
                      ),
                    ],
                  ),

                  Padding(padding: EdgeInsets.all(8), child: Text("Nécessité de prévenir le voisin:"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("Oui"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Non"),],
                      ),
                    ],
                  ),

                  Padding(padding: EdgeInsets.all(8), child: Text("Demande de voirie nécessaire:"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("Oui"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Non"),],
                      ),
                    ],
                  ),

                  Padding(padding: EdgeInsets.all(8), child: Text("Mur en limite de voirie nécessitant accord de la mairie:"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [Checkbox(value: _availableToMentor, onChanged: _toggleAvailableToMentor,),Text("Oui"),],
                      ),
                      Row(
                        children: [ Checkbox(value: _needsMentoring, onChanged: _toggleNeedsMentoring,), Text("Non"),],
                      ),
                    ],
                  ),
                  TextFormField(controller: _usernameController, validator: _validateName, decoration: InputDecoration(labelText: "Si Oui - surface du mur (m²) :", ),),
                  SizedBox(height: 10.0),

                  TextFormField(controller: _usernameController, validator: _validateName, decoration: InputDecoration(labelText: "Accès chantier:", border: OutlineInputBorder(),),),
                  SizedBox(height: 10.0),

                  TextFormField(controller: _usernameController, validator: _validateName, decoration: InputDecoration(labelText: "Nombre de jours de travail estimé:", border: OutlineInputBorder(),),),
                  SizedBox(height: 10.0),

                  TextFormField(controller: _usernameController, validator: _validateName, decoration: InputDecoration(labelText: "Commentaires:", border: OutlineInputBorder(),),),
                  SizedBox(height: 10.0),
                  
                ],
              ),
            )

          ],),),








        ]),),),

      floatingActionButton: new FloatingActionButton(
      onPressed: senddata,
      tooltip: 'Increment',
      child: new Icon(Icons.add),),

    );
  }
  Text styleshtext(String data, {color: Colors.black, fontSize: 15.0}){
    return new Text( data,  textAlign:  TextAlign.center, style: new TextStyle(color: color, fontSize: fontSize),);
  }
}


