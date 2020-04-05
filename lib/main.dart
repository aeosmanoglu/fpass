import 'package:flutter/material.dart';
import 'package:fpass/motor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("G-PASS"),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showDialog,
      ),
    );
  }

  void _showDialog() {
    Motor().list();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title, username, password;
        return AlertDialog(
          title: Text("Create new password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                onChanged: (text) {
                  title = text;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Username"),
                onChanged: (text) {
                  username = text;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Password", helperText: "Leave blank for a random password"),
                onChanged: (text) {
                  password = text;
                },
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("SAVE"),
              onPressed: () {
                Motor().create(title, username, password: password);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
