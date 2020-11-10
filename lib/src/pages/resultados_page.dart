import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:proyecto/src/procesos/procesos.dart';
import 'package:proyecto/src/const/const.dart' as cst;


class ResultadosPage extends StatefulWidget {
  @override
  _ResultadosPageState createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> { 
  Procesos p1,p2; 

  final estilo = new TextStyle(
      background: Paint(),
      color: Colors.blue,
  );

  @override
  Widget build(BuildContext context)  {

    List<Procesos> _listaProcesos = ModalRoute.of(context).settings.arguments;
  
    if(_listaProcesos.length>1){
       p1 = _listaProcesos[0];
       p2 = _listaProcesos[1];
    }else{
      p1 = _listaProcesos[0]; 
    }
    return SafeArea(
        
        child: Scaffold(
          appBar: AppBar(
              title: Text("Resultados y Verificaciones"), 
          ),
          body: SingleChildScrollView(
            //scrollDirection: Axis.vertical,
            child: Column(
              children: [
                PaginatedDataTable(
                      header: Text("Resultados"),
                      columns: cst.columnas1,
                      rowsPerPage: 2,
                      source: ProcesoDataSource(_listaProcesos),   
                                
                  ),
                PaginatedDataTable(
                      header: Text("Pérdidas de Energia y verificaciones"),
                      columns: cst.columnas2, 
                      source: PerdidasDataSource(_listaProcesos),
                      rowsPerPage: 2,
                  ),
                  PaginatedDataTable(
                      header: Text("Cotas"),
                      columns: cst.columnas3, 
                      source: CotasDataSource(_listaProcesos),
                      rowsPerPage: 2,
                  ),
                  
                  SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Row(
                         children: [
                            Container(
                               width: 500.0,
                               child: _dibujarGrafica(),
                            )
                         ],
                     ),
                  )
              ],
            ),
        ),

        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "inicio", (route) => false),
        ),
      ),
    );
  } 

Widget _dibujarGrafica(){
  

  return SfCartesianChart(
      
      legend: Legend(isVisible: true),
      key: UniqueKey(),
      //plotAreaBackgroundColor: model.cardThemeColor,
      //backgroundColor: model.cardThemeColor,
      plotAreaBorderWidth: 0,
      plotAreaBorderColor: Colors.grey.withOpacity(0.7),
      //title: ChartTitle(text: 'Average rainfall amount (mm) and rainy days'),
      primaryXAxis: NumericAxis(
          minimum: 0,
          maximum: p1.longitud,
          interval: p1.longitud/10,
          title: AxisTitle(text: "Distancia(m)")
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: "Cota 1(m)"),  
        majorGridLines: MajorGridLines(width: 0),
        minimum: (p1.cotaR1*0.95),
        maximum: (p1.cotaR1),
        interval: 0.2,
        
      ),
      axes: [
          NumericAxis(
             title: AxisTitle(text: "cota 2(m)"),
             name: "Yaxis",
             minimum: (p1.cotaR1*0.95), 
             maximum: (p1.cotaR1),
             interval: 0.2,
             opposedPosition: true,
             majorGridLines: MajorGridLines(width: 0),
             
          )
      ],
     series: _getSeries(),
     tooltipBehavior: TooltipBehavior(
       enable: true, 
       header: "Info"
       ),
    );
}

List<ChartSeries<_SalesData,num>> _getSeries(){

  final data = <_SalesData>[
                    _SalesData(0, p1.cotaR1,p1.cotaR1),
                    _SalesData(p1.longitud, p1.cotaR2,p1.cotaR2),
            ];

  return <ChartSeries<_SalesData, num>>[
              
              LineSeries<_SalesData, num>(
                  color: Colors.black,
                  width: 2.0,
                  dataSource: _calcularRecta(p1.cotaC1),
                  xValueMapper: (_SalesData sales, _) => sales.x,
                  yValueMapper: (_SalesData sales, _) => sales.y1,
                  yAxisName: "Yaxis",
                  name: "COTA CLAVE",

                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: false)
              ),
              LineSeries<_SalesData, num>(
                  color: Colors.red,
                  width: 2.0,
                  dataSource: _calcularRecta(p1.cotaB1),
                  xValueMapper: (_SalesData sales, _) => sales.x,
                  yValueMapper: (_SalesData sales, _) => sales.y1,
                  yAxisName: "Yaxis",
                  name: "COTA BATEA",

                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: false)
              ),
              LineSeries<_SalesData, num>(
                  color: Colors.green,
                  width: 2.0,
                  dataSource: _calcularRecta(p1.cotaL1),
                  xValueMapper: (_SalesData sales, _) => sales.x,
                  yValueMapper: (_SalesData sales, _) => sales.y1,
                  yAxisName: "Yaxis",
                  name: "COTA LAMINA",

                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: false)
              ),
              LineSeries<_SalesData, num>(
                  color: Colors.yellow,
                  width: 2.0,
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.x,
                  yValueMapper: (_SalesData sales, _) => sales.y1,
                  yAxisName: "Yaxis",
                  name: "COTA RASANTE",

                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: false)
              ), 
              ColumnSeries(
                dataSource:<_SalesData>[
                    _SalesData(0, p1.cotaC1, 0),
                    _SalesData(1, p1.cotaC1, 0),
                    _SalesData(2, p1.cotaC1, 0),
                    _SalesData(p1.longitud,p1.cotaC2, 0),
                    _SalesData(p1.longitud-1,p1.cotaC2, 0),
                    _SalesData(p1.longitud-2,p1.cotaC2, 0),
                   
                ],
                xValueMapper: (_SalesData sales, _) => sales.x,
                yValueMapper: (_SalesData sales, _) => sales.y1,
                color: Colors.blue,
                spacing: 2.0,
                isTrackVisible: true,
                trackColor: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
                name: "Pozo"
                
              
            ),
            //LineSeries(
            //    dataSource:<_SalesData>[
            //        _SalesData(0, 0.2, 0),
            //        _SalesData(100, 0.2, 0),
            //    ],
            //    xValueMapper: (_SalesData sales, _) => sales.x,
            //    yValueMapper: (_SalesData sales, _) => sales.y1,
            //),
  ];
}

