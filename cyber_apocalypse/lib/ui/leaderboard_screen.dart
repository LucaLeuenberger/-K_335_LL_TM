import 'package:cyber_apocalypse/assets.dart';
import 'package:cyber_apocalypse/highscore/highscore.dart';
import 'package:cyber_apocalypse/highscore/highscore_manager.dart';
import 'package:cyber_apocalypse/ui/widgets/my_button.dart';
import 'package:cyber_apocalypse/ui/widgets/my_text.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HighScoresScreen extends StatefulWidget {
  @override
  _HighScoresScreenState createState() => _HighScoresScreenState();
}

class _HighScoresScreenState extends State<HighScoresScreen> {
  late Future<List<HighScore>> _highScoresFuture;

  @override
  void initState() {
    super.initState();
    _highScoresFuture = HighScoreManager.loadHighScores();
  }

  void _deleteHighScore(int index) async {
    await HighScoreManager.deleteHighScore(index);
    setState(() {
      _highScoresFuture = HighScoreManager.loadHighScores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
      child: Center(
        child: AspectRatio(
          aspectRatio: 9 / 19.5,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ui/background3.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: SpriteWidget(
                    sprite: Assets.buttonBack,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyText(
                      'Best Scores',
                      fontSize: 42,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height * .6,
                      width: MediaQuery.of(context).size.width * .8,
                      color: Colors.blue.withOpacity(.7),
                      child: FutureBuilder<List<HighScore>>(
                        future: _highScoresFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error loading high scores',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                                child: Text('No high scores available',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)));
                          } else {
                            final highScores = snapshot.data!;
                            return ListView.builder(
                              itemCount: highScores.length,
                              itemBuilder: (context, index) {
                                final highScore = highScores[index];
                                return ListTile(
                                  title: Text(
                                      '${highScore.playerName}: ${highScore.score}', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _deleteHighScore(index),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
