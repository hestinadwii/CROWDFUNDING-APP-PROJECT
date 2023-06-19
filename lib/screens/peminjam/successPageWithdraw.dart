// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:p2p/models/api_helper_model.dart';
import 'package:p2p/screens/peminjam/HomeScreen.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);

const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          automaticallyImplyLeading:
              false, // Menghilangkan tombol back di AppBar
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/images/success.gif'),
                  height: 150.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Dana Berhasil Terkirim!',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          //SubTitle(subTitleText: ""),
          ElevatedButton(
            child: Text('Kembali ke Home'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]));
  }
}

// class SubTitle extends StatelessWidget {
//   final String subTitleText;
//   const SubTitle({Key? key, this.subTitleText=""}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//       child: Text(
//         subTitleText,
//         textAlign: TextAlign.center,
//         style: kSubTextStyle,
//       ),
//     );
//   }
// }
