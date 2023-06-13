import 'package:flutter/material.dart';
import 'package:p2p/constants/color_constant.dart';
import 'package:intl/intl.dart';

class RiwayatPinjaman extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      title: 'Pinjaman A',
      amount: 2500000,
      date: DateTime(2022, 5, 1),
    ),
    Transaction(
      title: 'Pinjaman B',
      amount: 1500000,
      date: DateTime(2022, 5, 3),
    ),
    Transaction(
      title: 'Pinjaman C',
      amount: 1500000,
      date: DateTime(2022, 5, 10),
    ),
    // Tambahkan data transaksi pinjaman lainnya sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            final formattedDate = DateFormat('dd MMMM yyyy HH:mm')
                .format(transaction.date); // Format tanggal
            final formattedAmount = NumberFormat('#,##0', 'id')
                .format(transaction.amount); // Format jumlah nominal uang

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(transaction.title),
                  subtitle: Text(formattedDate),
                  trailing: Text(
                    'Rp' + formattedAmount,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

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
