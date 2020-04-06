import 'package:flutter/material.dart';
import 'package:fpass/motor.dart';
import 'package:fpass/obj.dart';
import 'package:fpass/settings.dart';

import 'motor.dart';
import 'motor.dart';

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
  Future<List<Data>> logins;

  @override
  initState() {
    super.initState();
    logins = Motor().list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("G-PASS"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: logins,
          builder: (context, AsyncSnapshot<List<Data>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 28, 0),
                        child: Icon(
                          Icons.delete_sweep,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      Motor().del(snapshot.data[index].iD);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data[index].uRL),
                        subtitle: Text(snapshot.data[index].username),
                        trailing: Text(snapshot.data[index].password, style: TextStyle(fontFamily: "mono"),),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
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
                autocorrect: false,
                onChanged: (text) {
                  username = text;
                },
              ),
              TextField(
                autocorrect: false,
                obscureText: true,
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
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> refresh() async {
    await new Future.delayed(new Duration(milliseconds: 399));
    setState(() {

    });
    return null;
  }
}
