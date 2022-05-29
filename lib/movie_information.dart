import 'package:flutter/material.dart';

class DropDownDemo extends StatefulWidget {
  @override
  _DropDownDemoState createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo> {
  String? _chosenValue ;
  bool isChecked = false;
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
          child: Column(
              children: [
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
                          style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.circular(8)
                  ),
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
                        "Ne sıklıkla dizi veya film izlersin ? ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w200),
                      ),
                      onChanged: (String? value) {
                        setState(() {
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
                    Text(
                      "Cihazı Taktım"
                    )
                  ],
                ),

                 ElevatedButton(
                  onPressed: () {},
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
              ]
          )
        ),
      ),
    );
  }
}