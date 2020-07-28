import 'package:Alcantarillado/pasos.dart';
import 'package:flutter/material.dart';
import 'package:Alcantarillado/resultados_page.dart';
import 'entradas.dart';
import 'normatividad_page.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget { 
   
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> { 

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      title: 'Alcantarillado',
      initialRoute: "inicio",
      routes: <String, WidgetBuilder>{
        "inicio"        : (BuildContext context) => Entradas(),
        "normatividad"  : (BuildContext context) => Normatividad(),
        "resultados"    : (BuildContext context) => Resultados(),
        "pasos"         : (BuildContext context) => Pasos(), 
      }
    );
  } 
   
}