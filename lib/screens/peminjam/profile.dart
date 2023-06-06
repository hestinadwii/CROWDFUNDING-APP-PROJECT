// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:p2p/constant/color_constant.dart';

class ProfilePage extends StatefulWidget {
 const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Muhahamd Nur Yasin';
  String phoneNumber = '08888';
  String email = 'yasin@gmail.com';
  String accountNumber = '12345';
  String profilePicture = 'assets/images/Foto_Profil2.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          title: Text('Profil', style: TextStyle(fontSize: 25)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(profilePicture),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nama: $name',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Nomor HP: $phoneNumber',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Nomor Rekening: $accountNumber',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Edit Profil', style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: white,
                ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary, // Warna background tombol
                minimumSize: Size(150, 48), // Ukuran lebar tombol
              ),  
              onPressed: () {
                _showEditProfileDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(profilePicture),
                ),
                SizedBox(height: 10), 
                ElevatedButton(
                  child: Text('Ubah Foto Profil', style: TextStyle(fontSize: 16, color: white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary, // Warna background tombol
                    minimumSize: Size(150, 48), // Ukuran lebar tombol
                  ),
                  onPressed: () {
                   // _selectProfilePicture();
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Nama'),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Nomor HP'),
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Nomor Rekening'),
                  onChanged: (value) {
                    setState(() {
                      accountNumber = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Simpan', style: TextStyle(fontSize: 16, color: white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary, // Warna background tombol
                minimumSize: Size(150, 48), // Ukuran lebar tombol
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
