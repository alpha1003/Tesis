import 'dart:math';
import 'package:Alcantarillado/DBProvider.dart';
import 'package:Alcantarillado/consultas.dart';
import 'package:Alcantarillado/relaciones.dart';

class Procesos {

    double _q,_s,_n; 
    String _material; 
    Relacion rel; 
    Consultas con = new Consultas(); 
    double _diametro,_diametroInt,_caudalTuboLleno,_v0,_qq0,_velocidadReal,_alturaVelocidad;
    double _radioHidraulico,_esfuerzoCortante,_alturaLamina,_energiaEspecifica; 
    bool again = false; 
    double _profundidadHidraulica,_numeroFroud;  
    DBProvider dBp = new DBProvider(); 
    List<String> lista; 
    Map<int,double> diametros = {  
      8 : 0.201,
      10 : 0.251,
      12 : 0.299, 
      14 : 0.35,
      16 : 0.40,
      18 : 0.45
    }; 

    Procesos(q,s,material) { //Constructor de la clase procesos, se reciben los valores de pendiente, material y caudal
      this._q = q;
      this._s = s;
      this._material = material;
      
       
    } 

    double getDiametro() => _diametro; 

    double getDiametroInt() => _diametroInt; 

    double getQQ0() => _qq0;  

    double getCaudalATuboLleno() => _caudalTuboLleno; 

    void setDiametro(double diametro){
          _diametro = diametro; 
          _diametroInt = diametros[diametro];
          again = true;  
    }

    //Método para calcular el diámetro 
    Future<double> calcularDiametro() async{ 

         _n = await con.buscarRugosidad(_material); 
          //Buscamos rugosidad
        _diametro =  1.548 * pow(((_n*_q)/pow(_s, 0.5)),3/8);

        
        _diametro = double.parse(_diametro.toStringAsFixed(3));
        print(_n.toString()+" "+_q.toString()+" "+_s.toString());
        print("DIAMETRO Nominal0: "+_diametro.toString());  
        _diametro = _diametro * 39.37; //Conversion   

         print("DIAMETRO Nominal1: "+_diametro.toString()); 
        _diametro = diametroInterno(_diametro).toDouble(); 
        print("DIAMETRO Nominal: "+_diametro.toString()); 
        print("DIAMETRO Interno: "+_diametroInt.toString());
        print("Rugosidad: " +_n.toString());  
        return _diametro; 
    
    } 

    int diametroInterno(double _diametro){ 
            
            int val = _diametro.round(); 
            print("DIAMETRO Nominal redondeado: "+val.toString()); 

            if(val < 20){
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

            _diametroInt = diametros[val]; 
            return val; 
    } 

    double ccaudalTuboLleno(){ 
        _caudalTuboLleno = 312 * ((pow(_diametroInt, 8/3)*pow(_s,0.5))/_n); 
        _caudalTuboLleno = double.parse(_caudalTuboLleno.toStringAsFixed(3)); 
        print("Caudal a tubo lleno: "+_caudalTuboLleno.toString()); 
        return _caudalTuboLleno; 
    } 

    double calculoV0(){
      double radio = _diametroInt/2; 
      double areatT = pi* pow(radio,2); 
      _v0 = _caudalTuboLleno / areatT; 

      _v0 = double.parse(_v0.toStringAsFixed(3)); 
      return _v0; 
    }

    Future<Relacion> relacion() async {

      _qq0 = _q/_caudalTuboLleno; 
      _qq0 = double.parse(_qq0.toStringAsFixed(2));
      print("QQ0 "+_qq0.toString()); 
      //_qq0 = 0.12; 
      rel = await con.buscarRelacion(_qq0);

      return rel;   
      
    }

    velocidadReal() async {

      await relacion(); 

      if(rel == null){
          _velocidadReal = 0;  
      }else{
          _velocidadReal = rel.vv0 * _v0; 
          _alturaVelocidad = (_velocidadReal*_velocidadReal)/(2*9.8); 
      
          _velocidadReal = double.parse(_velocidadReal.toStringAsFixed(3)); 
          return _velocidadReal; 
      }
       
      

    } 

    double radioHidraulico(){
      _radioHidraulico = rel.dD * (_diametroInt/4);

      _radioHidraulico = double.parse(_radioHidraulico.toStringAsFixed(3)); 
      return _radioHidraulico;  
    }

    double esfuerzoCortante(){
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
          _profundidadHidraulica = double.parse(_profundidadHidraulica.toStringAsFixed(3)); 
          return _profundidadHidraulica; 
    }

    double numeroFroud(){
      _numeroFroud = _velocidadReal / (sqrt((9.81 * _profundidadHidraulica))); 
      _numeroFroud = double.parse(_numeroFroud.toStringAsFixed(3)); 
      return _numeroFroud; 
    }
    
    Future<void> calcular() async { 

        if(again==false){
            await calcularDiametro();
        } 
         ccaudalTuboLleno(); 
         calculoV0(); 
         await velocidadReal(); 

         if(_velocidadReal != 0){
            radioHidraulico(); 
            esfuerzoCortante();
            alturaLaminaDeAgua(); 
            energiaEspecifica(); 
            profundidadHidraulica(); 
            numeroFroud(); 

          lista = new List();
              lista.add( _diametro.toString());
              lista.add(_caudalTuboLleno.toString());
              lista.add(_v0.toString());
              lista.add(_qq0.toString()); 
              lista.add(_velocidadReal.toString());
              lista.add(_radioHidraulico.toString());
              lista.add(_esfuerzoCortante.toString());
              lista.add(_alturaLamina.toString());
              lista.add(_alturaVelocidad.toString());
              lista.add(_energiaEspecifica.toString());
              lista.add(_profundidadHidraulica.toString());
              lista.add(_numeroFroud.toString());
         } 
          
        
        
    }

    





}