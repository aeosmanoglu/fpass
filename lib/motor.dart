import 'dart:convert';
import 'package:http/http.dart';

class Motor {
  String server = "http://localhost:8081";

  create(String title, String username, {String password}) async {
    String url = server + "/logins/";
    String body = jsonEncode({"URL": title, "Username": username, "Password": password});
    Response response = await post(url, body: body);
    print("create");
    print(response.statusCode);
  }

  list() async {
    String url = server + "/logins";
    Response response = await get(url);
    print("list");
    print(response.statusCode);
    print(response.body);
  }
}