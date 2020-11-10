import 'dart:ui';
import 'package:flutter/material.dart'; 

class Normatividad extends StatelessWidget {
  

 static final  TextStyle estiloTitulo = TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300); 
 static final  TextStyle estiloParrafo = TextStyle(color: Colors.black87,fontWeight: FontWeight.w200, fontStyle: FontStyle.normal,);
 static final  TextStyle estiloSubtitulo = TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic,  color: Colors.black);

 final String parrafo1 = " Caudal de diseño: el caudal de diseño debe obtenerse de la suma de los aportes de caudal máximo horario, aportes por infiltraciones y conexiones erradas. cuando el caudal de diseño calculado en el tramo sea inferior a 1,5lt/s debe adoptarse este ultimo valor como caudal de diseño para el tramo. \n\n";
 final String p2 = " Caudal de diseño para cada tramo de la red (m3 /s). Es la suma del  Caudal máximdo horario final (m3 /s),  Caudal por infiltraciones (m3 /s), Caudal por conexiones erradas . Cuando el caudal de diseño calculado en el tramo sea menor que 1,5 L/s, debe adoptarse este último valor como caudal de diseño para dimensionar las tuberías de sistemas de alcantarillado de aguas residuales. Para obtener mas información sobre el calculo del caudal máximo horario final leer en, http://www.minvivienda.gov.co/Documents/ViceministerioAgua/TITULO_D.pdf pag 55-58 \n";
 
 final String p3 ="Para las redes de recolección y evacuación de las aguas residuales"+
                   "la sección más utilizada para las tuberías y tramos, es la sección circular"+
                  "especialmente en los tramos iniciales. El diámetro interno mínimo permitido en"+
                  "redes de sistemas de recolección y evacuación de aguas residuales tipo alcantarillado"+
                  "de aguas residuales convencional es de 170 mm, con el fin de evitar las posibles"+
                  "obstrucciones que ocurran en los tramos, causadas por objetos relativamente grandes que"+
                  "puedan entrar al sistema. Para el caso de alcantarillados en municipios con sistemas con"+
                  "niveles de complejidad medio y bajo, el diámetro interno mínimo es de 145 mm. Sin embargo,"+
                  "cuando se requiera evacuar las aguas residuales de un conjunto de más de 10 viviendas se"+
                  "recomienda que el diámetro interno mínimo sea de 170 mm para dichos niveles. Se tomara de 6"+
                  "pulgadas siempre y cuando la población proyectada sea menor a 2500 habitantes \n";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            
      body:
        CustomScrollView(
           slivers: <Widget>[ 
             SliverAppBar(
                    forceElevated: true,
                    backgroundColor: Colors.white,
                    pinned: false,
                    centerTitle: false,
                    snap: true,
                    floating: true,
                    expandedHeight: 250.0,
                    elevation: 25.0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        titlePadding: EdgeInsets.symmetric(vertical: 2.0),
                        title: Text("Normatividad",
                                style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'CrimsonText',
                                        fontWeight: FontWeight.w500, 
                                        color: Colors.black45,
                                        
                                      ),
                                  ),
                        background: FadeInImage(
                          placeholder: AssetImage("assets/portada.jpg"),
                          image: AssetImage("assets/portada.jpg"),fit: BoxFit.fill,
                        ),
                      
                      ),
                ),
             SliverList(
                  delegate: SliverChildListDelegate(
                    [
                            Container( 
                              padding: EdgeInsets.symmetric(horizontal: 25.0,vertical:20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                       Text(
                                         "Normatividad segun la resolución 0330 de 2017",
                                         textAlign: TextAlign.left,
                                         style: estiloTitulo,
                                       ),
                                      Divider(),
                                      parrafo0(),
                                      tabla(),
                                      Divider(), 
                                    Text(
                                         "Según la RAS 2000",
                                         textAlign: TextAlign.left,
                                         style: estiloTitulo,
                                       ),
                                     Divider(),   
                                     parrafo2(),
                                     SizedBox(height: 10.0,),
                                     parrafo3(),
                                     Divider(),              
                            ],
                         ),
                      ),
                    ]
                  ),
           ), 
         ],
       ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: (){Navigator.of(context).pop();}, child: Icon(Icons.arrow_back_ios)),
  ),
    ); 
  } 

  Widget parrafo0(){

        return RichText( 
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: "Artículo 134:",
                style: estiloSubtitulo,
                children: <TextSpan>[
                  TextSpan(
                    text: parrafo1,
                    style: estiloParrafo,
                  ),
                  TextSpan(
                    text: "Diametro interno: ",
                    style: estiloSubtitulo,
                  ),
                  TextSpan(
                    text: "Articulo 140. El diámetro interno real minimo permitido en redes de alcantarillado sanitario es de 170 mm. Para poblaciones menores de 2500 habitantes el diámetro interno real permitido es de 140 mm \n",
                    style: estiloParrafo,
                  ),
                ]
              ), 

        );
  }
  
   Widget parrafo2(){

        return RichText( 
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: "3.3.6 Caudal de diseño:",
                style: estiloSubtitulo,
                children: <TextSpan>[
                  TextSpan(
                    text: p2,
                    style: estiloParrafo, 
                  ),
                ]
              ), 

        );
  } 

  Widget parrafo3(){

        return RichText( 
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: "Diámetro mínimo: ",
                style: estiloSubtitulo,
                children: <TextSpan>[
                  TextSpan(
                    text: p3,
                    style: estiloParrafo,
                    
                  ),
                ]
              ), 

        );
  }

  Widget tabla(){
      return Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          children: <TableRow>[
              TableRow(
                children: <Widget>[
                   Text("Diámetro en mm",),
                   Text("Diámetro en pulgadas \" "),
                   Text("Diámetro en pulgadas comerciales"),  
                ],
              ),
              TableRow(
                children: <Widget>[
                   Text("170"),
                   Text("6.692913386"),
                   Text("8"),  
                ],
              ),
              TableRow(
                children: <Widget>[
                   Text("140"),
                   Text("5.511811024"),
                   Text("6"),  
                ],
              ),
          ],
      );
  }
}
