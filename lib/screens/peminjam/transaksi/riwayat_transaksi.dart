// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:p2p/constant/color_constant.dart'; 
import 'package:intl/intl.dart';

class Transaction {
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
  });
}

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final List<Transaction> transactions = [
    Transaction(
      title: 'Pembayaran Cicilan',
      amount: 250000,
      date: DateTime(2023, 5, 1),
    ),
    Transaction(
      title: 'Pembayaran Cicilan',
      amount: 150000,
      date: DateTime(2023, 5, 3),
    ),
    Transaction(
      title: 'Top Up',
      amount: 500000,
      date: DateTime(2023, 5, 5),
    ),
    Transaction(
      title: 'Pembayaran Cicilan',
      amount: 250000,
      date: DateTime(2023, 5, 1),
    ),
    Transaction(
      title: 'Pembayaran Cicilan',
      amount: 150000,
      date: DateTime(2023, 5, 3),
    ),
    Transaction(
      title: 'Top Up',
      amount: 5000000,
      date: DateTime(2023, 5, 5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          backgroundColor: primary,
          title: (Text('Riwayat Transaksi', style: TextStyle(color: white))),
        ),
      ),
      body: ListView.builder(
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
              onTap: () {
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
                          SizedBox(height: 16.0),
                          Text(
                            transaction.title,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tanggal:',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nominal:',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  'Rp' + formattedAmount,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      'assets/images/success.gif', // Ganti dengan path GIF pembayaran sukses
                                      width: 18.0,
                                      height: 18.0,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Pembayaran Sukses',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
