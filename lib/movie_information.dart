import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'bluetooth/ChatPage.dart';
import 'bluetooth/SelectBondedDevicePage.dart';
import 'catalog.dart';
import 'itemWidget.dart';
import 'main.dart';

BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

class DropDownDemo extends StatefulWidget {
  @override
  _DropDownDemoState createState() => _DropDownDemoState();
}

String? filminAdi;
String? filminTuru;
TextEditingController _controller = TextEditingController();
void autoFill(String name) {
  _controller.text = name;
}

class _DropDownDemoState extends State<DropDownDemo> {
  String? _chosenValue;
  bool isChecked = false;
  bool turSecildi = false;
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

  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  //BackgroundCollectingTask? _collectingTask;

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
    //_collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    //_controller.dispose();
    super.dispose();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202b3c),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('NeuroTech'),
        backgroundColor: Color(0xff1E293B),
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.all(10),
            child: Column(children: [
              /*Text(
                "Film Bilgileri",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),*/
              Expanded(
                child: ListView.builder(
                    itemCount: CatalogModel.items.length,
                    itemBuilder: (context, index) {
                      return ItemWidget(item: CatalogModel.items[index]);
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300.0,
                child: /*TextField(
                  //controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Film Adı',
                  ),
                  onChanged: (text) {
                    setState(() {
                      filminAdi = text;

                      //UserName = text;
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //UserName = nameController.text;
                    });
                  },
                ),*/
                    TextFormField(
                  controller: _controller,
                  //controller: widget.nameController,

                  cursorColor: Color(0xffE76F51),
                  /* inputFormatters: [
                  new LengthLimitingTextInputFormatter(24),
                ],*/
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffE76F51), width: 2),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Color(0xffE76F51)),
                    ),
                    fillColor: Colors.white.withOpacity(0.97),
                    filled: true, // dont forget this line
                    hintText: "Film Adı",
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (text) {
                    setState(() {
                      filminAdi = text;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              /* Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.white,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8)),
                child: new DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    //elevation: 5,
                    //iconSize: 1

                    dropdownColor: Colors.white,
                    style: TextStyle(color: Colors.black),
                    focusColor: Colors.white,
                    items: <String>[
                      'Korku',
                      'Şaşkınlık',
                      'Öfke',
                      'Antipati',
                      'İğrenme',
                      'Güven',
                      'Üzüntü',
                      'Mutluluk',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text(
                      "Filmin türü nedir? ",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        turSecildi = true;
                        filminTuru = value;
                        _chosenValue = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.teal,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    "Cihazı Taktım",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
              SwitchListTile(
                title: const Text(
                  'Enable Bluetooth',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                value: _bluetoothState.isEnabled,
                activeColor: Colors.teal,
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
              ElevatedButton(
                onPressed: () async {
                  print("filminAdi " + filminAdi!);
                  print("filminTuru " + filminTuru!);
                  if (isChecked &&
                      filminAdi != null &&
                      filminAdi!.isNotEmpty &&
                      turSecildi) {
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
                    ;
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 15.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Başla',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
