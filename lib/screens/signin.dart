import 'package:flutter/material.dart';
import 'package:p2p/constants/color_constant.dart';

import 'package:p2p/models/login_model.dart';
import 'package:p2p/navigation/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p2p/screens/home_screen.dart';
import 'package:p2p/screens/home_screen_visitor.dart';
import 'package:p2p/screens/sign_up.dart';
// import 'package:here_sdk/core.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

var loginResult = Login();

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  int _pageState = 0;
  var phoneLoginController = new TextEditingController();
  var passwordLoginController = new TextEditingController();

  var phoneRegController = new TextEditingController();
  var passwordRegController = new TextEditingController();
  final storage = new FlutterSecureStorage();

  var _backgroundColor = Color(0xFF358873);
  var _headingColor = Colors.white;

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  bool _passwordVisible = true;

  void _addNewItem(String keyy, String valuee) async {
    final String key = keyy;
    final String value = valuee;

    await storage.write(key: key, value: value);
    final String data = await storage.read(key: key) ?? "";
    //print(data);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginWidth = windowWidth;
    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;
    _loginYOffset = 0;

    // Future.delayed(Duration(milliseconds: 500), () {
    //   setState(() {
    //     _loginYOffset = 40;
    //     // _height = 200.0;
    //   });
    // });

    return Container(
      width: windowWidth,
      height: windowHeight,
      decoration: BoxDecoration(color: primary),
      child: Column(
        children: [
          Container(
              height: windowHeight - _loginHeight,
              padding: EdgeInsets.only(top: 30),
              // padding: EdgeInsets.all(50),
              child: Center(
                heightFactor: 0.1,
                  child: Image.asset(
                'assets/images/Logo.png',
                height: (windowHeight - _loginHeight) - 100,
                
              ))),
          Container(
            // margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.all(32),
            width: _loginWidth,
            height: _loginHeight,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(_loginOpacity),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Login To Continue",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    InputWithIcon(
                      icon: Icons.phone_rounded,
                      hint: "Username",
                      password: false,
                      controller: phoneLoginController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFBC7C7C7), width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: <Widget>[
                          Container(
                              width: 60,
                              child: Icon(
                                Icons.vpn_key,
                                size: 20,
                                color: Color(0xFFBB9B9B9),
                              )),
                          Expanded(
                            child: TextField(
                              controller: passwordLoginController,
                              obscureText: _passwordVisible,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // contentPadding: EdgeInsets.only(top: 5),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Color(0xFF207567),
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  hintText: "Password"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print("DATA NIH yaaaa");
                        EasyLoading.show(status: 'loading...');
                        //print("Nama =" + emailController.text);
                        Login.connectToApi(phoneLoginController.text,
                                passwordLoginController.text)
                            .then((value) {
                          loginResult = value;
                          setState(() {
                            //print(storage.read(key: "token"));
                            if (loginResult.status == 200) {
                              _addNewItem("token", loginResult.token);
                              _addNewItem(
                                  "password", passwordLoginController.text);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return NavigateScreen(
                                  id: 0,
                                );
                              }));
                            } else {
                              _showDialog(context, loginResult.message);
                            }
                          });
                        });
                        EasyLoading.dismiss();
                      },
                      child: PrimaryButton(
                        btnText: "Login",
                        login: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(bottom: 0),
                      child: Text(
                        "versi 0.1a",
                        style: TextStyle(fontSize: 14)
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "© 2023 Kelompok 3 C1",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  final bool password;
  final TextEditingController controller;
  InputWithIcon(
      {required this.icon,
      required this.hint,
      required this.password,
      required this.controller});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )),
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: widget.password,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  border: InputBorder.none,
                  hintText: widget.hint),
            ),
          )
        ],
      ),
    );
  }
}

void _showDialog(BuildContext context, String pesan) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Perhatian!"),
        content: new Text(pesan),
        actions: <Widget>[
          new TextButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  final bool login;
  PrimaryButton({required this.btnText, required this.login});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF207567), borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(13),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({required this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF207567), width: 2),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xFF207567), fontSize: 16),
        ),
      ),
    );
  }
}
