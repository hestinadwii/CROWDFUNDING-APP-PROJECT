// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:p2p/screens/investor/HomeScreen.dart';
import 'package:givestarreviews/givestarreviews.dart';
import 'package:p2p/screens/investor/view_rating.dart';
import 'package:p2p/constants/color_constant.dart';


class giveRating extends StatefulWidget {
  const giveRating({super.key});

  @override
  State<giveRating> createState() => _giveRatingState();
}

class _giveRatingState extends State<giveRating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => viewRating()));
          },
        ),
        centerTitle: true,
        backgroundColor: mBackgroundColor,
        title: const Text('UMKM X'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) => Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rating saat ini :',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          )),
                      StarRating(value: 4),
                    ],
                  ),
                  GiveStarReviews(
                    starData: [
                      GiveStarData(
                          text: 'Rating anda      :', onChanged: (rate) {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Review anda   :',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          )),
                      Padding(
                        padding: EdgeInsets.all(25),
                      ),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: primary),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    maxLines: 5,
                    // minLines: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomepageInvestor()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      child: const Text('Simpan Rating',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: mFillColor,
                          )),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              )),
        ),
      ),
    );
  }
}
