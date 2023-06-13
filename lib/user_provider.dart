import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  int _userId = -1;

  String _namaLegkap = "";

  String get namaLengkap => _namaLegkap;

  int get userId => _userId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  void setNamaLengkap(String namaLengkap) {
    _namaLegkap = namaLengkap;
    notifyListeners();
  }
}
