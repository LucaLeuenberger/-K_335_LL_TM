class HighScore {
  final String playerName;
  final int score;

  HighScore({required this.playerName, required this.score});

  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'score': score,
    };
  }

  static HighScore fromJson(Map<String, dynamic> json) {
    return HighScore(
      playerName: json['playerName'],
      score: json['score'],
    );
  }
}