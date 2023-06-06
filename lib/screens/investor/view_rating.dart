import 'package:flutter/material.dart';
import 'package:p2p/constant/color_constant.dart';
import 'package:givestarreviews/givestarreviews.dart';
import 'package:p2p/investor/give_rating.dart';

// void main() => runApp(view_rating());

// class view_rating extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Rating UMKM',
//       home: Home(),
//     );
//   }
// }

class viewRating extends StatefulWidget {
  const viewRating({super.key});

  @override
  State<viewRating> createState() => _ViewRating();
}

class _ViewRating extends State<viewRating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: mFillColor,
        ),
        centerTitle: true,
        backgroundColor: mBackgroundColor,
        title: const Text('Rating UMKM'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) => Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: <Widget>[
                  // Divider(height: 20),
                  SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('UMKM X',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            )),
                        StarRating(value: 4),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: primary,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text(
                            'Ringkasan UMKM X\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ac lectus fermentum, gravida nisl vel, ultrices eros. In hac habitasse platea dictumst. Aenean aliquet luctus arcu, ut tempor turpis auctor sit amet. Cras risus neque, luctus sed tellus sed, dapibus placerat purus. Vestibulum turpis dolor, elementum id sollicitudin eu, rutrum sit amet leo. Pellentesque interdum semper augue, vel pharetra erat cursus at. Ut finibus eros sit amet molestie porta. Vestibulum tincidunt orci nec rutrum pretium. Aliquam in eros vel nisl egestas maximus ac ut purus. Proin elementum ultricies eros.\n\nInvestasi sejauh ini : Rp. xxx\n\nInvestasi Pertama  :dd-mm-yyyy\n\nInvestasi Terakhir  :dd-mm-yyyy\n',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: mFillColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: Colors.white54,
                      ),
                      color: primary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => giveRating()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                              ),
                              child: const Text(
                                'Beri Rating',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: mFillColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
