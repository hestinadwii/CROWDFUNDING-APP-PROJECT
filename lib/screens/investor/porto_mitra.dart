// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart';
import 'package:p2p/constants/color_constant.dart';
import 'package:p2p/screens/investor/Currency.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:p2p/user_provider.dart';
import 'package:p2p/models/api_helper_model.dart';
import 'package:p2p/url.dart';
import 'package:intl/intl.dart';
import 'package:p2p/screens/peminjam/successPage.dart';

import 'package:progress_dialog/progress_dialog.dart';

class PortoMitra extends StatefulWidget {
  final data;
  const PortoMitra({super.key, required this.data});

  @override
  State<PortoMitra> createState() => _PortoMitra(data: data);
}

class _PortoMitra extends State<PortoMitra> {
  Map<String, dynamic> data;

  _PortoMitra({required this.data});

  TextEditingController jumlahDana = TextEditingController();
  double windowHeight = 0;
  double windowWidth = 0;
  double heighHeader = 250;

  int userId = 0;
  int saldo = 0;

  String longText = '''
  Ahmad adalah seorang pengusaha muda yang menjalankan bisnis makanan jalanan yang populer di tengah kota. Ahmad bercita-cita untuk memperluas bisnisnya dengan membuka beberapa gerai baru di berbagai lokasi strategis. Namun, untuk mewujudkan ambisinya, dia menyadari bahwa dia membutuhkan modal tambahan. Dia memutuskan untuk mencari pinjaman untuk membantu mewujudkan rencananya. Dengan pinjaman tersebut, Ahmad dapat membeli perlengkapan baru, menyewa tambahan tenaga kerja, dan memperluas area operasionalnya.''';

  List<String> gambar = [
    "assets/images/user_agreement.jpg",
    "assets/images/informasi_produk.jpg",
    "assets/images/pengajuan_dana.jpg",
  ];

  Future<void> delayedFunctionWithLoading() async {
    final ProgressDialog pr = ProgressDialog(context);
    pr.show(); // Menampilkan indikator loading

    await Future.delayed(Duration(seconds: 2));

    pr.hide(); // Menyembunyikan indikator loading setelah penundaan
    // Kode setelah penundaan
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Success()),
    );
  }

  void addPlegde(int campaignId, int jumlahDana) async {
    DateTime today = DateTime.now();

    final data = {
      "campaign_id": campaignId,
      "jumlah": jumlahDana,
    };

    final getResponse =
        await ApiHelper.post(Url().getVal() + "/pledge/${userId}", data);
  }

  void getSaldo(int userId) async {
    final getResponse =
        await ApiHelper.get(Url().getVal() + "/saldo/${userId}");

    setState(() {
      saldo = getResponse['saldo'];
      print(saldo);
    });
  }

  @override
  void initState() {
    super.initState();

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userId = userProvider.userId;

    getSaldo(userId);
    print(data["judul"]);
    longText = '''${data["deskripsi"]}''';
  }

  void _showPaymentDetails() {
    final currencyFormat = NumberFormat.currency(
      locale: 'in_ID', // Ganti dengan locale yang sesuai
      symbol: 'Rp', // Ganti dengan simbol mata uang yang sesuai
    );

    final formattedAmount = currencyFormat.format(saldo);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400.0,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: primary,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/Logo.png'),
                    height: 100.0,
                    width: 100,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                data["judul"],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Tambahkan kolom input sesuai kebutuhan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Saldo Anda',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      formattedAmount,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: jumlahDana,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: primary, // Warna border
                        width: 2.0, // Lebar border
                      ),
                    ),
                    label: Text('Jumlah Dana'),
                    prefix: Text('Rp '),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyFormat(),
                  ],
                ),
              ),
              Spacer(), // Spacer untuk mengatur posisi tombol submit di bagian bawah
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    addPlegde(data["campaign_id"],
                        int.parse(jumlahDana.text.replaceAll(".", "")));
                    delayedFunctionWithLoading();
                  },
                  child: Text('Bayar',
                      style: TextStyle(fontSize: 16, color: white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary, // Warna background tombol
                    minimumSize: Size(150, 48), // Ukuran lebar tombol
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'in_ID', // Ganti dengan locale yang sesuai
      symbol: 'Rp', // Ganti dengan simbol mata uang yang sesuai
    );

    final formattedAmount = currencyFormat.format(data["target_dana"]);
    final formattedAmount2 = currencyFormat.format(data["dana_terkumpul"]);

    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Column(
            children: [
              AppBar(
                backgroundColor: primary,
                elevation: 0,
                title: const Text(
                  'Detail Mitra',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: mFillColor),
                ),
                centerTitle: true,
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: windowHeight - 100,
            child: Padding(
              padding: EdgeInsets.only(left: 18, right: 18, top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileImg(
                        pathFile: "assets/images/user_agreement.jpg",
                      ),
                      // CircleAvatar(
                      //   radius: 40,
                      //   backgroundColor: primary,
                      //   backgroundImage: AssetImage(
                      //     "assets/images/user_agreement.jpg",
                      //   ),
                      // ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                data["judul"],
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  CarouselSlider(
                    items: gambar
                        .map((item) => Container(
                              child: Center(
                                child: Image.asset(
                                  item,
                                  fit: BoxFit.cover,
                                  width: 1000,
                                ),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          longText,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow
                              .visible, // Menampilkan ... jika teks terlalu panjang
                          maxLines:
                              20, // Batasi jumlah baris teks yang ditampilkan
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Dana yang Dibutuhkan",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            formattedAmount,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Tenor",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "${data["tenor"]} Bulan",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dana Terkumpul",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w100,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: data["dana_terkumpul"] / data["target_dana"],
                            minHeight: 25,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(primary),
                          ),
                          SizedBox(height: 16),
                          Text(
                            formattedAmount2,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(), // Spacer untuk mengatur posisi tombol submit di bagian bawah
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          _showPaymentDetails();
                        },
                        child: Text('Danai Mitra',
                            style: TextStyle(fontSize: 16, color: white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary, // Warna background tombol
                          minimumSize: Size(150, 48), // Ukuran lebar tombol
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProfileImg extends StatelessWidget {
  final String pathFile;

  ProfileImg({required this.pathFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              // border: Border.all(color: primary, width: 4.0),
              image: DecorationImage(
                image: AssetImage(pathFile),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselPage extends StatefulWidget {
  final List<String> imgList;

  CarouselPage({super.key, required this.imgList});

  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList
        .map((item) => Container(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();

    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.map((url) {
            int index = widget.imgList.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
