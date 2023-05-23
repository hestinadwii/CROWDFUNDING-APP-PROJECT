// import 'dart:convert';
// import 'dart:developer';

// // import 'package:bitanic/screens/article_screen.dart';
// // import 'package:bitanic/screens/crops_screen.dart';
// // import 'package:bitanic/screens/device_screen.dart';
// // import 'package:bitanic/screens/farm_screen.dart';
// // import 'package:bitanic/screens/growth_calendar_screen.dart';
// // import 'package:bitanic/screens/notification_screen.dart';
// // import 'package:bitanic/screens/plant_screen.dart';
// import 'package:p2p/url.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:fancy_snackbar/fancy_snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:p2p/constants/color_constant.dart';
// import 'package:p2p/constants/style_constant.dart';
// import 'package:p2p/models/carousel_model.dart';
// import 'package:p2p/models/popular_destination_model.dart';
// import 'package:p2p/models/travlog_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _current = 0;

//   // List<PopularDestinationModel> listModel = [];
//   // List<TravlogModel> listModelTravlogs = [];
//   // List<CarouselModel> listModelCarousel = [];
//   var loading = false;

//   List<T> map<T>(List list, Function handler) {
//     List<T> result = [];
//     for (var i = 0; i < list.length; i++) {
//       result.add(handler(i, list[i]));
//     }
//     return result;
//   }

//   String nama = "";
//   List<Widget> imageSliders = [];
//   var storage = new FlutterSecureStorage();
//   List<TravlogModel> listBlog = [];
//   List<CarouselModel> listIklan = [];
//   List<PopularDestinationModel> listTanaman = [];
//   getDataCarousel() async {
//     String token = await storage.read(key: "token") ?? "";
//     String apiURL = Url().getVal() + "api/mobile/home";
//     final responseData = await http.get(Uri.parse(apiURL), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       "Connection": "Keep-Alive",
//       "Keep-Alive": "timeout=5, max=1000",
//       'Authorization': 'Bearer ' + token,
//     });
//     if (responseData.statusCode == 200) {
//       final data = jsonDecode(responseData.body);
//       final iklan = data['data']['iklan'];
//       final tanaman = data['data']['tanaman'];
//       final artikel = data['data']['artikel'];
//       print(data);
//       nama = data['data']['nama_akun'];
//       for (Map i in iklan) {
//         listIklan.add(CarouselModel.fromJson(convertMap(i)));
//       }
//       for (int index = 0; index < listIklan.length; index++) {
//         imageSliders.add(Container(
//           child: Stack(children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 image: DecorationImage(
//                     colorFilter: ColorFilter.mode(
//                         Color.fromARGB(255, 57, 104, 59).withOpacity(0.5),
//                         BlendMode.srcOver),
//                     image: NetworkImage(listIklan[index].image != null
//                         ? Url().val + listIklan[index].image!
//                         : ""),
//                     fit: BoxFit.cover),
//               ),
//             ),
//             // Positioned(
//             //   left: 0,
//             //   top: 0,
//             //   child: ClipRRect(
//             //     borderRadius: BorderRadius.circular(20),
//             //     child: SvgPicture.asset('assets/svg/shadowGreen.svg'),
//             //   ),
//             // ),
//             Positioned(
//               top: 10,
//               right: 10,
//               child: Image.asset(
//                 'assets/images/logoWhite.png',
//                 width: 70,
//               ),
//             ),
//             Positioned(
//               left: 15,
//               bottom: 20,
//               width: 200,
//               child: Text(
//                 listIklan[index].label != null ? listIklan[index].label! : "",
//                 style: mTravlogBannerStyle.copyWith(fontSize: 20),
//               ),
//             ),
//           ]),
//         ));
//       }
//       for (Map i in tanaman) {
//         listTanaman.add(PopularDestinationModel.fromJson(convertMap(i)));
//       }
//       for (Map i in artikel) {
//         listBlog.add(TravlogModel.fromJson(convertMap(i)));
//       }
//       loading = false;
//       if (!mounted) return;
//       setState(() {});
//     }
//   }

//   Map<String, dynamic> convertMap(Map<dynamic, dynamic> map) {
//     map.forEach((key, value) {
//       if (value is Map) {
//         // it's a map, process it
//         value = convertMap(value);
//       }
//     });
//     // use .from to ensure the keys are Strings
//     return Map<String, dynamic>.from(map);
//     // more explicit alternative way:
//     // return Map.fromEntries(map.entries.map((entry) => MapEntry(entry.key.toString(), entry.value)));
//   }

//   _HomeScreenState() {}

//   void get() async {
//     String? a = await storage.read(key: "token");
//     log("token :   " + a!);
//   }

//   void setStateIfMounted(f) {
//     if (mounted) setState(f);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getDataCarousel();
//     get();
//     //getData();
//     //getDataTravlogs();
//   }

