import 'dart:math';
import 'package:flutter/cupertino.dart';

import 'package:proyecto/src/provider/DBProvider.dart';
import 'package:proyecto/src/provider/consultas.dart';
import 'package:proyecto/src/modelos/relaciones.dart';
import 'package:proyecto/src/const/const.dart' as cst;


class Procesos {

    Relacion rel;
    Consultas con = new Consultas();

    String  _material = "PVC/CPVC", _ucaudal = "m³/s", _upendiente = "Dec(0.0)";
    double _diametro,_diametroInt,_caudalTuboLleno,_v0,_qq0,_velocidadReal,_alturaVelocidad;
    double _radioHidraulico,_esfuerzoCortante,_alturaLamina,_energiaEspecifica,_q,_s,_n,_profundidadHidraulica,_numeroFroud; 
    double cotaR1,cotaR2,longitud,cotaC1,cotaC2,cotaB1,cotaB2,cotaL1,cotaL2,profundidad,_pcurva=0,_rcD=0,_transicion=0;
   
    final tec1 = TextEditingController();
    final tec2 = TextEditingController();
    final tec3 = TextEditingController();
    final tec4 = TextEditingController(); 
    final tec5 = TextEditingController();
    final tec6 = TextEditingController();  
    final tec7 = TextEditingController();
    final tec8 = TextEditingController();  

    set pRcD(double p) => _rcD = p; 
    set pTransicion(double p) => _transicion = p; 
    set pcurva(double p) => _pcurva = p; 
    set again(bool a) => _again = a; 
    bool get vagain => _again;
    double get pcurva => _pcurva;
    double get  pTransicion => _transicion;
    double get pRcD => _rcD; 


  
    double get radioHidraulico => _radioHidraulico;
    double get esfuerzoCortante => _esfuerzoCortante;
    double get alturaLam => _alturaLamina; 
    double get energiaEspe => _energiaEspecifica;  
    double get profHidra => _profundidadHidraulica;    
    double get numFroud => _numeroFroud; 
    double get v0 => _v0; 
    double get velReal => _velocidadReal; 
    double get altVelocidad => _alturaVelocidad; 

    
    
    bool _again = false, _curvatura=false;  
    DBProvider dBp = new DBProvider(); 
    List<String> lista; 
     

    

     set cotaClave1(double cc1) => cotaC1 = cc1;
     double get cotaClave1 => cotaC1;
     set cotR1(double c1) => cotaR1 = c1;
     double get cotR1 => cotaR1;
     set cot2(double c2) => cotaR2 = c2;
     double get cr2 => cotaR2;
     set distancia(double l) => longitud = l;
     double get ditancia => longitud;
     set prof(double p) => profundidad = p;
     double get prof => profundidad; 

    void setQ(double q){_q = q;}
    void setS(double s){_s = s;}
    void setUcaudal(String u){_ucaudal = u;}
    void setUpendiente(String u){_upendiente = u;}
    void setMaterial(String m){_material = m;}
    void setCurva(bool c){_curvatura=c;} 

    double getQ(){return _q;}
    double getS(){return _s;} 
    String getUcaudal() => _ucaudal;
    String getUpendiente() => _upendiente; 
    String getMaterial() => _material;  
    bool getCurva() => _curvatura;  
    double getDiametro() => _diametro; 
    double getDiametroInt() => _diametroInt; 
    double getQQ0() => _qq0;  
    double getCaudalATuboLleno() => _caudalTuboLleno; 

    void setDiametro(double diametro){
          _diametro = diametro; 
          _diametroInt = cst.diametros[diametro];     
    }

    void convertir(){
      if(_ucaudal == "l/s"){
         _q = _q/1000;
         _q = double.parse(_q.toStringAsFixed(5)); 
      } 
      if(_upendiente == "Por(%)"){
        _s = _s / 100;
        _s = double.parse(_s.toStringAsFixed(5)); 
      }
  }

    //Método para calcular el diámetro 
    Future<double> calcularDiametro() async{
      
        _diametro =  1.548 * pow(((_n*_q)/pow(_s, 0.5)),3/8); 
        _diametro = double.parse(_diametro.toStringAsFixed(3)); 
        _diametro = _diametro * 39.37; //Conversion   
        _diametro = diametroInterno(_diametro).toDouble(); 
           
        return _diametro;

    } 

