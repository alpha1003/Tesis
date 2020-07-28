import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Alcantarillado/procesos.dart'; 

class Entradas extends StatefulWidget {
  @override
  _EntradasState createState() => _EntradasState();
}

class _EntradasState extends State<Entradas> { 

  
  String material=""; 
  double caudal=0,pendiente=0,diametro=0; 
  Procesos proceso; 
  

  List<String> _materiales = ["Vidrio", "PVC/CPVC", "Asbesto Cemento", "GRP", "Acero",
                             "Hierro Forjado", "CCP", "Hierro Fundido Asfaltado",
                             "Hierro Galvanizado", "Arcilla Vitrificada", "Hierro Fundido",
                             "Hierro Dúctil","Madera Cepillada","Concreto","Acero Bridado"]; 
  
  List<String> _unidades = ["m³/s", "l/s"]; 

  List<String> _pendientes = ["Por(%)","Dec(0.0)"];

  String _seleccion = "PVC/CPVC"; 
  String _unidad = "m³/s";
  String _valPendiente = "Dec(0.0)"; 
 


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        drawer: Drawer( 
          elevation: 20.0,
           child: Container( 
              decoration: BoxDecoration(color: Colors.blue[100]), 
              child: ListView( 
                
               padding: EdgeInsets.zero,
               children: <Widget>[
                  DrawerHeader(
                    child: Text("App Name", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300, color: Colors.cyan[200]),),
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/portada2.jpg"), fit: BoxFit.cover)), 
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text("Menú",style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300,)),],),
                  Divider(),
                  ListTile(
                    title: Text("Normatividad"),
                    leading: Icon(Icons.assignment, color: Colors.blue,),
                    subtitle: Text("Ver las normas que rigen el alcantarillado sanitario"),
                    onTap: (){Navigator.pop(context); Navigator.pushNamed(context, "normatividad");},
                  ),
                  ListTile(
                    title: Text("Paso a paso"),
                    leading: Icon(Icons.border_color, color: Colors.blue,),
                    subtitle: Text("Proceso detallado de los cálculos de cada variable"),
                    onTap: (){Navigator.pop(context); Navigator.pushNamed(context, "pasos");},
                  ),
                  ListTile(
                    title: Text("Acerca de la app"),
                    leading: Icon(Icons.perm_identity, color: Colors.blue,),
                    subtitle: Text("Desarrolladores, Finalidad, Objetivos"),
                    onTap: (){},
                  ),
               ],
             ),
           ),
        ),  
        body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar( 
                    iconTheme: IconThemeData.fallback(),
                    stretch: true, 
                    forceElevated: true,
                    pinned: false,
                    snap: true,
                    floating: true,
                    expandedHeight: 250.0,
                    elevation: 25.0,
                    actions: <Widget>[
                      FlatButton(onPressed: null, child: Icon(Icons.info)),
                    ],

                    flexibleSpace: FlexibleSpaceBar( 
                      stretchModes: [StretchMode.zoomBackground],
                      centerTitle: true,
                      titlePadding: EdgeInsets.symmetric(vertical: 80.0),
                      //title: Text("App Name",style: TextStyle(fontSize: 16, decorationColor: Colors.blue, decorationStyle: TextDecorationStyle.wavy, color: Colors.yellow, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500,), ),
                      background: FadeInImage(
                        placeholder: AssetImage("assets/portada.jpg"),
                        image: AssetImage("assets/portada.jpg"),fit: BoxFit.fill,
                      ),
                    
                    ),
                ),
                SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 20.0,),
                    cuerpo(),
                  ]
                ),
               ), 
              ],
            ),
      ),
    );
  } 

  Widget cuerpo(){
    return Container( 
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column( 
         children: <Widget>[ 
              
             _introduccion(),
             SizedBox(height: 20.0,),
             Text("Introduzca los valores de caudal, pendiente y seleccione el tipo de material",
             style: TextStyle(fontSize: 20.0),
             ),
             SizedBox(height: 20.0),
             _caudal(),
             SizedBox(height: 20.0,),
             Divider(),
             SizedBox(height: 20.0,),
             _pendiente(),
             SizedBox(height: 20.0,),
             Divider(), 
             SizedBox(height: 20.0,),
             Text("Seleccione el tipo de material"),
             _crearDropdown(),
             SizedBox(height: 20.0,),
             ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                 child: RaisedButton(   
                 elevation: 2.0,   
                 color: Colors.lightBlueAccent,
                 child: Text("Proceder a calcular"),
                 onPressed: botonCalcular,
               ),
             ),
             Divider(),
             
         ],
      ),
    );
  }

  Widget  _caudal() {
    
      return TextField(
              
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: "Valor de caudal",
                //labelText: "Caudal en m³/s",
                suffix: DropdownButton(
                        isDense: true,
                        value: _unidad,
                        items: getOpciones(_unidades),
                        onChanged: (opt){
                            setState(() {
                              _unidad = opt;
                              if(caudal>0 && _unidad=="l/s"){
                                  caudal = caudal/1000; 
                              } 
                            });
                        },
                      ),
                //helperText: "Solo es el nombre",
                
                icon: ImageIcon(AssetImage("assets/agua.png"),color: Colors.blueAccent,),
              ),
              onChanged: (valor){
                setState(() { 
                    if(valor==""){
                      caudal = 0; 
                    }
                    caudal = double.parse(valor); 
                    print(_unidad);
                    if(_unidad == "l/s"){
                       caudal = caudal/1000; 
                    }  
                  });
                
                }
              
            );
       
    } 

  Widget  _pendiente() {
      return TextField(
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: "Valor de la pendiente",
                suffix: DropdownButton(

                        isDense: true,
                        value: _valPendiente,
                        items: getOpciones(_pendientes),
                        onChanged: (opt){
                            setState(() {
                              _valPendiente = opt;
                              if(pendiente>0 && _valPendiente=="Por(%)"){
                                 pendiente=pendiente/100; 
                              }  
                            });
                        },
                      ),
                
                icon: ImageIcon(AssetImage("assets/meter.png"),color: Colors.blueAccent,),
              ),
              onChanged: (valor){
                setState(() { 
                    if(valor==""){
                      pendiente = 0; 
                    }
                   pendiente = double.parse(valor);
                   print("VAL PEN:"+_valPendiente);
                   if(_valPendiente == "Por(%)"){
                       pendiente = pendiente/100; 
                   } 
                }); 
              }
            );
    
    } 

  List<DropdownMenuItem<String>> getOpciones(List<String> list){

                     List<DropdownMenuItem<String>> lista = new List(); 
                    list.forEach((item){
                      lista.add(DropdownMenuItem(
                         child: Text(item),
                         value: item,
                      ));
                        
                    });
                    return lista; 
    }
  
  Widget _crearDropdown(){

                return Row(
                  children: <Widget>[ 
                    Image(image: AssetImage("assets/material.jpg"),width: 25.0,height: 25.0,),
                    SizedBox(width: 25.0,), 
                    DropdownButton(
                        value: _seleccion,
                        items: getOpciones(_materiales),
                        onChanged: (opt){
                            setState(() {
                              _seleccion = opt; 
                            });
                        },
                      ),
                  ],
                );

                
              }

  Widget _introduccion() {
                          
                   return Card(

                   elevation: 8.0,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                   child: Column(
                     children: <Widget>[
                       ListTile(
                         leading: Icon(Icons.live_help, color: Colors.blue,),
                         title: Text("Instrucciones", style: TextStyle(fontSize: 20.0),),
                         subtitle: Text("A continuación se procede a realizar los cálculos para el desarrollo de"
                         "alcantarillado sanitario, recuerde que las unidades que se trabajan son las del sistema internacional.\n"
                         "°El caudar debe estar en metros cubicos por segundo m³/s. Y su valor mínimo es 1.5m³/s\n"
                         "°El valor de pendiente en su valor decimal es decir, si se tiene una pendiente de 2% el valor a introducir es 2/100 = 0,02.\n",
                         textAlign: TextAlign.justify,
                         ),
                         
                       ),

                       FlatButton(
                          onPressed: (){
                               Navigator.pushNamed(context, "normatividad");
                          },
                          child: Text(
                            "Ver toda la normatividad",
                            style: TextStyle(color: Colors.indigoAccent),
                          ),
                        ),
                       
                     ],
                     ),
                     );   
    }

  void mostrarAlert(BuildContext context){

    showDialog(
      context: context,
      barrierDismissible: true, 
      builder: ( context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            title: Text("¡Ha ocurrido un error!", style: TextStyle(color: Colors.red),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Verifique que todos los campos estén completamente diligenciados."),
              ],
            ),
            actions: <Widget>[
              FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text("Ok"))
            ],
          );
        }
      );


  } 

  void mostrarAlert2(BuildContext context, Procesos proceso){

    showDialog(
      context: context,
      barrierDismissible: true, 
      builder: ( context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            title: Text("¡Ha ocurrido un error!", style: TextStyle(color: Colors.red),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Verifique que los parametros ingresados se ajusten: \n"+
                      "Diámetro nominal:  "+proceso.getDiametro().toString()+" pulgadas \n"+
                      "Diámetro interno: "+proceso.getDiametroInt().toString()+"m \n"+
                      "Caudal a tubo lleno: "+proceso.getCaudalATuboLleno().toString()+"m³/s \n"+
                      "Relación q/q0: "+proceso.getQQ0().toString()),
                Text("¿Desea ajustar manualmente el valor del diámetro? \n"+
                     "Presione 'Sí' para ajustar el díametro, 'No', para ajustar los parámetros de diseño."),
              ],
            ),
            actions: <Widget>[
              FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text("No")),
              FlatButton(
                 onPressed: (){
                    Navigator.of(context).pop(); 
                    preguntarDiametro(context); 
                 },
                 child: Text("Sí")
              ),
            ],
          );
        }
      );


  }

  void botonCalcular() async {

            if(caudal == 0||pendiente==0||_seleccion==""){
                  mostrarAlert(context);  
            }else{
 
              proceso = new Procesos(caudal,pendiente,_seleccion);
              await proceso.calcular(); 

              if(proceso.rel==null){
                  mostrarAlert2(context ,proceso); 
              }else{
                  Navigator.pushNamed(context, "resultados", arguments: proceso.lista);
              } 
              
            }
            
        }

  void botonCalcular2() async {

              await proceso.calcular();
              if(proceso.rel==null){
                  mostrarAlert2(context ,proceso); 
              }else{
                  Navigator.pushNamed(context, "resultados", arguments: proceso.lista);
              } 
        }

  void preguntarDiametro(BuildContext context){

     showDialog(
      context: context,
      barrierDismissible: true, 
      builder: ( context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            title: Text("Ingrese el valor del nuevo díametro", style: TextStyle(color: Colors.blue),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                    //autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    hintText: "Valor del diámetro comercial",
                    labelText: "Diámetro en pulgadas", 
                    suffixIcon: IconButton(
                                    icon: Icon(Icons.help),
                                    onPressed: (){
                                        Fluttertoast.showToast(
                                          msg: "Diámetros comerciales: [8\"-10\"-12\"-14\"-16\"-18\"-20\"]",
                                          gravity: ToastGravity.TOP,
                                          backgroundColor: Colors.black,
                                          toastLength: Toast.LENGTH_SHORT,
                                          textColor: Colors.white, 
                                          fontSize: 18.0, 

                      );
                                    }
                                )
              ),
              onChanged: (valor){
                setState(() {
                    if(valor != ""){
                        diametro = double.parse(valor);
                    }
                });
                
                }
              
                ),
              ],
            ),
            actions: <Widget>[
              RaisedButton(onPressed: () { 
                  if(diametro == 0 || diametro > 20 || diametro < 8 || (diametro%2)!=0){
                    
                     Fluttertoast.showToast(
                       msg: "¡El valor ingresado no es válido!",
                       gravity: ToastGravity.BOTTOM,
                       backgroundColor: Colors.indigoAccent,
                       toastLength: Toast.LENGTH_SHORT,
                       textColor: Colors.white, 
                       fontSize: 18.0, 
                      );
                  }else{
                      proceso.setDiametro(diametro);
                      Navigator.of(context).pop(); 
                      botonCalcular2();
                  }
              },
               child: Text("Cambiar"),
               color: Colors.blue,
              ),
            ],
          );
        }
      );
  }

  
}


