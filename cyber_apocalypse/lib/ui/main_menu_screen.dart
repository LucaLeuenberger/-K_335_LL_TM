import 'package:cyber_apocalypse/navigation/routes.dart';
import 'package:cyber_apocalypse/ui/widgets/my_button.dart';
import 'package:cyber_apocalypse/ui/widgets/my_text.dart';
import 'package:cyber_apocalypse/high_scores.dart';
import 'package:flutter/material.dart';


class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: AspectRatio(
          aspectRatio: 9 / 19.5,
          child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              MyButton(
                                'Spielen',
                                onPressed: () =>
                                    context.pushAndRemoveUntil(Routes.game),
                              ),
                              const SizedBox(height: 40),
                              MyButton(
                                'Neues Spiel',
                                onPressed: () {},
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
    );
  }
}
