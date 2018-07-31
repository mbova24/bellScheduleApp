import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fetch Data Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Fetch Data Example'),
        ),
        body: new Container(
          child: new FutureBuilder<List<User>>(
            future: fetchUsersFromGitHub(),
            builder: (context, snapshot) {
              
              if (snapshot.hasData) {
                return new ListView.builder(
            itemCount: snapshot.data.length,
         itemBuilder: (context, index) {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(snapshot.data[index].name,
            style: new TextStyle(fontWeight: FontWeight.bold)),
          new Divider()
        ]
      );
    }
  );
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future<List<User>> fetchUsersFromGitHub() async {
    //var url = 'http://antoniowp.idxsandbox.com/tools/wrapper_tester/index.php';
    var url = 'https://7zsng2eih9.execute-api.us-west-2.amazonaws.com/v1/today';
    final response = await http.get(url);
    print(response.body);
    List responseJson = json.decode(response.body.toString());
    List<User> userList = createUserList(responseJson);
    return userList;
  }

  List<User> createUserList(List data){
      List<User> list = new List();
  for (int i = 0; i < data.length; i++) {
    String title = data[i]["Day"];
    String id = data[i]["Schedule"];
    User user = new User(
        name: title,id: id);
    list.add(user);
  }
  return list;
  }

}

class User {
  String name;
  String id;
  User({this.name,this.id});
}

