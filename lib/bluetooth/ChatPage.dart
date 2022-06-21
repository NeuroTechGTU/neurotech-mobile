import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:http/http.dart' as http;
import 'package:neurotech_ceng/main.dart';

List<int> datasResult = [];
List<int> data1 = [];
List<int> data2 = [];
List<int> data3 = [];
List<int> data4 = [];

int sensor1_max = 0;
int sensor2_max = 0;
int sensor3_max = 0;
int sensor4_max = 0;

int sensor1_min = 0;
int sensor2_min = 0;
int sensor3_min = 0;
int sensor4_min = 0;

int sensor1_sum = 0;
int sensor2_sum = 0;
int sensor3_sum = 0;
int sensor4_sum = 0;

int sensor1_avg = 0;
int sensor2_avg = 0;
int sensor3_avg = 0;
int sensor4_avg = 0;

int flag = 0;
int sex = 0;
int age = 0;
double bmi = 0;
int weight = 0;
int height = 0;

Timer? _timer;
int _start = 10;

bool isStopped = false;
getData() async {
  Timer.periodic(Duration(seconds: 10), (timer) async {
    print("every ten seconds you should see me");
    if (data1.length != 0 &&
        data2.length != 0 &&
        data3.length != 0 &&
        data4.length != 0) {
      sensor1_max = data1.reduce(max);
      sensor2_max = data2.reduce(max);
      sensor3_max = data3.reduce(max);
      sensor4_max = data4.reduce(max);

      sensor1_min = data1.reduce(min);
      sensor2_min = data2.reduce(min);
      sensor3_min = data3.reduce(min);
      sensor4_min = data4.reduce(min);

      sensor1_sum = data1.reduce((value, element) => value + element);
      sensor2_sum = data2.reduce((value, element) => value + element);
      sensor3_sum = data3.reduce((value, element) => value + element);
      sensor4_sum = data4.reduce((value, element) => value + element);

      sensor1_avg = (sensor1_sum / data1.length).toInt();
      sensor2_avg = (sensor2_sum / data2.length).toInt();
      sensor3_avg = (sensor3_sum / data3.length).toInt();
      sensor4_avg = (sensor4_sum / data4.length).toInt();
    }

    data1.clear();
    data2.clear();
    data3.clear();
    data4.clear();

    List<dynamic> data = [
      sex,
      age,
      bmi,
      sensor4_avg,
      sensor4_max,
      sensor4_min,
      sensor3_avg,
      sensor3_max,
      sensor3_min,
      sensor2_avg,
      sensor2_max,
      sensor2_min,
      sensor1_avg,
      sensor1_max,
      sensor1_min
    ];
    final Map<dynamic, dynamic> map = {"data": data, "model_num": 0};

    var response = await http.post(
        Uri.parse(
            'https://neurotech-model.azurewebsites.net/api/HttpTrigger1?code=H_b77QaGW6eeF8UvewZONUSBFuBUfZ1R9yGftNQKHKXEAzFuGLjiqQ=='),
        body: jsonEncode(map));
    print(jsonEncode(map).toString());
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA sena\n");
   // print(jsonDecode(response.body));
    String  pdfText= await json.decode(json.encode(response.body))  ;

    var datelist = pdfText.split("  ");
    var datelist2 = datelist[4].split(" ");
    var datelist3 = datelist[5].split(" ");
    var datelist4 = datelist[0].split("[[");
    var datelist5 = datelist3[1].split("]");
    print(datelist4[1]);
    print(datelist[1]);
    print(datelist[2]);
    print(datelist[3]);
    print(datelist2[0]);
    print(datelist2[1]);
    print(datelist3[0]);
    print(datelist5[0]);
   // print(pdfText.split(" "));

    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print(sensor1_max);
    print(sensor1_min);
    print(sensor1_sum);
    print(sensor1_avg);
    print(sensor4_max);
    print(sensor4_min);
    print(sensor4_sum);
    print(sensor4_avg);
    data1 = [];
    data2 = [];
    data3 = [];
    data4 = [];
  });
}

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({required this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static final clientID = 0;
  BluetoothConnection? connection;

  var a = FirebaseFirestore.instance
      .collection('Users')
      .where('email', isEqualTo: user?.email)
      .get()
      .then((snapshot) => snapshot.docs.forEach((document) {
    age = document.data()['yas'];
    height = document.data()['boy'];
    sex = (document.data()['cinsiyet'][0] == 'E') ? 0 : 1;
    weight = document.data()['kilo'];
    /*print(sex +
                                    age.toString() +
                                    " " +
                                    weight.toString() +
                                    " " +
                                    height.toString());*/
  }));

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
  new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
    print("zubultamo\n");
    getData();
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                    (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    final serverName = widget.server.name ?? "Unknown";
    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Connecting chat to ' + serverName + '...')
              : isConnected
              ? Text('Live chat with ' + serverName)
              : Text('Chat log with ' + serverName))),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: list),
            ),
            /*ElevatedButton(
                onPressed: () {
                  print("test bitir");

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => anlikChart()),
                  );
                  // saveTestResult(chosenValue!, filminAdi!, /*sonuc*/) // TODO: BURAYI ACCCC
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
                    'Testi Bitir',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),*/
            /* ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: N/*list*/),*/

            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 15.0),
                      controller: textEditingController,
                      decoration: InputDecoration.collapsed(
                        hintText: isConnecting
                            ? 'Wait until connected...'
                            : isConnected
                            ? 'Type your message...'
                            : 'Chat got disconnected',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      enabled: isConnected,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: isConnected
                          ? () => _sendMessage(textEditingController.text)
                          : null),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      print("asdasdsadasd");

      setState(() {
        data.forEach((element) {
          if (flag % 4 == 0) {
            data1.add(element);
            print("girdiimmmmm");
          } else if (flag % 4 == 1)
            data2.add(element);
          else if (flag % 4 == 2)
            data3.add(element);
          else if (flag % 4 == 3)
            data4.add(element); //data4.add(int.parse(text));
          flag++;
        });
        print(data1.toString());
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
          0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();
    print("09999999999");
    print("09999999999");
    print("09999999999");
    print("09999999999");
    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;
        /* if (timer < 10) {
          datas.add(text);
        } else {
          List<String> datas = [];
        }*/
        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
