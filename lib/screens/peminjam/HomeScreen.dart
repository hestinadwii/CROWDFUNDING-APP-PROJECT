// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:p2p/constant/color_constant.dart';
import 'package:p2p/peminjam/homePeminjam.dart';
import 'package:p2p/peminjam/pengajuanPendanaan.dart';
import 'package:p2p/peminjam/profile.dart';

class HomepagePeminjam extends StatefulWidget {
  @override
  State<HomepagePeminjam> createState() => _HomepagePeminjam();
}

class _HomepagePeminjam extends State<HomepagePeminjam> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    // TODO: Ganti widget dengan halaman yang sesuai
    HomePeminjamWidget(),
    PengajuanPendanaan(),
    HomePeminjamWidget(),
    HomePeminjamWidget(),
    ProfilePage(),
    // ExploreWidget(),
    // NotificationsWidget(),
    // ProfileWidget(),
    // SettingsWidget(),
  ];

  final List<Color> _iconColors = [
    primary, // Warna ikon untuk Home
    primary, 
    primary,
    primary,
    primary, // Warna ikon untuk Settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        selectedItemColor: _iconColors[_currentIndex],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Pinjaman',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Pembayaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
