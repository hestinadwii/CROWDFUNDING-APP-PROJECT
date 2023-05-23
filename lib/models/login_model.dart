import 'dart:convert';

import 'package:p2p/url.dart';
// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class Login {
  String token;
  int status;
  String message;

  Login({this.token = "", this.message = "", this.status = 0});

  factory Login.createLogin(Map<String, dynamic> object){
    return Login(
        token: object['status'] == 200 ? object['token'] : "",
        message: object['message'] != null ? object['message'] : "",
        status: object['status'] != null ? object['status'] : 0);
  }

  static Future<Login> connectToApi(String username, String password) async {
    String apiURL = Url().val + "api/login";

    var apiResult = await http.post(Uri.parse(apiURL),
    body: {"username" : username, "password" : password});
    print("HHHHH" + apiResult.body);
    dynamic jsonOnject;
    jsonOnject = json.decode(apiResult.body);

    return Login.createLogin(jsonOnject);
  }
}
