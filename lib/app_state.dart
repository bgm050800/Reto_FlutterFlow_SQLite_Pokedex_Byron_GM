import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _ValidarCargaCompleta =
          prefs.getBool('ff_ValidarCargaCompleta') ?? _ValidarCargaCompleta;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _ValidarCargaCompleta = false;
  bool get ValidarCargaCompleta => _ValidarCargaCompleta;
  set ValidarCargaCompleta(bool value) {
    _ValidarCargaCompleta = value;
    prefs.setBool('ff_ValidarCargaCompleta', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
