import 'dart:convert';
import 'package:fpass/obj.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Motor {

  String server, auth;

  _get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    server = prefs.getString("server") ?? "http://localhost:3625";
    auth = prefs.getString("b64") ?? "Z3Bhc3M6cGFzc3dvcmQ=";
  }

  create(String title, String username, {String password}) async {
    await _get();
    String url = server + "/logins/";
    Map<String, String> headers = {"authorization": "Basic $auth"};
    String body = jsonEncode({"URL": title, "Username": username, "Password": password});
    await post(url, headers: headers, body: body);
  }

  Future<List<Data>> list() async {
    await _get();
    String url = server + "/logins";
    Map<String, String> headers = {"authorization": "Basic $auth"};
    Response response = await get(url, headers: headers);
    LoginObj obj = LoginObj.fromJson(jsonDecode(response.body));
    List<Data> list = [];
    obj.data.forEach((element) {
      list.add(element);
    });
    return list;
  }

  del(int id) async {
    await _get();
    String url = server + "/logins/$id";
    Map<String, String> headers = {"authorization": "Basic $auth"};
    await delete(url, headers: headers);
  }
}