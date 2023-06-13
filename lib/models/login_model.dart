import 'dart:convert';

import 'package:p2p/url.dart';
// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Login {
  int userId;
  String username;
  String namaLengkap;
  String nik;
  bool isInvestor;
  int status;

  Login(
      {this.userId = 0,
      this.username = "",
      this.namaLengkap = "",
      this.nik = "",
      this.isInvestor = false,
      this.status = 0});

  factory Login.createLogin(Map<String, dynamic> object) {
    return Login(
        userId: object['user_id'] != null ? object['user_id'] : 0,
        username: object['username'] != null ? object['username'] : "",
        namaLengkap:
            object['nama_lengkap'] != null ? object['nama_lengkap'] : "",
        nik: object['nik'] != null ? object['nik'] : "",
        isInvestor: object['isInvestor'] != null ? object['isInvestor'] : false,
        status: object['user_id'] != null ? 200 : 0);
  }

  static Future<Login> connectToApi(String username, String password) async {
    String apiURL = Url().val + "/users/sign_in/";
    print(username);
    print(password);
    print(json.encode({"username": username, "password": password}));
    var apiResult = await http.post(Uri.parse(apiURL),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"username": username, "password": password}),
        encoding: Encoding.getByName("utf-8"));
    print("HHHHH" + apiResult.body);
    dynamic jsonOnject;
    jsonOnject = json.decode(apiResult.body);
    print(jsonOnject['isInvestor']);
    return Login.createLogin(jsonOnject);
  }
}
