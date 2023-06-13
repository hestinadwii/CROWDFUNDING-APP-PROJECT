// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:p2p/constants/color_constant.dart';
import 'package:p2p/screens/investor/Withdraw.dart';
import 'package:provider/provider.dart';
import 'package:p2p/user_provider.dart';
import 'package:p2p/models/api_helper_model.dart';
import 'package:p2p/url.dart';
import 'package:intl/intl.dart';

// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// import 'package:flutter/rendering.dart';
// // import 'package:p2p/constants/style_constant.dart';
// import 'package:p2p/screens/signin.dart';
// import 'package:p2p/screens/sign_up.dart';
// import 'package:p2p/screens/ketentuan_pengguna.dart';
// import 'package:p2p/screens/informasi_layanan_produk.dart';
// import 'package:p2p/screens/pengajuan_pendanaan/pengajuan_pendanaan.dart';

class HomeInvestorWidget extends StatefulWidget {
  @override
  State<HomeInvestorWidget> createState() => _HomeInvestorWidget();
}

class _HomeInvestorWidget extends State<HomeInvestorWidget> {
  double windowHeight = 0;
  double windowWidth = 0;
  double heighHeader = 200;

  int saldo = 0;
  String namaInvestor = "";

  void getSaldo(int userId) async {
    final getResponse =
        await ApiHelper.get(Url().getVal() + "/saldo/${userId}");

    setState(() {
      saldo = getResponse['saldo'];
      print(saldo);
    });
  }

  int userId = 0;

  @override
  void initState() {
    super.initState();

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userId = userProvider.userId;
    namaInvestor = userProvider.namaLengkap;
    getSaldo(userId);
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    final currencyFormat = NumberFormat.currency(
      locale: 'in_ID', // Ganti dengan locale yang sesuai
      symbol: 'Rp', // Ganti dengan simbol mata uang yang sesuai
    );

    final formattedAmount = currencyFormat.format(saldo);

    // print(userId);
    print(saldo);
    return Container(
      child: Column(
        children: [
          Container(
            height: heighHeader,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: primary,
            ),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Halo, $namaInvestor!',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: mFillColor),
                  ),
                  // centerTitle: true,
                  actions: [
                    Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: InkWell(
                          onTap: () async {},
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            size: 30,
                          ),
                        ))
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: white,
                  ),
                  height: 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20.0),
                        //GestureDetector(
                        // onTap: () async {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => LoginPage()));
                        // },
                        Container(
                          decoration: const BoxDecoration(
                              // borderRadius:
                              //     const BorderRadius.all(Radius.circular(15)),
                              // color: Colors.white,
                              // border: Border.all(color: primary, width: 2)
                              ),
                          height: 70,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Saldo",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w100,
                                  color: black,
                                ),
                              ),
                              Text(
                                formattedAmount.toString(),
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Withdraw()));
                            },
                            child: Container(
                              // decoration: const BoxDecoration(
                              //   borderRadius:
                              //       BorderRadius.all(Radius.circular(15)),
                              //   color: Color.fromARGB(255, 30, 107, 88),
                              // ),
                              height: 100,
                              width: 50,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: white,
                                        border: Border.all(
                                          color: primary,
                                          width: 2,
                                        ),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Transform.scale(
                                            scale: 1.5,
                                            child: Icon(
                                              Icons.arrow_downward,
                                              color: primary,
                                            ),
                                          )),
                                    ),
                                    Text(
                                      "Withdraw",
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500,
                                        color: black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                            // onTap: () async {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => RegistPage()));
                            // },
                            child: Container(
                          // decoration: const BoxDecoration(
                          //   borderRadius:
                          //       BorderRadius.all(Radius.circular(15)),
                          //   color: Color.fromARGB(255, 30, 107, 88),
                          // ),
                          height: 100,
                          width: 70,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color.fromRGBO(177, 65, 65, 1),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Transform.scale(
                                        scale: 1.5,
                                        child: Icon(
                                          Icons.arrow_upward,
                                          color: Color.fromRGBO(177, 65, 65, 1),
                                        ),
                                      )),
                                ),
                                Text(
                                  "Deposit",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ]),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Pendanaan Aktif",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: white,
                    border: Border.all(
                      color: primary,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text("ada info tentang pendanaan"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Rekomendasi Mitra",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: white,
                    border: Border.all(
                      color: primary,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text("rekomendasi mitra buat didanai!"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
