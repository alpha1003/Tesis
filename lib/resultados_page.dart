import 'package:flutter/material.dart';

class Resultados extends StatelessWidget { 

  @override
  Widget build(BuildContext context) { 

    List<String> valores  = ModalRoute.of(context).settings.arguments; 

    print(valores); 

      final tapPages = <Widget>[
        lista(valores, context),
        Center(child: Text("Página de sugerencias"),),
        
    ]; 

    final ktaps = <Tab>[
      Tab(icon: Icon(Icons.format_list_numbered),text: "Resultados", ),
      Tab(icon: Icon(Icons.help),text: "Sugerencias", ),
      
    ];
    

    return DefaultTabController(
      length: ktaps.length,
       child: Scaffold(
         appBar: AppBar(
           elevation: 4.0,
           
           title: Text("Resultados y Sugerencias"),
           backgroundColor: Colors.blueAccent,
           bottom: TabBar(
             tabs: ktaps,
           ),
         ),
         body: TabBarView(
           children: tapPages,
         ),
         floatingActionButton: FloatingActionButton(
           child: Icon(Icons.arrow_back),
           onPressed: (){
             Navigator.of(context).pop(); 
           },
         ),
       ),
       );
  
  }

  static Widget lista(List<String> valores, BuildContext context){
    
    return ListView(
      children: <Widget>[
        ListTile(
          //leading: Image.asset("assets/diametro2.png"),
          title: Text("Diámetro nominal"),
          subtitle: Text(valores[0]+" m"), 
          onTap: (){
              mostrarAlert(context, "Diámetro nominal", 
              "Diámetro nominal o diámetro teórico de la tubería "
              ); 
          }, 
        ),
        ListTile(
          //leading: Image.asset("assets/caudal2.png"),
          title: Text("Caudal a tubo lleno"),
          subtitle: Text(valores[1] + " m³/s"),
          onTap: (){
            mostrarAlert(context, "Caudal a tubo lleno", 
            "Caudal a tubo lleno, se entiende este parámetro como capacidad máxima de la tubería para cada sección con flujo máximo , este parámetro se evalúa con el diámetro interno de la tubería.");
          },
        ),
        ListTile(
          //leading: Image.asset("assets/velagua.png"),
          title: Text("Velocidad a tubo lleno"),
          subtitle: Text(valores[2]),
        ),
        ListTile(
          //leading: Image.asset("assets/velagua2.png"),
          title: Text("Relacion Q/Q0"),
          subtitle: Text(valores[3]),
        ),
         ListTile(
          //leading: Image.asset("assets/velagua2.png"),
          title: Text("Velocidad Real"),
          subtitle: Text(valores[4]),
        ),
        ListTile(
          //leading: Image.asset("assets/radio.png"),
          title: Text("Radio Hidráulico"),
          subtitle: Text(valores[5]),
        ),
        ListTile(
          //leading: Image.asset("assets/varios.png"),
          title: Text("Esfuerzo cortante mínimo"),
          subtitle: Text(valores[6]),
        ),
        ListTile(
          //leading: Image.asset("assets/varios.png"),
          title: Text("Altura lámina de agua"),
          subtitle: Text(valores[7]),
        ),
        ListTile(
          //leading: Image.asset("assets/varios.png"),
          title: Text("Altura velocidad"),
          subtitle: Text(valores[8]),
        ),
        ListTile(
          //leading: Image.asset("assets/varios.png"),
          title: Text("Energía específica"),
          subtitle: Text(valores[9]),
        ),
        ListTile(
          //leading: Image.asset("assets/varios.png"),
          title: Text("Profundidad hidráulica"),
          subtitle: Text(valores[10]),
        ),
        ListTile(
          //leading: Image.asset("assets/varios.png"),
          title: Text("Número de froud"),
          subtitle: Text(valores[11]),
        ),
      ],
    );
  }
  
  static void mostrarAlert(BuildContext context, String titulo, String texto){

    showDialog(
      context: context,
      barrierDismissible: true, 
      builder: ( context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            title: Text(titulo, style: TextStyle(color: Colors.indigoAccent),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(texto),
              ],
            ),
            actions: <Widget>[
              FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text("Ok"))
            ],
          );
        }
      );
  }
}
