import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neurotech_ceng/models/post.dart';
import 'package:neurotech_ceng/services/remote_services.dart';

class APISayfasi extends StatefulWidget {
  @override
  _APISayfasi createState() => _APISayfasi();
}

bool isStopped = false; //globallllllllllll

class _APISayfasi extends State<APISayfasi> {
  List<Post>? posts;
  var isLoaded = false;

  int index = 0;

  @override
  void initState() {
    super.initState();
    getData();
    postData(index);
  }

  Future<Null> delay(int ms) {
    return new Future.delayed(new Duration(milliseconds: ms));
  }

  List<String> nums = ["5", "4", "3", "2", "1"];

  /* getdata */
  getData() async {
    Timer.periodic(Duration(seconds: 10), (timer) async {
      if (isStopped) {
        timer.cancel();
      }
      posts = await RemoteService().getPosts();
      if (posts != null) {
        setState(() {
          isLoaded = true;
        });
      }
      print("printer");

      /*await delay(500);
      print('Delayed 500 milliseconds');*/
      print("every ten seconds you should see me");
    });
  }

  /* postdata */
  postData(int index) async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (isStopped) {
        timer.cancel();
      }
      try {
        double signalVal = 5;
        var response = await http.post(
            Uri.parse('https://jsonplaceholder.typicode.com/posts'),
            body: {
              "id": 1.toString(),
              "name": "Sefa Cicek",
              "num": nums[index],
              "Signal": signalVal.toString(),
              "index": index.toString(),
            });
        print(response.body);
        if (index == 4) {
          index = 0;
        } else {
          index++;
        }
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('API SAYFASI'),
      ),
      body: Center(
        child: Visibility(
          visible: isLoaded,
          child: ListView.builder(
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              posts![index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              posts![index].body ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => APISayfasi()),
                          );*/
                          //postData();
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
                            'Kaydet',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

/*
  ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => APISayfasi()),
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
                    'Kaydet',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),*/
