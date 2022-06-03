import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'google_sign_in.dart';

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

final Map<String, Color> ColorList = {
  "CHARCOAL": Color(0xff264653),
  "PERSIAN_GREEN": Color(0xff2A9D8F),
  "ORANGE_YELLOW_CRAYOLA": Color(0xffE9C46A),
  "SANDY_BROWN": Color(0xffF4A261),
  "BURNT_SIENNA": Color(0xffE76F51),
};

enum SingingCharacter { Alici, Satici }

class _ProfileInfo extends State<ProfilInfo> {
  String? _chosenValue;
  bool selected = false;
  bool _isRadioSelected1 = false;
  bool _isRadioSelected2 = false;
  int yas = 0;
  int kilo = 0, boy = 0;
  bool yasHatali = true;
  bool kiloHatali = true;
  bool boyHatali = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202b3c),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          automaticallyImplyLeading: false,
          title: Text("Neurotech"),
          backgroundColor: Color(0xff1E293B),
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
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(14),
              child: Column(children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Profil Bilgileri",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20,
                ),
                /*Container(
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
                ),*/
                SizedBox(
                  height: 15,
                ),
                /*
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
                        yasHatali = !isNumericUsing_tryParse(text);
                        /*for(int i=0;i<text.length;i++){
                          if(text[i]. > '9' || text[i] < '0'){
                            yasHatali = true;
                          }
                        } else{
                          yas = int.parse(text);
                          yasHatali = false;
                        }*/
                        if (!yasHatali) yas = int.parse(text);
                        //UserName = text;
                        //you can access nameController in its scope to get
                        // the value of text entered as shown below
                        //UserName = nameController.text;
                      });
                    },
                  ),
                ),*/
                TextFormField(
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
                    hintText: "Yaş",
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (text) {
                    setState(() {
                      yasHatali = yasHatali && !isNumericUsing_tryParse(text);
                      /*for(int i=0;i<text.length;i++){
                          if(text[i]. > '9' || text[i] < '0'){
                            yasHatali = true;
                          }
                        } else{
                          yas = int.parse(text);
                          yasHatali = false;
                        }*/
                      if (!yasHatali) yas = int.parse(text);
                      //UserName = text;
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //UserName = nameController.text;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
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
                    hintText: "Kilo (kg)",
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (text) {
                    setState(() {
                      kiloHatali = !isNumericUsing_tryParse(text);
                      /*for(int i=0;i<text.length;i++){
                          if(text[i]. > '9' || text[i] < '0'){
                            yasHatali = true;
                          }
                        } else{
                          yas = int.parse(text);
                          yasHatali = false;
                        }*/
                      if (!kiloHatali) kilo = int.parse(text);
                      //UserName = text;
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //UserName = nameController.text;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
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
                    hintText: "Boy (cm)",
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (text) {
                    setState(() {
                      boyHatali = !isNumericUsing_tryParse(text);
                      /*for(int i=0;i<text.length;i++){
                          if(text[i]. > '9' || text[i] < '0'){
                            yasHatali = true;
                          }
                        } else{
                          yas = int.parse(text);
                          yasHatali = false;
                        }*/
                      if (!boyHatali) boy = int.parse(text);
                      //UserName = text;
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //UserName = nameController.text;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cinsiyet ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20, /* fontWeight: FontWeight.w400*/
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                /*
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
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.man,
                              color: Colors.teal, //color: Color(0xff06D6A0),
                              size: 29,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.teal,
                                    disabledColor: Colors.red),
                                child: Radio<bool>(
                                  activeColor: Colors.red,
                                  value: true,
                                  groupValue: _isRadioSelected1,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _isRadioSelected1 = newValue!;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Erkek    ",
                                style:
                                    TextStyle(color: Colors.teal, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.woman,
                              color: Colors.teal,
                              size: 29,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.teal,
                                    disabledColor: Colors.red),
                                child: Radio<bool>(
                                  activeColor: Colors.red,
                                  value: false,
                                  groupValue: _isRadioSelected1,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _isRadioSelected1 = newValue!;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Kadın    ",
                                style:
                                    TextStyle(color: Colors.teal, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Duygusal mısın ? ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.check,
                              color: Colors.teal,
                              size: 29,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.teal,
                                    disabledColor: Colors.red),
                                child: Radio<bool>(
                                  activeColor: Colors.red,
                                  value: true,
                                  groupValue: _isRadioSelected2,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _isRadioSelected2 = newValue!;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Evet    ",
                                style:
                                    TextStyle(color: Colors.teal, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.teal,
                              size: 29,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.teal,
                                    disabledColor: Colors.red),
                                child: Radio<bool>(
                                  activeColor: Colors.red,
                                  value: false,
                                  groupValue: _isRadioSelected2,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _isRadioSelected2 = newValue!;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Hayır    ",
                                style:
                                    TextStyle(color: Colors.teal, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(14)),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _chosenValue,
                      //elevation: 5,
                      //iconSize: 1
                      dropdownColor: Colors.white,
                      style: TextStyle(color: Colors.black),
                      focusColor: Colors.white,
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
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          selected = true;
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
                  onPressed: () {
                    print("yasHatali" + yasHatali.toString());
                    if (!yasHatali && selected) {
                      saveUser(_isRadioSelected1 ? "Erkek" : "Kadın", yas,
                          _isRadioSelected2, _chosenValue!, boy, kilo);
                      Navigator.pop(context); // kayıt olma sayfasını kaldır
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Anasayfa()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 4.0,
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
      ),
    );
  }
}

bool isNumericUsing_tryParse(String string) {
  // Null or empty string is not a number
  if (string == null || string.isEmpty) {
    return false;
  }

  // Try to parse input string to number.
  // Both integer and double work.
  // Use int.tryParse if you want to check integer only.
  // Use double.tryParse if you want to check double only.
  final number = num.tryParse(string);

  if (number == null) {
    return false;
  }

  return true;
}
