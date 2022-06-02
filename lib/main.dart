import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neurotech_ceng/APISayfasi.dart';
import 'package:provider/provider.dart';

import 'google_sign_in.dart';

User? user = null;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
                        /* Navigator.push(
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
                              "  API Sayfası",
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
                          MaterialPageRoute(builder: (context) => APISayfasi()),
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
