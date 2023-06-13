// @dart=2.12

import 'package:p2p/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p2p/screens/home_screen_visitor.dart';
import 'package:provider/provider.dart';
import 'package:p2p/user_provider.dart';
// import 'package:here_sdk/core.dart';

void main() {
  runApp(MyApp());
}

var loginResult = Login();
// var registerResult = new Register();
// var checkResult = new CheckNomor();
// var otpResult = new Otp();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: MaterialApp(
          builder: EasyLoading.init(),
          theme: ThemeData(fontFamily: "Nunito"),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              child: HomeScreenVisitor(),
            ),
          ),
        ));
  }
}
