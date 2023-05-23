// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:libphonenumber/libphonenumber.dart';
import 'package:p2p/screens/pengajuan_pendanaan/currency.dart';
import 'package:p2p/screens/pengajuan_pendanaan/successPage.dart';
//import 'package:intl/intl.dart';

const kGreenColor = Color(0xFF1E6859);
const kWhiteColor = Color(0xFFFFFFFF);

class PengajuanPendanaan extends StatefulWidget {
  const PengajuanPendanaan({super.key});

  @override
  State<PengajuanPendanaan> createState() => _PengajuanPendanaanState();
}

class _PengajuanPendanaanState extends State<PengajuanPendanaan> {
  int index = 0;
  bool isCompleted = false;
  String selectedDay = 'Mingguan';

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  TextEditingController namaUsaha = TextEditingController();
  TextEditingController nomorTelepon = TextEditingController();
  TextEditingController jumlahDana = TextEditingController();
  TextEditingController alamatUsaha = TextEditingController();
  TextEditingController input3 = TextEditingController();

  List<String> jenisAngsuran = [
    'Mingguan',
    'Bulanan',
  ];

  List<Step> steps() => [
        Step(
          state: index > 0 ? StepState.complete : StepState.indexed,
          isActive: index >= 0,
          title: Column(
            children: const [
              Text(
                'Identitas Diri',
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
          content: Form(
            key: formKeys[0],
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    return null;
                  },
                  controller: namaUsaha,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Nama Usaha')),
                ),
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    // final isValid = isValidPhoneNumber(value);
                    // if (!isValid) {
                    //   return 'Nomor telepon tidak valid';
                    // }
                    return null;
                  },
                  controller: nomorTelepon,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Nomor Telepon')),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    return null;
                  },
                  controller: jumlahDana,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Jumlah Dana yang Diajukan'),
                      prefix: Text('Rp ')),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyFormat(),
                  ],
                ),
              ],
            ),
          ),
        ),
        Step(
          state: index > 1 ? StepState.complete : StepState.indexed,
          isActive: index >= 1,
          title: Text(
            'Identitas Usaha',
            style: TextStyle(fontSize: 13),
          ),
          content: Form(
            key: formKeys[1],
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    return null;
                  },
                  controller: alamatUsaha,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Alamat Usaha')),
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: selectedDay,
                  onChanged: (value) {
                    setState(() {
                      selectedDay = value!;
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
              ],
            ),
          ),
        ),
        Step(
          isActive: index >= 2,
          title: Text('Konfirmasi',
          style: TextStyle(fontSize: 13),
          ),
          //title: Text('Konfirmasi'),
          content: Form(
            key: formKeys[2],
            child: Column(
              children: [
                // TextFormField(
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Wajib Diisi';
                //     }
                //     return null;
                //   },
                //   controller: input3,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     label: Text('input 3')
                //   ),
                // ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text('Nama Usaha: ${namaUsaha.text}'),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text('Nomor Telepon: ${nomorTelepon.text}'),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text('Jumlah Dana yang Diajukan: ${jumlahDana.text}'),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text('Alamat Usaha: ${namaUsaha.text}'),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text('Jenis Angsuran: $selectedDay'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: Center(
          child: const Text(
            'Ajukan Pinjaman',
            textAlign: TextAlign.center,
            style: TextStyle(
              backgroundColor: kWhiteColor,
            ),
          ),
        ),
      ),
      body: Theme(
        data: ThemeData(
            colorScheme: ColorScheme.light(primary: kGreenColor),
            fontFamily: "Nunito"),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: index,
          steps: steps(),
          onStepContinue: () {
            final isLastStep = index == steps().length - 1;
            if (formKeys[index].currentState!.validate()) {
              if (isLastStep) {
                //print('completed');
                // navigasi ke halaman sukses
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Success(),
                  ),
                );
              }
              if (index < steps().length - 1) {
                setState(() {
                  index += 1;
                });
              }
            }
          },
          //onStepTapped: (step) => setState(() => index = step),
          onStepCancel: () {
            if (index == 0) {
              return;
            }
            setState(() {
              index -= 1;
            });
          },
          //()  => setState(() => index -= 1),
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            final isLastStep = index == steps().length - 1;
            return Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 197),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controls.onStepContinue,
                            child:
                                Text(isLastStep ? 'Konfirmasi' : 'Selanjutnya'),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                        ),
                        const SizedBox(width: 200),
                        if (index != 0)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: controls.onStepCancel,
                              child: Text('Sebelumnya'),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
