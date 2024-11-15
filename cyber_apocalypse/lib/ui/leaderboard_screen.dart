import 'dart:math';

import 'package:cyber_apocalypse/ui/widgets/my_text.dart';
import 'package:cyber_apocalypse/assets.dart';
import 'package:cyber_apocalypse/high_scores.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';


class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.height * .075;
    return Material(
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
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: SpriteWidget(
                        sprite: Assets.buttonBack,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const MyText(
                  'Best Scores',
                  fontSize: 42,
                  
                ),
                SizedBox(height: spacing),
                Container(
                  color: Colors.blue.withOpacity(.8),
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width * .8,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      MyText(
                        '${HighScores.highScores[0]} - ${HighScores.playerNames[0]}',
                        fontSize: 20,
                      ),
                      MyText(
                        '${HighScores.highScores[1]} - ${HighScores.playerNames[1]}',
                        fontSize: 20,
                      ),
                      MyText(
                        '${HighScores.highScores[2]} - ${HighScores.playerNames[2]}',
                        fontSize: 20,
                      ),
                      MyText(
                        '${HighScores.highScores[3]} - ${HighScores.playerNames[3]}',
                        fontSize: 20,
                      ),
                      MyText(
                        '${HighScores.highScores[4]} - ${HighScores.playerNames[4]}',
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