    int diametroInterno(double _diametro){ 
            
            int val = _diametro.round(); 

            if(val < 24){
                if(val < 8){
                  val = 8; 
                }else{
                  if(val % 2 != 0){
                    if(val <= 11){
                      val+=1; 
                    }else{
                      val-=1; 
                    }
                  }
                }
            }else{
              val = 14; 
            } 

            _diametroInt = cst.diametros[val]; 
            return val; 
    } 

    double ccaudalTuboLleno(){ 
        _caudalTuboLleno = 312 * ((pow(_diametroInt, 8/3)*pow(_s,0.5))/_n); 
        _caudalTuboLleno = double.parse(_caudalTuboLleno.toStringAsFixed(3)); 
        return _caudalTuboLleno; 
    } 

    double calculoV0(){

      double radio = _diametroInt/2; 
      double areatT = pi* pow(radio,2);

      _v0 = (_caudalTuboLleno/1000) / areatT; 
      _v0 = double.parse(_v0.toStringAsFixed(3));

      return _v0; 
    }

    Future<Relacion> relacion() async {

      _qq0 = (_q*1000)/_caudalTuboLleno; 
      _qq0 = double.parse(_qq0.toStringAsFixed(2)); 
      rel = await con.buscarRelacion(_qq0);
      return rel;   
      
    }

    Future<double> velocidadReal() async {   
          _velocidadReal = rel.vv0 * _v0; 
          _alturaVelocidad = (_velocidadReal*_velocidadReal)/(2*9.8); 
          _alturaVelocidad = double.parse(_alturaVelocidad.toStringAsFixed(3)); 
          _velocidadReal = double.parse(_velocidadReal.toStringAsFixed(3));  
        
        return _velocidadReal; 

    } 

    double radioHidra(){
      _radioHidraulico = rel.dD * (_diametroInt/4);
      _radioHidraulico = double.parse(_radioHidraulico.toStringAsFixed(3)); 
      return _radioHidraulico;  
    }

    double esfuerzoCorta(){
      _esfuerzoCortante = 9810 * _radioHidraulico * _s; 
      _esfuerzoCortante = double.parse(_esfuerzoCortante.toStringAsFixed(3)); 
      return _esfuerzoCortante; 
    }

    double alturaLaminaDeAgua(){
      _alturaLamina = rel.dD * _diametroInt; 
      _alturaLamina = double.parse(_alturaLamina.toStringAsFixed(3)); 
      return _alturaLamina;  
    } 

    double energiaEspecifica(){
       _energiaEspecifica = _alturaLamina + _alturaVelocidad; 
       _energiaEspecifica = double.parse(_energiaEspecifica.toStringAsFixed(3)); 
       return _energiaEspecifica; 
    }

    double profundidadHidraulica(){
          _profundidadHidraulica = rel.hd * _diametroInt;  
          _profundidadHidraulica = double.parse(_profundidadHidraulica.toStringAsFixed(2)); 
          return _profundidadHidraulica; 
    }

    double numeroFroud(){
      _numeroFroud = _velocidadReal / (sqrt((9.81 * _profundidadHidraulica))); 
      _numeroFroud = double.parse(_numeroFroud.toStringAsFixed(2));
      return _numeroFroud; 
    }
    
    void calcularCotas(){
       cotaC1 = cotaR1 - profundidad; 
       cotaC2 = cotaC1 - (_s * longitud); 
       cotaB1 = cotaC1 - getDiametroInt(); 
       cotaB2 = cotaB1 - (_s * longitud); 
       cotaL1 = cotaB1 + _alturaLamina; 
       cotaL2 = cotaL1 - (_s * longitud); 
    }

    Future<void> calcular() async {

      _n = await con.buscarRugosidad(_material);

        if(_again == false && _diametro == null){
            await calcularDiametro();
        }
         ccaudalTuboLleno(); 
         calculoV0();

         await relacion();

         if(rel != null){
            velocidadReal(); 
            radioHidra(); 
            esfuerzoCorta();
            alturaLaminaDeAgua(); 
            energiaEspecifica(); 
            profundidadHidraulica(); 
            numeroFroud(); 
            calcularCotas(); 

         }   
    }

    
}