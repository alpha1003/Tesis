import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/home_page.dart';
import 'package:proyecto/src/pages/pasos.dart';
import 'package:proyecto/src/pages/resultados_page.dart';
import 'src/pages/normatividad_page.dart';

 
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
      title: 'SewerApp',
      initialRoute: "inicio",
      routes: <String, WidgetBuilder>{
        "inicio"       : (BuildContext context) => HomePage(),
        "normatividad"  : (BuildContext context) => Normatividad(),
        "resultados"    : (BuildContext context) => ResultadosPage(),
        "pasos"         : (BuildContext context) => Pasos(), 
      }
    );
  } 
   
}