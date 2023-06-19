// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2p/constants/color_constant.dart'; 
import 'package:p2p/screens/peminjam/successPageWithdraw.dart'; 
import 'package:p2p/screens/peminjam/Currency.dart'; 

class Topup extends StatefulWidget {
   const Topup({super.key});

  @override
  _TopupState createState() => _TopupState();
}

class Bank {
  final String name;

  Bank({required this.name});
}

class _TopupState extends State<Topup> {
  int value = 0;

  TextEditingController jumlahDana= TextEditingController();
  TextEditingController nomorRekening = TextEditingController();

  Bank? selectedBank;

  List<Bank> banks = [
    Bank(name: 'Bank BNI'),
    Bank(name: 'Bank BRI'),
    Bank(name: 'Bank Mandiri'),
    Bank(name: 'Bank BCA'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          title: Text('Top Up Saldo'),
        ),
        
        //child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          Text(
            'Pilih Metode Top Up Saldo',
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
              child: Text('Top Up', style: TextStyle(fontSize: 16, color: white)), 
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