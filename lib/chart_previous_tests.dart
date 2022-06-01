/// Package imports
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';


class chart extends StatefulWidget {
  const chart({Key? key}) : super(key: key);
  @override
  _chart createState() => _chart();
}

class _chart extends State<chart>  {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState(){
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('NeuroTech'),
          ),
          body: SfCartesianChart(
            title: ChartTitle(text: 'Daha Önce İzlenen Dizilerin Duygu Oranı'),
            legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
            BarSeries<GDPData,String>(
                name:'Duygu Yoğunluğu',
                dataSource: _chartData,
                xValueMapper: (GDPData gdp,_)=>gdp.continent,
                yValueMapper: (GDPData gdp,_)=>gdp.gdp,
                dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true)
          ],
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift,
          //numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
          //title: AxisTitle(text: 'GDP in billions U.S.')
          ),
          ),
        ));
  }
  List<GDPData> getChartData(){
    final List<GDPData> chartData = [
      GDPData("Korku", 1600),
      GDPData("Şaşkınlık", 2490),
      GDPData("Öfke", 2900),
      GDPData("Antipati", 7500),
      GDPData("İğrenme", 9565),
      GDPData("Güven", 5000),
      GDPData("Üzüntü", 7800),
      GDPData("Mutluluk", 1400),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final double gdp;
}