import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:p2p/constants/color_constant.dart';
// import 'package:p2p/constants/style_constant.dart';
import 'package:p2p/screens/signin.dart';
import 'package:p2p/screens/sign_up.dart';
import 'package:p2p/screens/ketentuan_pengguna.dart';
import 'package:p2p/screens/informasi_layanan_produk.dart';
import 'package:p2p/screens/pengajuan_pendanaan/pengajuan_pendanaan.dart';

class HomeScreenVisitor extends StatefulWidget {
  @override
  State<HomeScreenVisitor> createState() => _HomeScreenVisitor();
}

class _HomeScreenVisitor extends State<HomeScreenVisitor> {
  double windowHeight = 0;
  double windowWidth = 0;
  double heighHeader = 200;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            height: heighHeader,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
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
                  title: const Text(
                    'Halo Pengunjung!',
                    style: TextStyle(fontWeight: FontWeight.w500),
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
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white),
                  height: 75,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                color: Colors.white,
                                border: Border.all(color: primary, width: 2)),
                            height: 40,
                            width: 120,
                            child: Center(
                                child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, color: primary),
                            )),
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegistPage()));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 30, 107, 88),
                              ),
                              height: 40,
                              width: 120,
                              child: const Center(
                                  child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                            ))
                      ]),
                )
              ],
            ),
          ),
          Container(
            // padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: SizedBox(
                height: windowHeight - heighHeader,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 150,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Center(
                          child: Container(
                        padding: EdgeInsets.all(20),
                        child: Image.asset("assets/images/Logo.png"),
                      )),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          padding: const EdgeInsets.all(9),
                          child: const Text(
                            "Ketentuan Pengguna",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )),
                    CardWithImg(
                      pathFile: "assets/images/user_agreement.jpg",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => KetentuanPengguna()));
                      },
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          padding: const EdgeInsets.all(9),
                          child: const Text(
                            "Informasi dan Layanan Produk",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )),
                    CardWithImg(
                      pathFile: "assets/images/informasi_produk.jpg",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InformasiLayananProduk()));
                      },
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          padding: const EdgeInsets.all(9),
                          child: const Text(
                            "Cerita Mitra Kami",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: [
                          ProfileImg(
                              pathFile: "assets/images/Foto_Profil.png",
                              nama: "Pengusaha Bawang"),
                          ProfileImg(
                              pathFile: "assets/images/Foto_Profil2.png",
                              nama: "Pengusaha Sawit"),
                          ProfileImg(
                              pathFile: "assets/images/Foto_Profil3.png",
                              nama: "Pedagang Kelontong"),
                          ProfileImg(
                            pathFile: "assets/images/Foto_Profil4.png",
                            nama: "Pedagang Kali Lima",
                          ),
                          ProfileImg(
                            pathFile: "assets/images/Foto_Profil5.png",
                            nama: "Mahasiswa",
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          padding: const EdgeInsets.all(9),
                          child: const Text(
                            "Pengajuan Dana",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )),
                    CardWithImg(
                      pathFile: "assets/images/pengajuan_dana.jpg",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PengajuanPendanaan()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileImg extends StatelessWidget {
  final String pathFile;
  final String nama;

  ProfileImg({required this.pathFile, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(color: primary, width: 4.0),
              image: DecorationImage(
                  image: AssetImage(pathFile), fit: BoxFit.cover),
              shape: BoxShape.circle,
              color: primary,
            ),
          ),
          SizedBox(height: 5),
          Container(
              width: 80,
              child: Center(
                child: Wrap(
                  children: [
                    Text(
                      nama,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class CardWithImg extends StatelessWidget {
  final String pathFile;
  final VoidCallback onTap;

  CardWithImg({required this.pathFile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 150,
      decoration: BoxDecoration(
          color: primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: Offset(0.0, 0.0), // Menyesuaikan posisi bayangan
              blurRadius: 6.0,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          image: DecorationImage(
            image: AssetImage(pathFile),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(
            //     Colors.black.withOpacity(0.5),
            //     BlendMode.srcOver)
          )),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  margin: const EdgeInsets.only(right: 30, bottom: 20),
                  child: GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
