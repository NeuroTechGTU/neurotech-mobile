import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
            //.where('email', isEqualTo: user!.email);
            //.snapshots()
            //.first;
            //.forEach((element) {print(element.docs.first.data().)});

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SaveUser()),
                          );
                          return Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Text(
                              "Full Name: ${data['email']} ${data['name']}");
                        }

                        return Text("loading");
                      },
                    ),
                    /*
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future:
                          snapshotsUser, // a previously-obtained Future<String> or null
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        List<Widget> children;
                        String name = "-", email = "-";
                        if (snapshot.hasData) {
                          bool found = snapshot.data?.size != 0;
                          if (found) {
                            print("id: ${snapshot.data?.docs?.first?.id}");
                            snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              name = data['name'];
                              email = data['email'];
                            });
                          }

                          children = (found)
                              ? <Widget>[
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('$name $email'
                                        //'Bu hesap daha once kaydoldu ${snapshot.data?.docs.reference.get().then((value) => value.data().toString())}'),
                                        //'Result: ${snapshot.data?.docs?.first.data().length}'),
                                        ),
                                  )
                                  /*ListView(
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    return ListTile(
                                      title: Text(data['email']),
                                      subtitle: Text(data['name']),
                                    );
                                  }).toList())*/
                                ]
                              : <Widget>[
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  Text(
                                      "Bu hesap daha once kaydolmadı,\n burda kayıt olma ekranı bastırılmalı")
                                ];
                        } else if (snapshot.hasError) {
                          children = <Widget>[
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            )
                          ];
                        } else {
                          children = const <Widget>[
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            )
                          ];
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: children,
                          ),
                        );
                      },
                    ),
                    */

                    //MyCustomForm(),
                    /*TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused))
                            return Colors.red;
                          return null; // Defer to the widget's default.
                        }),
                      ),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
                      child: Text('Sign up with Google'),
                    ),*/
                  ],
                ),
              ),
            );
            /*return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                primary: Colors.white,
                onPrimary: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                      width: 14,
                    ),
                    //FaIcon(FontAwesomeIcons.google, color: Colors.red),
                    Text(
                      "Logout",
                      /*style: GoogleFonts.lemon(
                                  color: Colors.red, fontSize: 16),*/
                    ),
                  ],
                ),
              ),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            );*/ /*
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user!.email)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading....');
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else {
                        if (snapshot.data!.exists) {
                          check = false;
                        } else {
                          check = true;
                        }
                      }
                      if (check) {
                        return MainPage2();
                      } else {
                        check21 = true;
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        checksaticioralici = data['saticiMi'];

                        return MyApp1();
                      }
                  }
                }
                );*/ // giris yapılmış
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
    String filmIzlemeAliskanligi) {
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
        title: const Text('Kayıt Ol'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            cinsiyet = "Erkek";
            yas = 20;
            duygusalMisin = true;
            filmIzlemeAliskanligi = "Sık";
            saveUser(cinsiyet, yas, duygusalMisin, filmIzlemeAliskanligi);
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
