import 'dart:async';
import 'package:flutter/material.dart';

class CharacterProvider with ChangeNotifier {
  bool _isSonic = true;
  String _playerName = '';

  bool get isSonic => _isSonic;
  String get playerName => _playerName;

  void changeCharacter() {
      _isSonic = !_isSonic;
    notifyListeners();
  }

  bool getCharacter() {
    return _isSonic;
  }

    void setPlayerName(String name) {
    _playerName = name;
    notifyListeners();
  }

}