//   //
//   final CarouselController _controller = CarouselController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Setting up AppBar
//       appBar: AppBar(
//         backgroundColor: mBackgroundColor,
//         title: Image.asset(
//           'assets/images/logo.png',
//           width: 100,
//         ),
//         actions: [
//           Container(
//             padding: const EdgeInsets.only(right: 16),
//             child: InkWell(
//               onTap: () async {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => NotificationScreen()));
//               },
//               child: Icon(
//                 Icons.notifications_none_outlined,
//                 size: 30,
//                 color: Color.fromARGB(255, 87, 87, 87),
//               ),
//             ),
//           )
//         ],
//         elevation: 0,
//       ),

//       // Setting up Background Color
//       backgroundColor: mBackgroundColor,

//       // Body
//       body: Container(
//         child: ListView(
//           physics: BouncingScrollPhysics(),
//           children: <Widget>[
//             // Promos Section
//             Padding(
//               padding: EdgeInsets.only(left: 16, bottom: 24),
//               child: Text(
//                 'Hi, $nama 👋 \nWelcome back!',
//                 style: mTitleStyle,
//               ),
//             ),
//             Container(
//               child: CarouselSlider(
//                 items: imageSliders,
//                 carouselController: _controller,
//                 options: CarouselOptions(
//                     autoPlay: true,
//                     enlargeCenterPage: true,
//                     aspectRatio: 2.0,
//                     enlargeFactor: 0.2,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         _current = index;
//                       });
//                     }),
//               ),
//             ),

//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 16, right: 16),
//               width: MediaQuery.of(context).size.width,
//               height: 40,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   // Container(
//                   //   width: MediaQuery.of(context).size.width,
//                   //   height: 190,
//                   //   child: Swiper(
//                   //     onIndexChanged: (index) {
//                   //       setState(() {
//                   //         _current = index;
//                   //       });
//                   //     },
//                   //     autoplay: true,
//                   //     layout: SwiperLayout.DEFAULT,
//                   //     itemCount: listIklan.length,
//                   //     itemBuilder: (BuildContext context, index) {
//                   //       return Container(
//                   //         child: Stack(children: [
//                   //           Container(
//                   //             decoration: BoxDecoration(
//                   //               borderRadius: BorderRadius.circular(8),
//                   //               image: DecorationImage(
//                   //                   colorFilter: ColorFilter.mode(
//                   //                       Colors.black.withOpacity(0.5),
//                   //                       BlendMode.srcOver),
//                   //                   image: NetworkImage(
//                   //                       listIklan[index].image != null
//                   //                           ? Url().val +
//                   //                               listIklan[index].image!
//                   //                           : ""),
//                   //                   fit: BoxFit.cover),
//                   //             ),
//                   //           ),
//                   //           Positioned(
//                   //             left: 0,
//                   //             top: 0,
//                   //             child: ClipRRect(
//                   //               borderRadius: BorderRadius.circular(8),
//                   //               child: SvgPicture.asset(
//                   //                   'assets/svg/shadowGreen.svg'),
//                   //             ),
//                   //           ),
//                   //           Positioned(
//                   //             top: 10,
//                   //             right: 10,
//                   //             child: Image.asset(
//                   //               'assets/images/logoWhite.png',
//                   //               width: 70,
//                   //             ),
//                   //           ),
//                   //           Positioned(
//                   //             left: 15,
//                   //             bottom: 30,
//                   //             width: 200,
//                   //             child: Text(
//                   //               listIklan[index].label != null
//                   //                   ? listIklan[index].label!
//                   //                   : "",
//                   //               style: mTravlogBannerStyle,
//                   //             ),
//                   //           ),
//                   //         ]),
//                   //       );
//                   //     },
//                   //   ),
//                   // ),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Row(
//                         children: map<Widget>(
//                           listIklan,
//                           (index, image) {
//                             return Container(
//                               alignment: Alignment.centerLeft,
//                               height: 6,
//                               width: 6,
//                               margin: EdgeInsets.only(right: 8),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: _current == index
//                                       ? mBlueColor
//                                       : mGreyColor),
//                             );
//                           },
//                         ),
//                       ),

