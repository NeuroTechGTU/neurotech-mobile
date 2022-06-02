import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neurotech_ceng/main.dart';
import 'package:neurotech_ceng/movie_information.dart';
import 'package:neurotech_ceng/profile_information.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  late GoogleSignIn googleSignIn = GoogleSignIn();
  // google hesabı seçmek için tıklanan buton bu fonksiyonu cagırıyor
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect().whenComplete(() async {
      await FirebaseAuth.instance.signOut();
    });
  }
}

class googleLoginPage2 extends StatefulWidget {
  @override
  State<googleLoginPage2> createState() => _googleLoginPage2State();
}

class _googleLoginPage2State extends State<googleLoginPage2> {
  bool check = false;
  //bool kayitEkraniPushed = false;
  @override
  Widget build(BuildContext context) => Scaffold(
          body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator.adaptive(
              backgroundColor: Color(0xff06D6A0),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
            ));
          } else if (snapshot.hasData) {
            user = FirebaseAuth.instance.currentUser!;
            print("HAS DATAaaa");
            print(user?.email);
            var users = FirebaseFirestore.instance.collection('Users');
            return Scaffold(
              appBar: AppBar(
                  // Here we take the value from the MyHomePage object that was created by
                  // the App.build method, and use it to set our appbar title.
                  title: Text("Neurotech"),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).colorScheme.onPrimary),
                      child: Text("Logout"),
                      //icon: const Icon(Icons.add_alert),
                      //tooltip: 'Show Snackbar',
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logout();
                      },
                    )
                  ]),
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
                    FutureBuilder<DocumentSnapshot>(
                      future: users.doc(user?.email).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          //addMessageToGuestBook("message");
                          // burda kullanıcının verileri alınıp database'e kaydedilmeli
                          // addPostFrameCallback eklemeyince sıkıntı cıkardı:
                          // https://stackoverflow.com/questions/47592301/setstate-or-markneedsbuild-called-during-build
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            //kayitEkraniPushed = true;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilInfo()),
                            );
                            /*
                            Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilInfo()),
                        );
                            * */
                          });
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SaveUser()),
                          );*/

                          return Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            /*if (kayitEkraniPushed) {
                              Navigator.pop(context);
                              kayitEkraniPushed = false;
                            }*/
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Anasayfa()),
                            );
                          });

                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Text(
                              "Full Name: ${data['email']} ${data['name']}");
                        }

                        return Text("loading");
                      },
                    ),

                    //MyCustomForm(),
                  ],
                ),
              ),
            );
            // giris yapılmış
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else {
            return MainPage1();
          } //MainPage1();
        },
      )
          //body: MainPage(),
          );
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              return null;
            },
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              //print("value: " + value!.toString());
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
                //addMessageToGuestBook("selamun aleykum firebase");
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> saveUser(String cinsiyet, int yas, bool duygusalMisin,
    String filmIzlemeAliskanligi) async {
  /*if (_loginState != ApplicationLoginState.loggedIn) {
    throw Exception('Must be logged in');
  }*/

  return FirebaseFirestore.instance
      .collection('Users')
      .doc(user?.email)
      .set(<String, dynamic>{
    'name': FirebaseAuth.instance.currentUser!.displayName,
    'email': FirebaseAuth.instance.currentUser!.email,
    //'timestamp': DateTime.now().millisecondsSinceEpoch,
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'cinsiyet': cinsiyet,
    'yas': yas,
    'duygusalMisin': duygusalMisin,
    'filmIzlemeAliskanligi': filmIzlemeAliskanligi
  });
}

Future<void> saveTestResult(
    /*String cinsiyet, int yas, bool duygusalMisin,*/
    String filmIzlemeAliskanligi,
    String film,
    String sonuc) async {
  /*if (_loginState != ApplicationLoginState.loggedIn) {
    throw Exception('Must be logged in');
  }*/

  return FirebaseFirestore.instance
      .collection('Tests')
      .doc()
      .set(<String, dynamic>{
    'name': FirebaseAuth.instance.currentUser!.displayName,
    'email': FirebaseAuth.instance.currentUser!.email,
    //'timestamp': DateTime.now().millisecondsSinceEpoch,
    'userId': FirebaseAuth.instance.currentUser!.uid,
    /*'cinsiyet': cinsiyet,
    'yas': yas,
    'duygusalMisin': duygusalMisin,*/
    'filmIzlemeAliskanligi': filmIzlemeAliskanligi,
    'testEdilenfilm': film,
    'duygu': sonuc
  });
}

