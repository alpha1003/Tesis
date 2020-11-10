import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto/src/procesos/perdidas.dart';
import 'package:proyecto/src/procesos/procesos.dart'; 
import 'package:proyecto/src/utils/utils.dart' as util; 
import 'package:proyecto/src/const/const.dart' as cst;


class HomePage extends StatefulWidget {
   @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>(); 
  Procesos proceso = new Procesos();
  Procesos proceso2 = new Procesos(); 
  bool _tramo = false; 

  @override
  Widget build(BuildContext context) { 
    
    return Scaffold(
        appBar: AppBar(
            title: Text("Sewerage"),
        ),
        drawer: _drawer(),
        body:  SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                   _portada(),
                   _intro(),
                   Text("Primer tramo"),
                   _espacio(proceso,formKey),
                   Visibility( 
                       child: Column(
                          children: [
                             Text("Segundo Tramo"),
                             _espacio(proceso2,formKey2),
                          ],
                       ),
                       visible: _tramo,

                   ),
                   _fboton(),
                   _summitAndCalc(),                   
                ],
            ),
        ), 
    );
  }

  Widget _drawer() {
    return Drawer(
      elevation: 20.0,
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                "Sewerage",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.cyan[200]),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/portada2.jpg"),
                      fit: BoxFit.cover)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Menú",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w300,
                    )),
              ],
            ),
            Divider(),
            ListTile(
              title: Text("Normatividad"),
              leading: Icon(
                Icons.assignment,
                color: Colors.blue,
              ),
              subtitle:
                  Text("Ver las normas que rigen el alcantarillado sanitario"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "normatividad");
              },
            ),
             Divider(),
            ListTile(
              title: Text("Paso a paso"),
              leading: Icon(
                Icons.assignment,
                color: Colors.blue,
              ),
              subtitle:
                  Text("Ver detalladamente el proceso de cálculo"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "pasos");
              },
            ),
            
            ListTile(
              title: Text("Acerca de la app"),
              leading: Icon(
                Icons.perm_identity,
                color: Colors.blue,
              ),
              subtitle: Text("Desarrolladores, Finalidad, Objetivos"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _portada(){
  return Container(
           child: Image(
             image: AssetImage("assets/portada.jpg"),
          ),
    );
  }

  Widget _summitAndCalc(){
      return RaisedButton(
          child: Text("Proceder a calcular"),
          color: Colors.blue,
          shape: StadiumBorder(),
          onPressed: summitAndCalc,
      );
  }

  Widget _fboton(){

      return Column(
         mainAxisAlignment: MainAxisAlignment.center, 
         mainAxisSize: MainAxisSize.max, 
         children: [
             Text("Agregar o quitar tramo"),
             SizedBox(height: 15.0,), 
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    FloatingActionButton(
                        heroTag: "f1",
                        child: Icon(Icons.clear),
                        onPressed: (){
                          setState(() {
                             _tramo = false;
                          });
                        },
                    ),
                     FloatingActionButton(
                        child: Icon(Icons.add),
                        heroTag: "f2",
                        onPressed: (){
                          setState(() {
                             _tramo = true;  
                          });
                        },
                    ),
                  
                ],
             ),
             SizedBox(height: 15.0,),
         ],
      );
  }

  Widget _intro(){
     return Container(
       
       child: Card(
            elevation: 7.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.live_help,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "Instrucciones",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  subtitle: Text(
                    "A continuación se procede a realizar los cálculos para el desarrollo de"
                    "alcantarillado sanitario.\n"
                    "1. Por favor escoja adecuadamente las unidades de caudal y pendiente.\n"
                    "2. Si no se ingresa un diámetro éste será calculado automaticamente. \n"
                    "3. Podrá realizar cálculos para 1 o 2 tramos de tuberia- \n"
                    "4. La curvatura es por defecto de 90°.\n"
                    "5. El valor RC es de 0.6, ya que se manejan diámetros de menos de 24\" .\n"
                    "6. Para calcular las pérdidas se usa un valor por defecto de k=0.1\n",
                    textAlign: TextAlign.justify,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "normatividad");
                  },
                  child: Text(
                    "Ver toda la normatividad",
                    style: TextStyle(color: Colors.indigoAccent),
                  ),
                ),
              ],
            ),
          ),  
     );
  }

  Widget _espacio(Procesos p, GlobalKey<FormState> llave){
      return Container(
          decoration: BoxDecoration(
            color: Colors.white12,
          ),
          margin: EdgeInsets.all(20.0),
          child: Form(
                key: llave,
                child: Column(
                children: [
                    _caudal(p),
                    SizedBox(height: 15.0,),
                    _pendiente(p),
                    SizedBox(height: 15.0), 
                    _diametro(p),
                    SizedBox(height: 15.0,),
                    _crearDropdown(p),
                    _cotas(p),           
                ],
            ),
          ),
      );
  }

  Widget _caudal(Procesos p) {

    return TextFormField(
        controller: p.tec1,
        validator: (value) {
          return(util.isNumeric(value))?null:"El valor no es correcto"; 
        },
        onSaved: (newValue) => p.setQ(double.parse(newValue)),        
        autofocus: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: "Valor de caudal",
              icon: ImageIcon(
                AssetImage("assets/agua.png"),
                color: Colors.blueAccent,
              ),
              suffix: DropdownButton(
                isDense: true,
                value: p.getUcaudal(),
                items: getOpciones(cst.listaUnidades),
                onChanged: (opt) {
                  setState(() {
                     p.setUcaudal(opt);  
                  });
                },
              ),
            ),
    );
  }
 
   Widget _diametro(Procesos p) {

    return TextFormField(
        controller: p.tec8,
        validator: (value) {
          return(util.validarDiametro(value))?null:"El diametro no es correcto"; 
        },
        onSaved: (value) {
            if(value.isNotEmpty){
               p.setDiametro(double.parse(value));
            }
        }, 
        autofocus: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: "Valor del diámetro, si se conoce",
              icon: ImageIcon(
                AssetImage("assets/diamete.png"),
                //color: Colors.blueAccent,
              ),
            ),
    );
  }

  Widget _cotas(Procesos p){
      return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
        children: [
            _defaultTF("Cota 1", "En metros", "cota1", p),
            SizedBox(width: 10.0,),
            _defaultTF("Cota 2", "En metros", "cota2", p),
        ],    
           ),
         SizedBox(height: 10.0, ),
        Row(
           children: [
              _defaultTF("Profundidad", "En metros", "profundidad", p),
             SizedBox(width: 10.0,),
              _defaultTF("Longitud", "En metros", "longitud", p),  
           ],
        ),
        SizedBox(height: 10.0, ),
         
      ]
      );
  }

  Widget _pendiente(Procesos p) {
    return TextFormField(
        controller: p.tec2,
        autofocus: false,
        keyboardType: TextInputType.number,
        validator: (value){
            return(util.isNumeric(value))?null:"El valor no es correcto"; 
        },
        onSaved: (value)=>p.setS(double.parse(value)),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: "Valor de la pendiente",
          suffix: DropdownButton(
            isDense: true,
            value: p.getUpendiente(),
            items: getOpciones(cst.listaPendientes),
            onChanged: (opt) {
              setState(() {
                p.setUpendiente(opt);   
              });
            },
          ),
          icon: ImageIcon(
            AssetImage("assets/meter.png"),
            color: Colors.blueAccent,
          ),
        ),
    );
  }

  Widget _crearDropdown(Procesos p) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image(
          image: AssetImage("assets/material.jpg"),
          width: 25.0,
          height: 25.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          width: 150.0,
          child: DropdownButton(
            isExpanded: true,
            isDense: true,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            value: p.getMaterial(),
            items: getOpciones(cst.listaMateriales),
            onChanged: (opt) {
              setState(() {
                  p.setMaterial(opt);
              });
            },
          ),
        ),
         Column(
            children: [
                Text("¿Existe curvatura?"),
                Switch(

                     value: p.getCurva(),
                     onChanged: (val){
                        setState(() {
                            p.setCurva(val);  
                        }); 
                     },
                ),
            ],
         ), 
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpciones(List<String> list) {
    List<DropdownMenuItem<String>> lista = new List();
    list.forEach((item) {
      lista.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    });
    return lista;
  }

  void summitAndCalc() async {

    if(_tramo==false){
        if (!formKey.currentState.validate()) {  //Validamos los datos ingresados
          return; 
        }else{   
            if(proceso.vagain==false){
                formKey.currentState.save();
                proceso.convertir(); 
            }
            await proceso.calcular();
            if(util.verificarProceso(proceso)==false){
                mostrarAlert(context, proceso, 1); 
            }else{
              List<Procesos> lista = [proceso];
              vaciarInstancia(); 
              Navigator.popAndPushNamed(context, "resultados", arguments: lista); 
            }
        }
    }else{
          if (!formKey.currentState.validate() || !formKey2.currentState.validate() ) {  //Validamos los datos ingresados
              return; 
          }else{      
              if(proceso.vagain==false){
                proceso.convertir();
                formKey.currentState.save();
              }   
              await proceso.calcular(); 
              if(util.verificarProceso(proceso)==false){
                mostrarAlert(context, proceso, 1); 
              }else{
                if(proceso2.vagain==false){
                  formKey2.currentState.save();
                  proceso2.convertir(); 
                }
                await proceso2.calcular(); 
                if(!util.verificarProceso(proceso2)){
                  mostrarAlert(context, proceso2, 2); 
                }else{
                  Perdidas per = new Perdidas(pr1: proceso, pr2: proceso2);
                  per.pTran(); 
                  per.perdidasRcD(); 
                  per.perdidasCurva();  
                  List<Procesos> lista = [proceso,proceso2];
                  vaciarInstancia(); 
                  //Navigator.pushNamed(context, "resultados", arguments: lista);
                  Navigator.popAndPushNamed(context, "resultados",arguments: lista);
                   
                } 
              }  
          }
    }
     
  }

  void preguntarDiametro(BuildContext context, Procesos p, int tramo) {
    double d; 
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            title: Text("Ingrese el valor del nuevo díametro",style: TextStyle(color: Colors.blue),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                    //autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "Valor del diámetro comercial",
                        labelText: "Diámetro en pulgadas",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.help),
                            onPressed: () {
                                    Fluttertoast.showToast(
                                       msg: "Diámetros comerciales en pulgadas \n"
                                            " 8 - 10 - 12 - 14 - 16 - 18 - 20 - 22 - 24 ",
                                       gravity: ToastGravity.CENTER,
                                    );
                              }
                            )
                          ),
                    onChanged: (valor) {
                      setState(() {
                        if (util.isNumeric(valor)==true) {
                          d = double.parse(valor);
                        }else{
                          d = 0; 
                        }
                      });
                    }),
              ],
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  if (d == 0 ||
                      d > 24 ||
                      d < 8 ||
                      (d % 2) != 0) {
                      //Mostrar alerta
                        Fluttertoast.showToast(
                                       msg: "¡Ingrese un valor válido!", 
                                       gravity: ToastGravity.CENTER,
                                    );
                  } else {
                    setState(() {
                        p.setDiametro(d); 
                        p.again = true; 
                        Navigator.of(context).pop();
                        summitAndCalc();
                    });
                  }
                },
                child: Text("Cambiar"),
                color: Colors.blue,
              ),
            ],
          );
        });
  }

  void mostrarAlert(BuildContext context, Procesos p, int tramo) {
    
    showDialog(
        context: context,
        barrierDismissible: true,
        useSafeArea: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              "¡Algo no cuadra en el tramo $tramo!",
              style: TextStyle(color: Colors.red),
            ),
            content: SingleChildScrollView(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Verifique que los parametros ingresados se ajusten: \n" +
                    "Diámetro nominal:  " +
                    p.getDiametro().toString() +
                    " pulgadas \n" +
                    "Diámetro interno: " +
                    p.getDiametroInt().toString() +
                    "m \n" +
                    "Caudal a tubo lleno: " +
                    p.getCaudalATuboLleno().toString() +
                    "m³/s \n" +
                    "Relación q/q0: " +
                    p.getQQ0().toString()),
                    SizedBox(height: 20.0,),
                Text("¿Desea ajustar manualmente el valor del diámetro? \n" +
                    "Presione 'Sí' para ajustar el díametro, 'No', para ajustar los parámetros de diseño."),
              ],
                ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                     p.tec1.clear();
                     p.tec2.clear(); 
                     Navigator.of(context).pop();
                  },
                  child: Text("No")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    preguntarDiametro(context,p,tramo);
                  },
                  child: Text("Sí")),
            ],
          );
        });
  }

  void vaciarInstancia(){
    proceso.tec1.clear();
    proceso.tec2.clear();
    proceso.tec3.clear();
    proceso.tec4.clear();
    proceso.tec5.clear();
    proceso.tec6.clear();
    proceso.tec7.clear();
    proceso.tec8.clear(); 
    proceso = new Procesos();
    proceso2 = new Procesos(); 
  }

  Widget _defaultTF(String n,String h,String val, Procesos p){
      
      TextEditingController tec; 

       switch(val){
         case "cota1" : tec = p.tec3; break; 
         case "cota2" : tec = p.tec4; break;
         case "longitud" : tec = p.tec6; break;
         case "profundidad" : tec = p.tec7; break;   
       }

       return Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: TextFormField(
              validator: (v){
                       if(val=="profundidad"){
                          return(util.verificarProf(v))?null:"Minimo 60cm";
                       }else{
                          return(util.isNumeric(v))?null:"El valor no es correcto";
                       } 
                       
               }, 
               onSaved: (value){
                      double q = double.parse(value);
                           switch(val){
                              case "cota1"        : p.cotaR1 = q; break;
                              case "cota2"        : p.cotaR2 = q; break;
                              case "longitud"     : p.longitud = q; break; 
                              case "profundidad"  : p.profundidad = q; break;                                                   
                           }
               },
               controller: tec,  
               keyboardType: TextInputType.number,
               decoration: InputDecoration(   
                   labelText: n,
                   hintText: h, 
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                 ),
               ),
        );
  }

 
}