

class Relacion {

    int _id; 
    double _qq0,_vv0,_dD,_rr0,_hd; 

    Relacion(
        this._id,
        this._qq0,
        this._vv0,
        this._dD,
        this._rr0,
        this._hd
    );

   

  Relacion.fromMap(dynamic obj){
    
    //this._id = int.parse(obj["QQO"].toString());
    this._qq0 = double.parse(obj["QQ0"].toString()); 
    this._vv0 = double.parse(obj["VV0"].toString()); 
    this._dD  = double.parse(obj["dD"].toString()); 
    this._rr0 = double.parse(obj["RR0"].toString()); 
    this._hd  = double.parse(obj["HD"].toString()); 

  } 

  int get id => _id; 
  double get qq0 => _qq0;
  double get vv0 => _vv0;
  double get dD => _dD;
  double get rr0 => _rr0; 
  double get hd => _hd; 



}
