/// Package imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import 'main.dart';

class chart extends StatefulWidget {
  const chart({Key? key}) : super(key: key);
  @override
  _chart createState() => _chart();
}

class _chart extends State<chart> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Tests')
      .where('email', isEqualTo: user?.email)
      .snapshots();
  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202b3c),
      appBar: AppBar(
        backgroundColor: Color(0xFF1e293b), //Color.fromRGBO(100, 10, 23, 1),
        title: const Text('İzleme Geçmişim'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SfCartesianChart(
                backgroundColor: Color(0x0), //Colors.indigo.shade700,
                plotAreaBackgroundColor: Color(0x0),
                //plotAreaBorderColor: Colors.red,
                /*title:
                ChartTitle(text: 'Daha Önce İzlenen Dizilerin Duygu Oranı'),
            */ //legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  BarSeries<GDPData, String>(
                      name: '',
                      dataSource: _chartData,
                      xValueMapper: (GDPData gdp, _) => gdp.continent,
                      yValueMapper: (GDPData gdp, _) => gdp.gdp,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      //trackColor: Colors.blue,
                      color: Colors.teal.shade400)
                ],
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  //numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                  //title: AxisTitle(text: 'GDP in billions U.S.')
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      // listeleme yapmak için burdaki listtile'ı guncellemek yeterli
                      return Column(
                        children: [
                          ListTile(
                            title: new RichText(
                              text: new TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: "Film: ",
                                      style: new TextStyle(
                                        color: Colors.white54,
                                        //fontWeight: FontWeight.bold)
                                      )),
                                  new TextSpan(
                                    text: '${data['testEdilenfilm']}',
                                    style: new TextStyle(
                                      color: Colors.white,

                                      //fontWeight: FontWeight.bold)
                                    ),
                                  )
                                ],
                              ),
                            ),
                            /*title: RichText(
                                text: "Film: "! + data['testEdilenfilm'],
                              ),*/
                            trailing: new RichText(
                              text: new TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: "Duygu: ",
                                      style: new TextStyle(
                                        color: Colors.white54,
                                        //fontWeight: FontWeight.bold)
                                      )),
                                  new TextSpan(
                                    text: '${data['duygu']}',
                                    style: new TextStyle(
                                      color: Colors.white,

                                      //fontWeight: FontWeight.bold)
                                    ),
                                  )
                                ],
                              ),
                            ), //Text("Duygu:" + data['duygu']),
                            /*trailing: Text("Duygu:" +
                                  data[
                                      'duygu'])*/ //Text("isim: " + data['name']),
                            //subtitle: Text("Yas:" + data['yas'].toString()),
                          ),
                          const Divider(
                            height: 14,
                            thickness: 0.5,
                            indent: 20,
                            endIndent: 15,
                            color: Colors.black,
                          ),
                        ],
                      );
                    }).toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<GDPData> getChartData() {
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