// bu class kullanıcının kayıt olma ekranı
// kaydet tusuna basıldıgında
class SaveUser extends StatelessWidget {
  const SaveUser({super.key});

  @override
  Widget build(BuildContext context) {
    // bu veriler alincak. Save user fonksıyonuna bunlar gonderılcek
    String cinsiyet = "";
    int yas;
    bool duygusalMisin;
    String filmIzlemeAliskanligi = "";
    return Scaffold(
      appBar: AppBar(
          // go back butonu kaldirma
          automaticallyImplyLeading: false,
          title: const Text('Kayıt Ol'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.onPrimary),
              child: Text("Logout"),
              //icon: const Icon(Icons.add_alert),
              //tooltip: 'Show Snackbar',
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
                Navigator.pop(context);
              },
            )
          ]),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            cinsiyet = "Erkek";
            yas = 20;
            duygusalMisin = true;
            filmIzlemeAliskanligi = "Sık";
            saveUser(cinsiyet, yas, duygusalMisin, filmIzlemeAliskanligi);
            // burda ana sayfaya gecebiliriz
            //Navigator.pop(context);
            Navigator.pop(context); // kayıt olma sayfasını kaldır
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Anasayfa()),
            );
            // Navigate back to first route when tapped.
          },
          child: const Text('Kaydet'),
        ),
      ),
    );
  }
}

class TestEkrani extends StatefulWidget {
  @override
  State<TestEkrani> createState() => _TestEkrani();
}

class _TestEkrani extends State<TestEkrani> {
  bool check = false;
  @override
  Widget build(BuildContext context)
      //saveTestResult("Erkek", 15, false, "nadir", "Kara Murat", "Mutluluk");
      =>
      Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            //automaticallyImplyLeading: false,
            title: Text("Neurotech"),
          ),
          body: Center(
            child: Column(
              children: [
                Text("TEST EKRANI"),
                ElevatedButton(
                  onPressed: () {
                    saveTestResult(/*"erkek", 65, false, */ filminTuru!,
                        filminAdi!, "API'DAN GELCEK");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // Navigate back to first route when tapped.
                  },
                  child: const Text('Testi Bitir'),
                )
                /*ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestEkrani()),
                    );
                    /*saveTestResult(
                        "erkek", 65, false, "nadiren", "Kara Murat", "Heyecan");*/
                    // Navigate back to first route when tapped.
                  },
                  child: const Text('Testi Baslat'),
                ),*/
                /*ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestEkrani()),
                    );
                    /*saveTestResult(
                        "erkek", 65, false, "nadiren", "Kara Murat", "Heyecan");*/
                    // Navigate back to first route when tapped.
                  },
                  child: const Text('Testi Baslat'),
                ),*/
              ],
            ),
          ));
}

class Testler extends StatefulWidget {
  @override
  State<Testler> createState() => _Testler();
}

class _Testler extends State<Testler> {
  bool check = false;

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Tests')
      .where('email', isEqualTo: user?.email)
      .snapshots();
  @override
  Widget build(BuildContext context)
      //saveTestResult("Erkek", 15, false, "nadir", "Kara Murat", "Mutluluk");
      =>
      Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            //automaticallyImplyLeading: false,
            title: Text("Neurotech"),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Önceki Testler",
                  style: TextStyle(
                      color: Colors.white60,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
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
                      shrinkWrap: true,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        // listeleme yapmak için burdaki listtile'ı guncellemek yeterli
                        return ListTile(
                          title: Text("Film: " + data['testEdilenfilm']),
                          leading: Text("Duygu:" + data['duygu']),
                          trailing: Text("isim: " + data['name']),
                          subtitle: Text("Yas:" + data['yas'].toString()),
                        );
                      }).toList(),
                    );
                  },
                )
              ],
            ),
          ));
}
