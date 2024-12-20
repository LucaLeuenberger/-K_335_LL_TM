import 'package:flame/components.dart';

class SaveGameState {
  final Vector2 playerPosition;
  final int score;
  final bool hasJetpack;
  final bool hasBubbleShield;
  final String playerName;

  SaveGameState({
    required this.playerPosition,
    required this.score,
    required this.hasJetpack,
    required this.hasBubbleShield,
    required this.playerName,
  });

  Map<String, dynamic> toJson() {
    return {
      'playerPosition': {'x': playerPosition.x, 'y': playerPosition.y},
      'score': score,
      'hasJetpack': hasJetpack,
      'hasBubbleShield': hasBubbleShield,
      'playerName': playerName,
    };
  }

  static SaveGameState fromJson(Map<String, dynamic> json) {
    return SaveGameState(
      playerPosition: Vector2(json['playerPosition']['x'], json['playerPosition']['y']),
      score: json['score'],
      hasJetpack: json['hasJetpack'],
      hasBubbleShield: json['hasBubbleShield'],
      playerName: json['playerName'],
    );
  }
}