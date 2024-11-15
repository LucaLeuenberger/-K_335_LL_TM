import 'package:cyber_apocalypse/navigation/routes.dart';
import 'package:cyber_apocalypse/ui/widgets/my_button.dart';
import 'package:cyber_apocalypse/ui/widgets/my_text.dart';
import 'package:cyber_apocalypse/cyber_apocalypse.dart';
import 'package:cyber_apocalypse/high_scores.dart';
import 'package:flutter/material.dart';

class GameOverMenu extends StatelessWidget {
  final CyberApocalypse game;

  const GameOverMenu({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.black38,
      child: Center(
        child: AspectRatio(
          aspectRatio: 9 / 19.5,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(height: height * .15),
                const MyText(
                  'Game Over!',
                  fontSize: 40,
                ),
                SizedBox(height: height * .15),
                Table(
                  // border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(.2),
                    1: FlexColumnWidth(.5),
                    2: FlexColumnWidth(.2),
                    3: FlexColumnWidth(.1),
                  },
                  children: [
                    TableRow(
                      children: [
                        const SizedBox(),
                        const MyText('Score'),
                        MyText(game.score.toString()),
                        const SizedBox(),
                      ],
                    ),
                    TableRow(
                      children: [
                        const SizedBox(),
                        const MyText('Best'),
                        MyText('${HighScores.highScores[0]}'),
                        const SizedBox(),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                MyButton(
                  'Try Again',
                  onPressed: () => context.pushAndRemoveUntil(Routes.game),
                ),
                const SizedBox(height: 40),
                MyButton(
                  'Menu',
                  onPressed: () => context.pushAndRemoveUntil(Routes.main),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
