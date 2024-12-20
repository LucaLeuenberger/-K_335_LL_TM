import 'package:cyber_apocalypse/highscore/highscore.dart';
import 'package:cyber_apocalypse/highscore/highscore_manager.dart';
import 'package:cyber_apocalypse/provider/character_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighScores {
  static late final SharedPreferences prefs;
  static final highScores = List.filled(5, 0, growable: false);
  static final playerNames = List.filled(5, '', growable: false);

  static Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 5; i++) {
      int score = prefs.getInt('score$i') ?? 0;
      highScores[i] = score;
    }
  }

  static Future<void> saveNewScore(BuildContext context,int score) async {
    final characterProvider = Provider.of<CharacterProvider>(context, listen: false);
    final playerName = characterProvider.playerName;
    for (int i = 0; i < 5; i++) {
      if (highScores[i] < score) {
        for (int j = 4; j > i; j--) {
          highScores[j] = highScores[j - 1];
          playerNames[j] = playerNames[j - 1];
        }
        highScores[i] = score;
        playerNames[i] = playerName;
        final highScore = HighScore(playerName: playerName, score: score);
        await HighScoreManager.saveHighScore(highScore);
        break;
      }
    }



    for (int i = 0; i < 5; i++) {
      await prefs.setInt('score$i', highScores[i]);
    }
  }
}
