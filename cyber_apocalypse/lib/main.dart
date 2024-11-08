import 'package:cyber_apocalypse/navigation/routes.dart';
import 'package:cyber_apocalypse/ui/gameover_screen.dart';
import 'package:cyber_apocalypse/ui/pause_menu.dart';
import 'package:cyber_apocalypse/assets.dart';
import 'package:cyber_apocalypse/cyber_apocalypse.dart';
import 'package:cyber_apocalypse/high_scores.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  await HighScores.load();
  await Assets.load();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.routes,
    ),
  );
}

class MyGameWidget extends StatelessWidget {
  const MyGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: CyberApocalypse(),
      overlayBuilderMap: {
        'GameOverMenu': (context, CyberApocalypse game) {
          return GameOverMenu(game: game);
        },
        'PauseMenu': (context, CyberApocalypse game) {
          return PauseMenu(game: game);
        }
      },
    );
  }
}
