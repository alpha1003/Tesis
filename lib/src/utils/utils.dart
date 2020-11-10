import 'dart:math';
import 'package:proyecto/src/procesos/procesos.dart';

bool isNumeric(String s){  
    if(s.isEmpty) return false; 
    final n = num.tryParse(s); 
    return ( n == null) ? false : true; 
}

bool verificarProf(String val){
  bool res;
  if(val.isNotEmpty){
      if(isNumeric(val)){
          double p = double.parse(val); 
          if(p<0.6){ res =false;}else{ res = true;}
      }
  }else{
     res = false; 
  }

  return res; 
   
}

bool verificarProceso(Procesos p){
    if(p.rel == null){
      return false;
    }
    return true; 
  }

bool validarDiametro(String d){

 int valor;

 if(d.isEmpty){
   return true;
 }

  if(isNumeric(d)){
      valor = int.parse(d); 
      if( valor%2 != 0 || valor > 24){
          return false; 
      }else{
        return true; 
      }
  }else{
    return false; 
  }
}
 






