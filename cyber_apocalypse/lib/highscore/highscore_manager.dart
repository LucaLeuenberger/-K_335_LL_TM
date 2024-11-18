import 'package:cyber_apocalypse/highscore/highscore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HighScoreManager {
  static const String _highScoresKey = 'highScores';

  static Future<void> saveHighScore(HighScore highScore) async {
    final prefs = await SharedPreferences.getInstance();
    final highScores = await loadHighScores();
    highScores.add(highScore);
    prefs.setString(_highScoresKey, jsonEncode(highScores.map((e) => e.toJson()).toList()));
  }

  static Future<List<HighScore>> loadHighScores() async {
    final prefs = await SharedPreferences.getInstance();
    final highScoresJson = prefs.getString(_highScoresKey);
    if (highScoresJson != null) {
      final List<dynamic> highScoresList = jsonDecode(highScoresJson);
      return highScoresList.map((e) => HighScore.fromJson(e)).toList();
    }
    return [];
  }

  static Future<void> deleteHighScore(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final highScores = await loadHighScores();
    highScores.removeAt(index);
    prefs.setString(_highScoresKey, jsonEncode(highScores.map((e) => e.toJson()).toList()));
  }
}