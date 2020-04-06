import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String server, username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("Server:"),
            subtitle: TextField(
              autocorrect: false,
              onChanged: (text) {
                server = text;
              },
            ),
          ),
          ListTile(
            title: Text("User Name:"),
            subtitle: TextField(
              autocorrect: false,
              onChanged: (text) {
                username = text;
              },
            ),
          ),
          ListTile(
            title: Text("Password:"),
            subtitle: TextField(
              autocorrect: false,
              obscureText: true,
              onChanged: (text) {
                password = text;
              },
            ),
          ),
          FlatButton(
              onPressed: () async {
                await _save(server, username, password);
              },
              child: Text("SAVE"))
        ],
      ),
    );
  }

  _save(String server, String username, String password) async {
    String string = "$username:$password";
    List list = utf8.encode(string);
    String b64 = Base64Encoder().convert(list);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("server", server);
    prefs.setString("username", username);
    prefs.setString("password", password);
    prefs.setString("b64", b64);
  }
}
