// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:p2p/constants/color_constant.dart';
import 'package:p2p/screens/peminjam/Withdraw.dart';
import 'package:p2p/models/api_helper_model.dart';
import 'package:p2p/screens/peminjam/transaksi/riwayat_pinjaman.dart';
import 'package:p2p/screens/peminjam/TopUp.dart';
import 'package:p2p/url.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:p2p/user_provider.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// import 'package:flutter/rendering.dart';
// // import 'package:p2p/constants/style_constant.dart';
// import 'package:p2p/screens/signin.dart';
// import 'package:p2p/screens/sign_up.dart';
// import 'package:p2p/screens/ketentuan_pengguna.dart';
// import 'package:p2p/screens/informasi_layanan_produk.dart';
// import 'package:p2p/screens/pengajuan_pendanaan/pengajuan_pendanaan.dart';

class HomePeminjamWidget extends StatefulWidget {
  @override
  State<HomePeminjamWidget> createState() => _HomePeminjamWidget();
}

class _HomePeminjamWidget extends State<HomePeminjamWidget> {
  double windowHeight = 0;
  double windowWidth = 0;
  double heighHeader = 200;

  int saldo = 0;
  int danaTerkumpul = 0;
  int targetDana = 0;
  int status = 0;

  String namaPeminjam = "";

  void getCampaign(int userId) async {
    final getResponse =
        await ApiHelper.get(Url().getVal() + "/campaign/get/${userId}");

    setState(() {
      danaTerkumpul = getResponse['dana_terkumpul'];
      targetDana = getResponse['target_dana'];
      print(danaTerkumpul);
    });
  }

  void getStatusCampaign(int userId) async {
    final getResponse =
        await ApiHelper.get(Url().getVal() + "/campaign/status/${userId}");

    setState(() {
      status = getResponse['status'];
      print(status);
    });
  }

  void getSaldo(int userId) async {
    final getResponse =
        await ApiHelper.get(Url().getVal() + "/saldo/${userId}");

    setState(() {
      saldo = getResponse['saldo'];
      print(saldo);
    });
  }

  Column statusPengajuan(int state) {
    Column temp;

    final currencyFormat = NumberFormat.currency(
      locale: 'in_ID', // Ganti dengan locale yang sesuai
      symbol: 'Rp', // Ganti dengan simbol mata uang yang sesuai
    );

    final formattedAmount = currencyFormat.format(danaTerkumpul);
    final formattedAmount2 = currencyFormat.format(targetDana);

    if (state == 0) {
      temp = Column(
        children: [Text("Menunggu Verifikasi")],
      );
    } else {
      temp = Column(
        children: [
          Text("Pengajuan Dana Diterima"),
          Text("Target Dana: $formattedAmount2"),
          Text("Dana Terkumpul: $formattedAmount")
        ],
      );
    }

    return temp;
  }

  int userId = 0;

  @override
  void initState() {
    // final getResponse = ApiHelper.get(url);
    super.initState();

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userId = userProvider.userId;
    namaPeminjam = userProvider.namaLengkap;
    getSaldo(userId);
    getCampaign(userId);
    getStatusCampaign(userId);
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
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Halo, $namaPeminjam!',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
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
                    color: Colors.white,
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
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => Withdraw()))
                                  .then((value) {
                                print(value);
                                getSaldo(userId);
                              });

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => Withdraw()));
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
                                        color: Colors.white,
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
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                            onTap: () async {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => Topup()))
                                  .then((value) {
                                print(value);
                                getSaldo(userId);
                              });
                            },
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
                                              color: Color.fromRGBO(
                                                  177, 65, 65, 1),
                                            ),
                                          )),
                                    ),
                                    Text(
                                      "Top Up",
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
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
                      "Status Pengajuan Pinjaman",
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
                    color: Colors.white,
                    border: Border.all(
                      color: primary,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: statusPengajuan(status)),
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
                      "Cicilan Berikutnya",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                //   Container(
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(20)),
                //     color: Colors.white,
                //     border: Border.all(
                //       color: primary,
                //       width: 2.0,
                //     ),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(20.0),
                //     child: Column(
                //       children: [
                //         Text("bayar cicilannya yaa!"),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: RiwayatPinjaman(),
            ),
          ),
        ],
      ),
    );
  }
}
