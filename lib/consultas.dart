import 'dart:async';
import 'package:Alcantarillado/DBProvider.dart';
import 'package:Alcantarillado/relaciones.dart'; 


class Consultas {

  DBProvider con = new DBProvider(); 

  Future<Relacion> buscarRelacion(double qq0) async{
    double rel = double.parse(qq0.toStringAsFixed(2));  
    //print("RELACION: "+rel.toString()); 
    var dbClient = await con.db; 
    var res = await dbClient.rawQuery("SELECT * FROM relaciones WHERE QQ0 = '$rel' ");

    if(res.length>0){
       Relacion obj = new Relacion.fromMap(res.first); 
       return obj;  
    }else{
      print("Vacío no hay respuesta");
      return null; 
    }
  } 

  Future<double> buscarRugosidad(String nombre) async{ 
    var dbClient = await con.db; 
  
    var res = await dbClient.rawQuery("SELECT * FROM rugosidad WHERE nombre = '$nombre' ");
    double rugosidad; 

    if(res.length>0){
       rugosidad = double.parse(res.first["rugosidad"].toString());   
       return rugosidad; 
    }else{
      return null; 
    }
  }


}
