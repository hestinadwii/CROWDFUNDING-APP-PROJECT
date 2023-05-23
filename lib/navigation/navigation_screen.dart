import 'package:flutter/material.dart';
import 'package:p2p/constants/color_constant.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(NavigateScreen(
    id: 0,
  ));
}

class NavigateScreen extends StatefulWidget {
  static final title = 'salomon_bottom_bar';
  int id;
  NavigateScreen({Key? key, required this.id}) : super(key: key);

  @override
  _NavigateScreenState createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
  var _currentIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    // HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: NavigateScreen.title,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: Container(
            color: const Color.fromARGB(0, 231, 231, 231),
            child: Center(child: _widgetOptions.elementAt(_currentIndex)),
          ),
          bottomNavigationBar: Container(
            height: 84,
            decoration: BoxDecoration(
                color: mFillColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset: Offset(0, 5))
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )),
            child: SalomonBottomBar(
                currentIndex: _currentIndex,
                onTap: (i) => setState(() => _currentIndex = i),
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.home),
                    title: const Text("Home"),
                    selectedColor: mBlueColor,
                    unselectedColor: const Color.fromARGB(255, 121, 121, 121),
                  ),

                  SalomonBottomBarItem(
                    icon: const Icon(Icons.track_changes_outlined),
                    title: const Text("My Farm"),
                    selectedColor: mBlueColor,
                    unselectedColor: const Color.fromARGB(255, 121, 121, 121),
                  ),

                  /// Likes
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.card_giftcard_rounded),
                    title: const Text("Marketplace"),
                    selectedColor: mBlueColor,
                    unselectedColor: Color.fromARGB(255, 121, 121, 121),
                  ),

                  SalomonBottomBarItem(
                    icon: const Icon(Icons.article_rounded),
                    title: const Text("Artikel"),
                    selectedColor: mBlueColor,
                    unselectedColor: Color.fromARGB(255, 121, 121, 121),
                  ),

                  /// Search
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.person_rounded),
                    title: const Text("Profil"),
                    selectedColor: mBlueColor,
                    unselectedColor: Color.fromARGB(255, 121, 121, 121),
                  ),
                ]),
          ),
        ));
  }
}
