import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:p2p/constants/color_constant.dart';
// import 'package:p2p/constants/style_constant.dart';
import 'package:p2p/screens/investor/porto_mitra.dart';
import 'package:provider/provider.dart';
import 'package:p2p/user_provider.dart';
import 'package:p2p/models/api_helper_model.dart';
import 'package:p2p/url.dart';
import 'package:intl/intl.dart';

import 'package:progress_dialog/progress_dialog.dart';

class ListMitra extends StatefulWidget {
  const ListMitra({super.key});

  @override
  State<ListMitra> createState() => _ListMitra();
}

class _ListMitra extends State<ListMitra> {
  double windowHeight = 0;
  double windowWidth = 0;
  double heighHeader = 300;

  var data = [];

  List<String> chipListUrut = [
    "Terbaik",
    "Terbaru",
  ];

  List<String> chipListKategori = [
    "Agribisnis",
    "Fashion",
    "Kerajinan",
    "Kuliner",
  ];

  void getAllCampaigns() async {
    final getResponse = await ApiHelper.getList(Url().getVal() + "/campaigns/");

    setState(() {
      data = getResponse;
      print(getResponse);
    });
  }

  List<CardWithImg> listMitra() {
    List<CardWithImg> list = [];
    for (Map<String, dynamic> campaign in data) {
      CardWithImg card = CardWithImg(
        pathFile: "assets/images/user_agreement.jpg",
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PortoMitra(
                    data: campaign,
                  )));
        },
        nama: campaign["judul"],
        danaTerkumpul: campaign["dana_terkumpul"],
      );

      list.add(card);
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    getAllCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Column(
            children: [
              AppBar(
                backgroundColor: primary,
                elevation: 0,
                title: const Text(
                  'List Mitra',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: mFillColor),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    color: mFillColor,
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
                    icon: const Icon(Icons.search),
                  ),
                  // filter by rating, kategori umkm, terbaru, target dana(?)
                  IconButton(
                    color: mFillColor,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _titleContainer("Filter"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    spacing: 5.0,
                                    runSpacing: 3.0,
                                    children: <Widget>[
                                      ChoiceChipWidget(chipListUrut),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.blueGrey,
                                height: 10.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _titleContainer("Kategori"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    spacing: 5.0,
                                    runSpacing: 3.0,
                                    children: <Widget>[
                                      ChoiceChipWidget(chipListKategori),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.blueGrey,
                                height: 10.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _titleContainer("Lokasi"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    spacing: 5.0,
                                    runSpacing: 3.0,
                                    children: <Widget>[
                                      FilterChipWidget(chipName: 'Bandung'),
                                      FilterChipWidget(chipName: 'DKI Jakarta'),
                                      FilterChipWidget(chipName: 'Jabodetabek'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.filter_alt_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: windowHeight / 2.5,
            child: GridView(
              padding: const EdgeInsets.all(10),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // childAspectRatio: 8.0 / 10.0,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              children: listMitra(),
            ),
          ),
        )
      ],
    );
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: const TextStyle(
        color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
  );
}

class FilterChipWidget extends StatefulWidget {
  final String chipName;

  const FilterChipWidget({Key? key, required this.chipName}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Colors.white,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: primary,
    );
  }
}

class ChoiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  ChoiceChipWidget(this.reportList);

  @override
  _ChoiceChipWidgetState createState() => new _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Colors.white,
          selectedColor: primary,
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ['aaa', 'bbb', 'ccc']; // buat ngetes

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var umkm in searchTerms) {
      if (umkm.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(umkm);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var umkm in searchTerms) {
      if (umkm.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(umkm);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

class CardWithImg extends StatelessWidget {
  final String pathFile;
  final VoidCallback onTap;
  final String nama;
  int danaTerkumpul = 0;

  CardWithImg(
      {required this.pathFile,
      required this.onTap,
      required this.nama,
      required this.danaTerkumpul});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'in_ID', // Ganti dengan locale yang sesuai
      symbol: 'Rp', // Ganti dengan simbol mata uang yang sesuai
    );

    final formattedAmount = currencyFormat.format(danaTerkumpul);
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: primary,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(0.0, 0.0), // Menyesuaikan posisi bayangan
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                  image: DecorationImage(
                      image: AssetImage(pathFile),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.srcOver)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Dana Yang Sudah Terkumpul',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    formattedAmount,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
