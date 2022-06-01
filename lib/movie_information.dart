import 'package:flutter/material.dart';
import 'package:neurotech_ceng/google_sign_in.dart';
import 'chart_previous_tests.dart';
import 'chart_anlik_data.dart';

class DropDownDemo extends StatefulWidget {
  @override
  _DropDownDemoState createState() => _DropDownDemoState();
}

String? filminAdi;
String? filminTuru;

class _DropDownDemoState extends State<DropDownDemo> {
  String? _chosenValue;
  bool isChecked = false;
  bool turSecildi = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('NeuroTech'),
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.all(10),
            child: Column(children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "Film Bilgileri",
                style: TextStyle(
                    color: Colors.white60,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 300.0,
                child: TextField(
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
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black38,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8)),
                child: new DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    //elevation: 5,
                    //iconSize: 1

                    style: TextStyle(color: Colors.black),

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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w200),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text("Cihazı Taktım")
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  print("filminAdi " + filminAdi!);
                  print("filminTuru " + filminTuru!);
                  if (isChecked &&
                      filminAdi != null &&
                      filminAdi!.isNotEmpty &&
                      turSecildi)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => anlikChart()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
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
