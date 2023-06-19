// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2p/screens/peminjam/currency.dart';
import 'package:p2p/constants/color_constant.dart';
import 'package:p2p/screens/peminjam/successPage.dart';
import 'package:intl/intl.dart';

class Activity {
  final String title;
  final double amount;
  final DateTime date;
  final double gatheredMoney;

  Activity({
    required this.title,
    required this.amount,
    required this.date,
    required this.gatheredMoney,
  });
}

class PengajuanPendanaan extends StatefulWidget {
  const PengajuanPendanaan({Key? key}) : super(key: key);

  @override
  _PengajuanPendanaanState createState() => _PengajuanPendanaanState();
}

class _PengajuanPendanaanState extends State<PengajuanPendanaan>
    with SingleTickerProviderStateMixin {
  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

//   double windowHeight = 0;
//   double windowWidth = 0;
  int value = 0;
  String selectedTenor = 'Mingguan';
  List<String> jenisAngsuran = [
    'Mingguan',
    'Bulanan',
  ];

  List<Activity> activities = [
    Activity(
        title: 'Pendanaan Pedagang Kelontong',
        amount: 2500000,
        date: DateTime(2022, 5, 1),
        gatheredMoney: 100000),
    Activity(
      title: 'Pendanaan Pedagang Gorengan',
      amount: 1500000,
      date: DateTime(2022, 5, 3),
      gatheredMoney: 300000,
    ),
    // Tambahkan data transaksi pinjaman lainnya sesuai kebutuhan
  ];

  late TabController _tabController;
  TextEditingController judul = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController jumlahDana = TextEditingController();
  TextEditingController tanggalMulai = TextEditingController();
  TextEditingController tanggalSelesai = TextEditingController();
  TextEditingController tenor = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    judul.dispose();
    deskripsi.dispose();
    jumlahDana.dispose();
    tanggalMulai.dispose();
    tanggalSelesai.dispose();
    tenor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text('Pinjaman', style: TextStyle(color: white)),
        bottom: TabBar(
          unselectedLabelColor: white,
          unselectedLabelStyle: TextStyle(color: white),
          controller: _tabController,
          indicatorColor: primary, // Mengubah warna indikator
          labelColor: white, // Mengubah warna teks pada tab yang aktif
          tabs: [
            Tab(text: 'Pengajuan'),
            Tab(text: 'Aktivitas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: judul,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: primary,
                        width: 2.0,
                      ),
                    ),
                    labelText: 'Judul',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: deskripsi,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: primary,
                        width: 2.0,
                      ),
                    ),
                    labelText: 'Deskripsi',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: jumlahDana,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: primary,
                        width: 2.0,
                      ),
                    ),
                    labelText: 'Jumlah Dana',
                    prefix: Text('Rp '),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyFormat(),
                  ],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: tanggalSelesai,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: primary,
                        width: 2.0,
                      ),
                    ),
                    labelText: 'Tanggal Selesai',
                  ),
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.done,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        tanggalSelesai.text = _formatDate(pickedDate);
                      });
                    }
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: selectedTenor,
                  onChanged: (value) {
                    setState(() {
                      selectedTenor = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Pilih Jenis Angsuran',
                  ),
                  items: jenisAngsuran.map((String day) {
                    return DropdownMenuItem<String>(
                      value: day,
                      child: Text(day),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Success()),
                    );
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    minimumSize: Size(150, 48),
                  ),
                ),
              ],
            ),
          ),
          // Tab kedua (Riwayat Transaksi)
          Container(
            // padding: EdgeInsets.all(16.0),
            // child: ListView.builder(
            //   itemCount: activities.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     Activity transaction = activities[index];
            //   },
            // ),
            child: Scaffold(
              body: ListView.builder(
                shrinkWrap: true,
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final transaction = activities[index];
                  final formattedDate = DateFormat('dd MMMM yyyy')
                      .format(transaction.date); // Format tanggal
                  final formattedAmount = NumberFormat('#,##0', 'id')
                      .format(transaction.amount); // Format jumlah nominal uang
                  final formattedAmount2 = NumberFormat('#,##0', 'id')
                      .format(transaction.gatheredMoney);
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(transaction.title),
                        subtitle: Text(formattedDate),
                        trailing: Column(
                          children: [
                            Text(
                              'Pengajuan Dana:' + 'Rp' + formattedAmount,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              'Dana Terkumpul:' + 'Rp' + formattedAmount2,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
