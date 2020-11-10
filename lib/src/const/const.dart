import 'package:flutter/material.dart';



final List<DataColumn> columnas1 = [
        DataColumn(label: Text("Tramo"), numeric: true),
        DataColumn(label: Text("Q Dis"), numeric: true),
        DataColumn(label: Text("Pendiente(%)"), numeric: true),
        DataColumn(label: Text("Diametro"), numeric: true),
        DataColumn(label: Text("Diametro Int"), numeric: true),
        DataColumn(label: Text("Qo"), numeric: true),
        DataColumn(label: Text("Q/Qo"), numeric: true),
        DataColumn(label: Text("V/Vo"), numeric: true),
        DataColumn(label: Text("d/D"), numeric: true),
        DataColumn(label: Text("R/Ro"), numeric: true),
        DataColumn(label: Text("H/D"), numeric: true),
        DataColumn(label: Text("V0"), numeric: true),
        DataColumn(label: Text("V Real"), numeric: true),
        DataColumn(label: Text("V^2/2g"), numeric: true),
        DataColumn(label: Text("R"), numeric: true),
        DataColumn(label: Text("t"), numeric: true),
        DataColumn(label: Text("d"), numeric: true),
        DataColumn(label: Text("E"), numeric: true),
        DataColumn(label: Text("H"), numeric: true),
        DataColumn(label: Text("NF"), numeric: true),
  ];
final List<DataColumn> columnas2 = [
    DataColumn(label: Text("h.tran"), numeric: true),
    DataColumn(label: Text("Rc / D"), numeric: true),
    DataColumn(label: Text("h.curv"), numeric: true),
    DataColumn(label: Text("h.total"), numeric: true),
    DataColumn(label: Text("Velocidad", style: TextStyle(backgroundColor: Colors.blue),)),
    DataColumn(label: Text("Cortante", style: TextStyle(backgroundColor: Colors.blue))),
     DataColumn(label: Text("Profundidad vs diametro", style: TextStyle(backgroundColor: Colors.blue))),
  ];
final List<DataColumn> columnas3 = [ 

    DataColumn(label: Text("Cota R1"), numeric: true),
    DataColumn(label: Text("Cota C1"), numeric: true),
    DataColumn(label: Text("Cota B1"), numeric: true),
    DataColumn(label: Text("Cota L1"), numeric: true),
    DataColumn(label: Text("Cota R2"), numeric: true),
    DataColumn(label: Text("Cota C2"), numeric: true),
    DataColumn(label: Text("Cota B2"), numeric: true),
    DataColumn(label: Text("Cota L2"), numeric: true),

  ];

final List<String> listaMateriales = [
    "Vidrio",
    "PVC/CPVC",
    "Asbesto Cemento",
    "GRP",
    "Acero",
    "Hierro Forjado",
    "CCP",
    "Hierro Fundido Asfaltado",
    "Hierro Galvanizado",
    "Arcilla Vitrificada",
    "Hierro Fundido",
    "Hierro Dúctil",
    "Madera Cepillada",
    "Concreto",
    "Acero Bridado"
  ];

  final List<String> listaUnidades = ["m³/s", "l/s"];
  final List<String> listaPendientes = ["Por(%)", "Dec(0.0)"];

  final Map<int,double> diametros = {
      2 : 0.05,
      4 : 0.10,
      6 : 0.15,  
      8 : 0.201,
      10 : 0.251,
      12 : 0.299, 
      14 : 0.35,
      16 : 0.40,
      18 : 0.45,
      20 : 0.50,
      22 : 0.55,
      24 : 0.60
    };