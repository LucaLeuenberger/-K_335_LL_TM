import 'dart:convert';
import 'package:cyber_apocalypse/gameState/game_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GameStateManager {
  static Future<void> saveGameState(SaveGameState gameState) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('gameState', jsonEncode(gameState.toJson()));
  }

  static Future<SaveGameState?> loadGameState() async {
    final prefs = await SharedPreferences.getInstance();
    final gameStateJson = prefs.getString('gameState');
    if (gameStateJson != null) {
      return SaveGameState.fromJson(jsonDecode(gameStateJson));
    }
    return null;
  }

  static Future<void> clearGameState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('gameState');
  }
}