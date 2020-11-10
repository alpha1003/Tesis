import 'package:proyecto/src/procesos/procesos.dart';

class Perdidas {

    Map<double,double> tabla = {
      1 : 0.4,
      1.1 : 0.4,
      1.2 : 0.4,
      1.3 : 0.4,
      1.4 : 0.4,
      1.5 : 0.2,
      1.6 : 0.2,
      1.7 : 0.2,
      1.8 : 0.2,
      1.9 : 0.2,
      2.1 : 0.2,
      2.2 : 0.2,
      2.3 : 0.2,
      2.4 : 0.2,
      2.5 : 0.2,
      2.6 : 0.2,
      2.7 : 0.2,
      2.8 : 0.2,
      2.9 : 0.2,
      3 : 0.05,
  }; 
    
    double _k = 0.1;
    Procesos p1,p2; 

    set kavalor(double k) => _k = k; 
    double get kvalor => _k;  

    Perdidas({Procesos pr1, Procesos pr2}){this.p1 = pr1; this.p2 = pr2;}

    double pTran(){
      var res = _k *(p2.altVelocidad-p1.altVelocidad);
       res = double.parse(res.toStringAsFixed(3));
       p1.pTransicion = res; 
       return res;    
    } 

    double perdidasRcD(){
         var res = 0.6/p2.getDiametroInt();
         res = double.parse(res.toStringAsFixed(1));
         print("RcD :::: "+res.toString()); 
         p1.pRcD = res; 
         return res;  
    }
    double perdidasCurva(){
        var k = tabla[p1.pRcD];
        var res = k * p1.altVelocidad; 
        return res; 
    }

  }