//                       // More
//                       InkWell(
//                         onTap: () async {},
//                         child: Text(
//                           'More...',
//                           style: mMoreDiscountStyle,
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Service Section
//             Padding(
//               padding: EdgeInsets.only(left: 16, top: 24, bottom: 12),
//               child: Text(
//                 'Let\'s Start!',
//                 style: mTitleStyle,
//               ),
//             ),
//             Container(
//               height: 80,
//               margin: EdgeInsets.only(left: 16, right: 16),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: InkWell(
//                           onTap: () async {
//                             // Navigator.of(context).push(MaterialPageRoute(
//                             //     builder: (context) => DeviceScreen()));
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(right: 8),
//                             padding: EdgeInsets.only(left: 16),
//                             height: 64,
//                             decoration: BoxDecoration(
//                               color: mFillColor,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: mBorderColor, width: 1),
//                             ),
//                             child: Row(
//                               children: <Widget>[
//                                 Container(
//                                   margin: EdgeInsets.only(top: 13, bottom: 13),
//                                   child: Image.asset(
//                                     'assets/icons/device.png',
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 16),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         'My Device',
//                                         style: mServiceTitleStyle,
//                                       ),
//                                       Text(
//                                         'Let\'s take a break',
//                                         style: mServiceSubtitleStyle,
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: InkWell(
//                           onTap: () async {
//                             // Navigator.of(context).push(MaterialPageRoute(
//                             //     builder: (context) => CropsScreen()));
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(left: 8),
//                             padding: EdgeInsets.only(left: 16),
//                             height: 64,
//                             decoration: BoxDecoration(
//                               color: mFillColor,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: mBorderColor, width: 1),
//                             ),
//                             child: Row(
//                               children: <Widget>[
//                                 Container(
//                                   margin: EdgeInsets.only(top: 13, bottom: 13),
//                                   child: Image.asset(
//                                     'assets/icons/corp.png',
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 16),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         'My Crops',
//                                         style: mServiceTitleStyle,
//                                       ),
//                                       Text(
//                                         'Intercity',
//                                         style: mServiceSubtitleStyle,
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Popular Destination Section
//             Padding(
//               padding:
//                   EdgeInsets.only(left: 16, top: 14, bottom: 12, right: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Your Plant!',
//                     style: mTitleStyle,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (context) => PlantScreen()));
//                     },
//                     child: Text(
//                       'More...',
//                       style: mMoreDiscountStyle,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               height: 140,
//               child: ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 itemCount: listTanaman.length,
//                 padding: EdgeInsets.only(left: 16, right: 16),
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   final nDataList = listTanaman[index];
//                   return Card(
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Container(
//                       height: 140,
//                       width: 120,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: mBorderColor, width: 1),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 8.0, bottom: 16),
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               width: 74.0,
//                               height: 74.0,
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   image: new DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: NetworkImage(nDataList.image != null
//                                         ? Url().val + nDataList.image!
//                                         : ""),
//                                   )),
//                             ),
//                             Text(
//                               nDataList.name!,
//                               style: mPopularDestinationTitleStyle,
//                             ),
//                             Text(
//                               nDataList.country!,
//                               style: mPopularDestinationSubtitleStyle,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Travlog Section
//             Padding(
//               padding:
//                   EdgeInsets.only(left: 16, top: 24, bottom: 12, right: 16),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Article!',
//                       style: mTitleStyle,
//                     ),
//                     InkWell(
//                       onTap: () async {
//                         // Navigator.of(context).push(MaterialPageRoute(
//                         //     builder: (context) => ArticleScreen()));
//                       },
//                       child: Text(
//                         'More...',
//                         style: mMoreDiscountStyle,
//                       ),
//                     )
//                   ]),
//             ),
//             Container(
//               height: 181,
//               child: ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 padding: EdgeInsets.only(left: 16),
//                 itemCount: listBlog.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   final nDataListTrav = listBlog[index];
//                   return Container(
//                     margin: EdgeInsets.only(right: 16),
//                     width: 220,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Stack(
//                           children: <Widget>[
//                             Container(
//                               height: 104,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 image: DecorationImage(
//                                     image: NetworkImage(
//                                         nDataListTrav.image != null
//                                             ? Url().val + nDataListTrav.image!
//                                             : ""),
//                                     fit: BoxFit.cover),
//                               ),
//                             ),
//                             Positioned(
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(8)),
//                                   child: SvgPicture.asset(
//                                       'assets/svg/topRight.svg',
//                                       width: 70)),
//                               right: 0,
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: SvgPicture.asset(
//                                   'assets/svg/bottom.svg',
//                                   width: 220,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 8,
//                               right: 8,
//                               child: Image.asset(
//                                 'assets/images/logoWhite.png',
//                                 width: 38,
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 8,
//                               left: 8,
//                               child: Container(
//                                 width: 250,
//                                 child: Text(
//                                   nDataListTrav.name != null
//                                       ? nDataListTrav.name!
//                                       : "",
//                                   style: mTravlogTitleStyle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           nDataListTrav.content != null
//                               ? nDataListTrav.content!
//                               : "",
//                           maxLines: 3,
//                           overflow: TextOverflow.ellipsis,
//                           style: mTravlogContentStyle,
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           nDataListTrav.place != null
//                               ? nDataListTrav.place!
//                               : "",
//                           style: mTravlogPlaceStyle,
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
