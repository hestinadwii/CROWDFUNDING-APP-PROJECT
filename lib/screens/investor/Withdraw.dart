// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2p/constants/color_constant.dart'; 
import 'package:p2p/screens/investor/successPageWithdraw.dart'; 
import 'package:p2p/screens/peminjam/Currency.dart'; 
import 'package:flutter_svg/flutter_svg.dart';

class Withdraw extends StatefulWidget {
   const Withdraw({super.key});

  @override
  _WithdrawState createState() => _WithdrawState();
}

class Bank {
  final String name;
  final String iconPath;

  Bank({required this.name, required this.iconPath});
}

class _WithdrawState extends State<Withdraw> {
  int value = 0;

  TextEditingController jumlahDana= TextEditingController();
  TextEditingController nomorRekening = TextEditingController();

  Bank? selectedBank;

  List<Bank> banks = [
    Bank(name: 'Bank BNI', iconPath: 'assets/icon/BNI_logo.png'),
    Bank(name: 'Bank BRI', iconPath: 'assets/icon/BRI_logo.svg'),
    Bank(name: 'Bank BCA', iconPath: 'assets/icon/BCA_logo.svg'),
    Bank(name: 'Bank Mandiri', iconPath: 'assets/icon/Mandiri_logo.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          title: Text('Tarik Pinjaman'),
        ),
        
        //child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          Text(
            'Pilih Metode Penarikan Dana',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<Bank>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: primary, // Warna border
                    width: 2.0, // Lebar border
                  ),
                ),
                labelText: 'Pilih Nama Bank',
              ),
              value: selectedBank,
              items: banks.map((bank) {
                return DropdownMenuItem<Bank>(
                  value: bank,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        bank.iconPath,
                        width: 24.0,
                        height: 24.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(bank.name),
                    ],
                  )
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBank = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: nomorRekening,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: primary, // Warna border
                    width: 2.0, // Lebar border
                  ),
                ),
                label: Text('Nomor Rekening')
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
          ),
          Spacer(), // Spacer untuk mengatur posisi tombol submit di bagian bawah
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Success()),
                );
              },
              child: Text('Transfer', style: TextStyle(fontSize: 16, color: white)), 
              style: ElevatedButton.styleFrom(
                backgroundColor: primary, // Warna background tombol
                minimumSize: Size(150, 48), // Ukuran lebar tombol
              ),
            ),
          ),
        ],
      ),
    );
  }
}