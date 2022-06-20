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
  final Future<QuerySnapshot<Map<String, dynamic>>> testsStream =
      FirebaseFirestore.instance
          .collection('Tests')
          .where('email', isEqualTo: user?.email)
          .get();
  //.;

  @override
  void initState() {
    //getChartDataFuture();
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
              FutureBuilder(
                future: testsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  return SfCartesianChart(
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
                          dataSource:
                              getChartDataSnapshot(snapshot), //_chartData,
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
                  );
                },
                /*child: SfCartesianChart(
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
                )*/
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
                            focusColor: Colors.red,
                            textColor: Colors.blue,
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
}

List<GDPData> getChartData() {
  final List<GDPData> chartData = [
    GDPData("Korku", 1600),
    GDPData("Öfke", 2900),
    GDPData("Antipati", 7500),
    GDPData("İğrenme", 9565),
    GDPData("Üzüntü", 7800),
    GDPData("Mutluluk", 1400),
  ];
  return chartData;
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  double gdp;
}

FutureBuilder<QuerySnapshot<Map<String, dynamic>>> getChartDataFuture() {
  Query<Map<String, dynamic>> tests = FirebaseFirestore.instance
      .collection('Tests')
      .where('email', isEqualTo: user?.email);

  return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
    future: tests.get(),
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      print("AAA");
      if (snapshot.hasError) {
        return Text("Something went wrong");
      }

      if (snapshot.hasData && !snapshot.data!.docs.isNotEmpty) {
        return Text("Document does not exist");
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.docs as Map<String, dynamic>;
        print("${data['name']}");
        return Text("Full Name: ${data['name']} ${data['email']}");
      }

      return Text("loading");
    },
  );
}

List<GDPData> getChartDataSnapshot(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
  List<GDPData> list = [
    GDPData("Korku", 0),
    GDPData("Öfke", 0),
    GDPData("Antipati", 0),
    GDPData("İğrenme", 0),
    GDPData("Üzüntü", 0),
    GDPData("Mutluluk", 0)
  ];
  snapshot.data?.docs.forEach((element) {
    for (int i = 0; i < 6; i++) {
      if (list[i].continent.compareTo(element.data()['duygu']) == 0) {
        list[i].gdp++;
      }
    }
    //print("${element.data()['duygu']}");
  });
  return list;
  //snapshot.data.docs.
}
