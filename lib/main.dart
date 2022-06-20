import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'bluetooth/BackgroundCollectingTask.dart';
import 'bluetooth/ChatPage.dart';
import 'bluetooth/SelectBondedDevicePage.dart';
import 'chart_previous_tests.dart';
import 'google_sign_in.dart';
import 'movie_information.dart';

BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
User? user = null;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask? _collectingTask;

  bool _autoAcceptPairingRequests = false;
  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });
    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });
    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });
    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  //const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /*final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.logout();*/

    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          title: 'Welcome to Flutter',
          debugShowCheckedModeBanner: false,
          home: googleLoginPage2()
          /*FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Bir hata olustu'));
              } else if (snapshot.hasData) {
                return MyHomePage(title: 'Neurotech');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )*/
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Center(child: Text('Login')),
            const Text('Hello World'),
            Row(
              children: [
                const SizedBox(
                  width: 150,
                  height: 30,
                ),
                Center(
                  child: FlatButton(
                    color: Colors.blue,
                    child: Row(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.google, color: Colors.red),
                        Text("Login")
                      ],
                    ),
                    //const Text("Login"),
                    //icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused)) return Colors.red;
                  return null; // Defer to the widget's default.
                }),
              ),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              child: Text('Sign up with Google'),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), */ // This trailing comma makes auto-formatting nicer for build methods.
      //ElevatedButton.icon(style: ElevatedButton.styleFrom(primary: Color.white,onPrimary: ) onPressed: (){}, icon: FaIcon(FontAwesomeIcons.google), label: Text('Sign up with Google'),
    );
  }
}

class MainPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        //statusBarColor: Color(0xff07cc99), //Color(0xff00ADB5),
        //statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.cyan,
        systemNavigationBarContrastEnforced: true,
        //systemNavigationBarIconBrightness: Brightness.dark,
        //systemNavigationBarIconBrightness: Brightness.light,
      ),
    );*/
    return MaterialApp(
      home: Container(
        /*
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 0.8],
                colors: [Color(0xff06D6A0), Colors.cyan])),*/
        child: Scaffold(
          backgroundColor: Color(0xFF202b3c), //Colors.transparent,
          /*
          appBar: AppBar(
            elevation: 0,
            backgroundColor:
                Colors.cyan, //Color(0xff07cc99), // Color(0xff06D6A0),
            centerTitle: true,
            title: Text(
              "Natore\'ye Hos Geldiniz",
              style: GoogleFonts.lemon(color: Colors.white, fontSize: 18),
            ),
          ),
           */
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                      //backgroundColor: Color(0xff06D6A0),
                    ),
                    onPressed: () {},
                    child: const Text('NeuroTech',
                        style: TextStyle(color: Color(0xffe76f51), fontSize: 16)
                        // GoogleFonts.lemon(color: Color(0xffe76f51), fontSize: 16),
                        //GoogleFonts.lemon(color: Colors.white, fontSize: 15),
                        //TextStyle(height: 5, fontSize: 20),
                        )),
                /*Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "Bir zamanlar saglıksız beslenenlere",
                      /*style:
                          GoogleFonts.lemon(color: Colors.white, fontSize: 15),
                    */
                    ),
                  ],
                ),*/
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        primary: Colors.white,
                        onPrimary: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 8),
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.google, color: Colors.red),
                            Text(
                              "  Login with Google",
                              /*style: GoogleFonts.lemon(
                                  color: Colors.red, fontSize: 16),*/
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                        // eleman kayıtlıysa profil bilgisi alınmıcak
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilInfo()),
                        );*/
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 8),
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.google, color: Colors.blue),
                            Text(
                              "Kullanmaya Başla!",
                              /*style: GoogleFonts.lemon(
                                  color: Colors.red, fontSize: 16),*/
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        /*final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();*/
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Anasayfa()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BluetoothPage extends StatefulWidget {
  @override
  State<BluetoothPage> createState() => _BluetoothPage();
}

class _BluetoothPage extends State<BluetoothPage> {
  bool check = false;

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Tests')
      .where('email', isEqualTo: user?.email)
      .snapshots();
  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context)
      //saveTestResult("Erkek", 15, false, "nadir", "Kara Murat", "Mutluluk");
      =>
      Scaffold(
          appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              automaticallyImplyLeading: false,
              title: Text("Neurotech"),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.onPrimary),
                  child: Text("Logout"),
                  //icon: const Icon(Icons.add_alert),
                  //tooltip: 'Show Snackbar',
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                    Navigator.pop(context);
                  },
                )
              ]),
          body: Center(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Enable Bluetooth'),
                  value: _bluetoothState.isEnabled,
                  onChanged: (bool value) {
                    // Do the request and update with the true value then
                    future() async {
                      // async lambda seems to not working
                      if (value)
                        await FlutterBluetoothSerial.instance.requestEnable();
                      else
                        await FlutterBluetoothSerial.instance.requestDisable();
                    }

                    future().then((_) {
                      setState(() {});
                    });
                  },
                ),
                ListTile(
                  title: ElevatedButton(
                    child: const Text('Connect to paired device to chat'),
                    onPressed: () async {
                      final BluetoothDevice? selectedDevice =
                          await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SelectBondedDevicePage(
                                checkAvailability: false);
                          },
                        ),
                      );

                      if (selectedDevice != null) {
                        print('Connect -> selected ' + selectedDevice.address);
                        _startChat(context, selectedDevice);
                      } else {
                        print('Connect -> no device selected');
                      }
                    },
                  ),
                ),
                /*ElevatedButton(
                  onPressed: () {
                    saveTestResult(
                        "erkek", 65, false, "nadiren", "Kara Murat", "Heyecan");
                    // Navigate back to first route when tapped.
                  },
                  child: const Text('Testi Bitir'),
                ),*/
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DropDownDemo()),
                    );
                    /*saveTestResult(
                        "erkek", 65, false, "nadiren", "Kara Murat", "Heyecan");*/
                    // Navigate back to first route when tapped.
                  },
                  child: const Text('Testi Baslat'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => chart()),
                    );
                    /*saveTestResult(
                        "erkek", 65, false, "nadiren", "Kara Murat", "Heyecan");*/
                    // Navigate back to first route when tapped.
                  },
                  child: const Text('Önceki Testlerin'),
                ),
              ],
            ),
          ));
}

class PieChart extends StatefulWidget {
  @override
  State<PieChart> createState() => _PieChart();
}

class _PieChart extends State<PieChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.86),
        appBar: AppBar(
          title: const Text('Test Sonucu'),
          backgroundColor: Color(0xff1E293B),
        ),
        body: Center(
            child: Container(
                child: SfCircularChart(
                    // Enables the legend
                    legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries<SalesData, String>>[
              // Initialize line series
              PieSeries<SalesData, String>(
                  dataSource: [
                    // Bind data source
                    SalesData('Mutluluk', 35),
                    SalesData('Üzüntü', 28),
                    SalesData('Öfke', 40),
                    SalesData('Antipati', 32),
                    SalesData('İğrenme', 34),
                    SalesData('Korku', 50)
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  name: 'Duygu',
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]))));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
