// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:p2p/constants/color_constant.dart';
import 'package:p2p/screens/investor/homeInvestor.dart';
import 'package:p2p/screens/investor/view_rating.dart';
import 'package:p2p/screens/investor/profile.dart';
import 'package:p2p/screens/investor/list_mitra.dart';
import 'package:p2p/screens/investor/portofolio.dart';

class HomepageInvestor extends StatefulWidget {
  @override
  State<HomepageInvestor> createState() => _HomepageInvestor();
}

class _HomepageInvestor extends State<HomepageInvestor> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    // TODO: Ganti widget dengan halaman yang sesuai
    HomeInvestorWidget(),
    ListMitra(),
    Portofolio(),
    viewRating(),
    ProfilePage(),
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
            icon: Icon(Icons.shop_2),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Portofolio',
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
