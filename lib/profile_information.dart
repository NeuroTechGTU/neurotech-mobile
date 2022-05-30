import 'package:flutter/material.dart';

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class ProfilInfo extends StatefulWidget {
  @override
  _ProfileInfo createState() => _ProfileInfo();
}

class _ProfileInfo extends State<ProfilInfo> {
  String? _chosenValue;

  bool _isRadioSelected1 = false;
  bool _isRadioSelected2 = false;
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
                height: 50,
              ),
              Text(
                "Profil Bilgileri",
                style: TextStyle(
                    color: Colors.white60,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300.0,
                height: 40,
                child: TextField(
                  //controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'İsim',
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
                height: 10,
              ),
              Container(
                width: 300.0,
                height: 40,
                child: TextField(
                  //controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Soyisim',
                  ),
                  onChanged: (text) {
                    setState(() {
                      //UserName = text;
                      //UserName = nameController.text;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300.0,
                height: 40,
                child: TextField(
                  //controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Yaş',
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cinsiyet ",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <LabeledRadio>[
                  LabeledRadio(
                    label: 'Erkek',
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    value: true,
                    groupValue: _isRadioSelected1,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isRadioSelected1 = newValue;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Kadın',
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    value: false,
                    groupValue: _isRadioSelected1,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isRadioSelected1 = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Duygusal Birisi misin ? ",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <LabeledRadio>[
                  LabeledRadio(
                    label: 'Evet',
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    value: true,
                    groupValue: _isRadioSelected2,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isRadioSelected2 = newValue;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Hayır',
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    value: false,
                    groupValue: _isRadioSelected2,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isRadioSelected2 = newValue;
                      });
                    },
                  ),
                ],
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
                      '1 Gün',
                      '7 Gün',
                      '1 Ay',
                      '6 Ay',
                      '1 Yıl',
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
                    'Kaydet',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
