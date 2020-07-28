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
        content: Text("Definido un caudal en pulgadas, se aproxima a un diámetro comercial de tubería, los diámetros comerciales se encuentran en la siguiente tabla: "),
        isActive: true,
      ),
      Step(
        title: Text("Caudal a tubo lleno"),
        content: Column(
          children: <Widget>[
            Text("Caudal a tubo lleno, se entiende este parámetro como capacidad máxima de la tubería para cada sección con flujo máximo , este parámetro se evalúa con el diámetro interno de la tubería, esta ecuación se calcula con unidades en el sistema internacional."),
            Image.asset("assets/formulas/caudal.png",fit: BoxFit.cover,)
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text("Conversión del diámetro"),
        content: Text("Aquí va la tabla de conversión"),
        isActive: true,
      ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paso a paso desarrollo de alcantarillado sanitario"),
      ),
      body: SingleChildScrollView(
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
      floatingActionButton: FloatingActionButton(
        elevation: 20.0,
        child: Icon(Icons.exit_to_app, color: Colors.white),
        onPressed: (){Navigator.pop(context);},
      ),
    );
  }
}