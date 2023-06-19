// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:p2p/constants/color_constant.dart'; 
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PembayaranPokok {
  final String title;
  final double amount;
  final DateTime date;

  PembayaranPokok({
    required this.title,
    required this.amount,
    required this.date,
  });
}

class Portofolio extends StatefulWidget {
  @override
  _PortofolioState createState() => _PortofolioState();
}

class _PortofolioState extends State<Portofolio> {
  bool isPaymentPanelVisible = false; // Status keadaan muncul-tidaknya panel
  TextEditingController jumlahDana= TextEditingController();
  final List<PembayaranPokok> transactions = [
    PembayaranPokok(
      title: 'Pendanaan Pedagang Gorengan',
      amount: 250000,
      date: DateTime(2023, 5, 1),
    ),
    // PembayaranPokok(
    //   title: 'Pembayaran Pokok 2',
    //   amount: 150000,
    //   date: DateTime(2023, 5, 3),
    // ),
    // PembayaranPokok(
    //   title: 'Pembayaran Pokok 3',
    //   amount: 250000,
    //   date: DateTime(2023, 5, 1),
    // ),
    // PembayaranPokok(
    //   title: 'Pembayaran Pokok 4',
    //   amount: 150000,
    //   date: DateTime(2023, 5, 3),
    // ),
  ];

  double windowHeight = 0;
  double windowWidth = 0;
  double heighHeader = 150;

  void _showPaymentDetails() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300.0,
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
                'Pembayaran Pokok',
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
                      'Rp1.000.000',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ],
              ),
              Text("Saldo Anda akan terpotong sebesar Rp *** untuk pembayaran cicilan berikutnya", style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w500
              ),),
              Spacer(), // Spacer untuk mengatur posisi tombol submit di bagian bawah
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Success()),
                    // );
                  },
                  child: Text('Bayar', style: TextStyle(fontSize: 16, color: white)), 
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

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            centerTitle: true,
            backgroundColor: primary,
            title: (Text('Portofolio', style: TextStyle(color: white))),
          ),
        ),
        body: Column(
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
                  Container(
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                        ),
                    height: 100,
                    width: 500,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 5.0),
                            Container(
                              decoration: const BoxDecoration(
                                  // borderRadius:
                                  //     const BorderRadius.all(Radius.circular(15)),
                                  // color: Colors.white,
                                  // border: Border.all(color: primary, width: 2)
                                  ),
                              height: 100,
                              width: 300,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Total Aset",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "Rp 5.000.000",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 5.0),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       'Tenor Pinjaman:',
                                  //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                                  //     ),
                                  //     Text(
                                  //       '24 Bulan',
                                  //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(height: 5.0),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       'Tanggal Mulai:',
                                  //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                                  //     ),
                                  //     Text(
                                  //       '1 Januari 2023',
                                  //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(height: 5.0),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       'Tanggal Selesai:',
                                  //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                                  //     ),
                                  //     Text(
                                  //       '1 Desember 2025',
                                  //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                        ]
                      ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Daftar Mitra', style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ))
            ),
            Expanded(
              
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final formattedDate = DateFormat('dd MMMM yyyy HH:mm').format(transaction.date); // Format tanggal
                  final formattedAmount = NumberFormat('#,##0', 'id').format(transaction.amount); // Format jumlah nominal uang
            
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    padding: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(transaction.title),
                      subtitle: Text(formattedDate),
                      trailing: Text('Rp' + formattedAmount, style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),),
                      onTap: _showPaymentDetails, // Menampilkan tampilan hover ketika ditekan
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