List<_SalesData> _calcularRecta(double cota1){
       
       List<_SalesData> lista = new List();
       lista.add(_SalesData(0,cota1,0.0)); 

       for(int i=2; i<p1.longitud; i+=2){
            double y = -(p1.getS()*i)+cota1; 
            _SalesData obj = _SalesData(i.toDouble(), y, 0.0);
            lista.add(obj);
        }
        return lista;   
    }
}

class ProcesoDataSource extends DataTableSource {
  int _selectedCount = 0;
  List<Procesos> list; 

  ProcesoDataSource(List<Procesos> lista){this.list = lista;}

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= list.length) return null;
    final Procesos p = list[index];
    return DataRow.byIndex(

        index: index,   
        cells: <DataCell>[
          DataCell(Text('${(index+1)}')),
          DataCell(Text('${p.getQ()}')),
          DataCell(Text('${p.getS()}')),
          DataCell(Text('${p.getDiametro()}')),
          DataCell(Text('${p.getDiametroInt()}')),
          DataCell(Text('${p.getCaudalATuboLleno()}')),
          DataCell(Text('${p.getQQ0()}')),
          DataCell(Text('${p.rel.vv0}')),
          DataCell(Text('${p.rel.dD}')),
          DataCell(Text('${p.rel.rr0}')),
          DataCell(Text('${p.rel.hd}')),
          DataCell(Text('${p.v0}')),
          DataCell(Text('${p.velReal}')),
          DataCell(Text('${p.altVelocidad}')),
          DataCell(Text('${p.radioHidraulico}')),
          DataCell(Text('${p.esfuerzoCortante}')),
          DataCell(Text('${p.alturaLam}')),
          DataCell(Text('${p.energiaEspe}')),
          DataCell(Text('${p.profHidra}')),
          DataCell(Text('${p.numFroud}')),
        ]);
  }

  @override
  int get rowCount => list.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class PerdidasDataSource extends DataTableSource {
  int _selectedCount = 0;
  List<Procesos> list; 
  String v,c,pd; 

  PerdidasDataSource(List<Procesos> lista){this.list = lista;}

  @override
  DataRow getRow(int index) {

    assert(index >= 0);
    if (index >= list.length) return null;
    final Procesos p = list[index];
    verificar(index); 
    return DataRow.byIndex(

        index: index,   
        cells: <DataCell>[
          DataCell(Text('${p.pTransicion}')),
          DataCell(Text('${p.pRcD}')),
          DataCell(Text('${p.pcurva}')),
          DataCell(Text('${p.pcurva+p.pTransicion}')),
          DataCell(Text('$v')),
          DataCell(Text('$c')),
          DataCell(Text('$pd')),
        ]);
  }

  void verificar(int i){

    if(i != 0){
         if(list[i-1].rel.hd > 0.85){
            pd = "Revisar";
         }else{
           pd = "OK"; 
         }
      }else{
        pd=""; 
      }

     (list[i].esfuerzoCortante>1.5) ? c = "OK" : c = "Revisar"; 
     (list[i].v0 < 0.45)? v = "Revisar" : v = "OK"; 
  }

  @override
  int get rowCount => list.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
} 

class CotasDataSource extends DataTableSource {
  int _selectedCount = 0;
  List<Procesos> list; 
  String v,c,pd; 

  CotasDataSource(List<Procesos> lista){this.list = lista;}

  @override
  DataRow getRow(int index) {

    assert(index >= 0);
    if (index >= list.length) return null;
    final Procesos p = list[index];
    return DataRow.byIndex(

        index: index,   
        cells: <DataCell>[
          DataCell(Text('${p.cotaR1}')),
          DataCell(Text('${p.cotaC1}')),
          DataCell(Text('${p.cotaB1}')),
          DataCell(Text('${p.cotaL1}')),
          DataCell(Text('${p.cotaR2}')),
          DataCell(Text('${p.cotaC2}')),
          DataCell(Text('${p.cotaB2}')),
          DataCell(Text('${p.cotaL2}')),
          
        ]);
  }

  @override
  int get rowCount => list.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class _SalesData {
  _SalesData(this.x, this.y1, this.y2);

  final double y1;
  final double x;
  final double y2;
}