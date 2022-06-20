/// Package imports
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

class anlikChart extends StatefulWidget {
  const anlikChart({Key? key}) : super(key: key);
  @override
  _anlikChart createState() => _anlikChart();
}

class _anlikChart extends State<anlikChart> {
  List<ChartData>? chartData;

  @override
  void initState() {
    chartData = <ChartData>[
      ChartData(2005, 21, 1, 10, 45, 50, 55, 60, 65),
      ChartData(2006, 24, 2, 15, 70, 75, 80, 85, 90),
      ChartData(2007, 36, 3, 20, 95, 105, 110, 115, 150),
      ChartData(2008, 38, 4, 25, 120, 125, 130, 135, 155),
      ChartData(2009, 54, 5, 30, 140, 145, 150, 155, 160),
      ChartData(2010, 57, 6, 35, 165, 170, 175, 180, 185),
      ChartData(
        2011,
        70,
        7,
        40,
        190,
        195,
        200,
        205,
        210,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
      /*<ChartSeries>[
                      // Renders line chart
                      LineSeries<ChartData, int>(
                          dataSource: chartData!,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y
                      )
                    ]*/
    ))));
  }

  //Todo degissss 8 duygu var burada
  List<LineSeries<ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<ChartData, num>>[
      LineSeries<ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          width: 2,
          name: 'Korku',
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'Şaşkınlık',
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'Öfke',
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y3,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'Antipati',
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y4,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'İğrenme',
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y5,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'Güven',
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y6,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'Üzüntü',
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y7,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'Mutluluk',
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y8,
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y2, this.y3, this.y4, this.y5, this.y6,
      this.y7, this.y8);
  final int x;
  final double y;
  final double y2;
  final double y3;
  final double y4;
  final double y5;
  final double y6;
  final double y7;
  final double y8;
}
