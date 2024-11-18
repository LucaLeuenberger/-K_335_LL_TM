import 'package:cyber_apocalypse/gameState/game_state_manager.dart';
import 'package:cyber_apocalypse/navigation/routes.dart';
import 'package:cyber_apocalypse/ui/widgets/my_button.dart';
import 'package:cyber_apocalypse/ui/widgets/my_text.dart';
import 'package:cyber_apocalypse/high_scores.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  MainMenuScreen({
    super.key,
  });

  final gameState = GameStateManager.loadGameState().then((value) => value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Center(
          child: AspectRatio(
            aspectRatio: 9 / 19.5,
            child: Container(
              padding: const EdgeInsets.only(left: 30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ui/background1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: LayoutBuilder(builder: (context, constrains) {
                  return Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          Image.asset('assets/ui/title.png'),
                          MyText(
                            'Best Score: ${HighScores.highScores[0]}',
                            fontSize: 26,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyButton('Spielen',
                                    onPressed: () => {
                                          if (gameState != null)
                                            {
                                              context.pushAndRemoveUntil(
                                                  Routes.game),
                                            }
                                          else
                                            {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Bitte erst ein neues Spiel starten'),
                                              ))
                                            }
                                        }),
                                const SizedBox(height: 40),
                                MyButton(
                                  'Neues Spiel',
                                  onPressed: () => {
                                    context.push(Routes.newgame),
                                    GameStateManager.clearGameState(),
                                    },
                                ),
                                const SizedBox(height: 40),
                                MyButton(
                                  'Spielstand',
                                  onPressed: () =>
                                      context.push(Routes.leaderboard),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
