import 'package:flutter/material.dart';

class Pasos extends StatefulWidget {
  @override
  _PasosState createState() => _PasosState();
}

class _PasosState extends State<Pasos> {

  int current_step = 0; 

  List<Step> pasos = [
      Step(
         title: Text("Calcular diámetro nominal",),
         content: Column(
           children: <Widget>[
             Text("Introducido el caudal de diseño, el tipo de material  y la pendiente se procede a realizar el calculo del diámetro mediante la siguiente ecuación:"),
            Image.asset("assets/formulas/diametro.png", fit: BoxFit.cover,) 
           ],
         ),
         isActive: true),
      Step(
        title: Text("Conversión del diámetro"),
        content: Column(
            children: [
                Text("Definido un caudal en pulgadas, se aproxima a un diámetro comercial de tubería, los diámetros comerciales se encuentran en la siguiente tabla: "),
                SizedBox(height: 10.0,),
                Image.asset("assets/formulas/tabla.gif", fit:BoxFit.cover),
            ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Caudal a tubo lleno"),
        content: Column(
          children: <Widget>[
            Text("Caudal a tubo lleno, se entiende este parámetro como capacidad máxima de la tubería para cada sección con flujo máximo , este parámetro se evalúa con el diámetro interno de la tubería, esta ecuación se calcula con unidades en el sistema internacional."),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/caudal.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Cálculo de Vo"),
        content: Column(
          children: <Widget>[
            Text("Utilizando la ecuación de continuidad v=Q/A donde Q es el caudal obtenido anteriormente Qo y A es el área transversal, es decir el área de una circunferencia, en este caso el área de la tubería seleccionada."),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/v01.jpg",fit: BoxFit.cover,),
            Image.asset("assets/formulas/v02.jpg",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Tabla de relaciones hidráulicas"),
        content: Column(
          children: <Widget>[
              Text("5. Utilizando la siguiente tabla de relaciones se obtienen los valores de: \n"
                  "	°Relación velocidad real – velocidad a tubo lleno \n"
                  "	°Relación entre lamina de agua y diámetro interno de la tubería \n" 
                  "	°Relación de radio hidráulico de la sección de flujo y radio hidráulico a tubo lleno \n" 
                  "	°Relación entre la profundidad hidráulica de la sección de flujo y el diámetro interno de la tubería ( <85%)"),
              SizedBox(height: 10.0,),
              Image.asset("assets/formulas/tabla2.jpg",fit: BoxFit.cover,),     
          ],
        ),
        isActive: true,
      ), 
      Step(
        title: Text("Velocidad real"),
        content: Column(
          children: <Widget>[
            Text("La velocidad real se obtiene del producto de (relación velocidad real – velocidad a tubo lleno ) x (Vo) . la velocidad mínima para garantizar que la tubería sea autolavable es de 0,5 m/s"),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/vr.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
       Step(
        title: Text("Altura velocidad"),
        content: Column(
          children: <Widget>[
            Text("Calculada la velocidad real, se calcula la altura de velocidad que corresponde a la (velocidad real calculada )entre (2 x gravedad )"),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/av.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Radio hidráulico"),
        content: Column(
          children: <Widget>[
            Text("Corresponde al producto de (relación entre lamina de agua y diámetro interno de la tubería ) por ( diámetro de la tubería /4)"),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/r.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Esfuerzo cortante minimo"),
        content: Column(
          children: <Widget>[
            Text("Corresponde al producto de la gravedad x 10^3 x (7)x(S), Donde 7 corresponde al valor obtenido en el paso 7 y S a la pendiente."),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/ec.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Altura lámina de agua"),
        content: Column(
          children: <Widget>[
            Text("Corresponde a ( relación entre lámina de agua y diámetro interno de la tubería ) x (Diámetro interno de la tubería)"),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/al.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Energía específica"),
        content: Column(
          children: <Widget>[
            Text("Corresponde a la suma entre el paso (9) y la altura de velocidad calculada en el paso (6)"),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/ee.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Profundidad hidráulica"),
        content: Column(
          children: <Widget>[
            Text("Corresponde a la relación entre profundidad hidráulica y diámetro interno de la tubería x ( Diámetro interno de la tuberia)"),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/ph.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Número de froud"),
        content: Column(
          children: <Widget>[
            Text(
            "NF <= 0,9: Régimen de flujo subcrítico \n"
            "NF >= 1,1: Régimen de flujo supercrítico \n"
             ),
            SizedBox(height: 10.0,),
            Image.asset("assets/formulas/nf.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),     
  ];



  @override
  Widget build(BuildContext context) {

    double size = MediaQuery.of(context).size.height; 

    return Scaffold(
      appBar: AppBar(
        title: Text("Paso a paso desarrollo de alcantarillado sanitario"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size*0.85,
              child: Stepper(
                steps: pasos,
                currentStep: this.current_step,
                type: StepperType.vertical, 

                onStepTapped: (step){
                  setState(() {
                    current_step = step;
                  });
                },
                onStepCancel: (){
                  setState(() {
                    if(current_step>0){
                      current_step-=1; 
                    }else{
                      current_step = 0; 
                    }
                  });
                },
                onStepContinue: (){
                  setState(() {
                    if(current_step < pasos.length -1){
                      current_step+=1;
                    }else{
                      current_step=0; 
                    }
                  });
                },
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20.0,
        child: Icon(Icons.exit_to_app, color: Colors.white),
        onPressed: (){Navigator.pop(context);},
      ),
    );
  }
}