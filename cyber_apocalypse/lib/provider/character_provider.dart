import 'dart:async';
import 'package:flutter/material.dart';

class CharacterProvider with ChangeNotifier {
  bool _isSonic = true;

  bool get isSonic => _isSonic;

  void changeCharacter() {
      _isSonic = !_isSonic;
    notifyListeners();
  }

}
