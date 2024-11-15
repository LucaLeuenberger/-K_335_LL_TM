import 'package:cyber_apocalypse/Player/player.dart';
import 'package:cyber_apocalypse/navigation/routes.dart';
import 'package:cyber_apocalypse/provider/character_provider.dart';
import 'package:cyber_apocalypse/ui/gameover_screen.dart';
import 'package:cyber_apocalypse/ui/leaderboard_screen.dart';
import 'package:cyber_apocalypse/ui/main_menu_screen.dart';
import 'package:cyber_apocalypse/ui/neu_game_screen.dart';
import 'package:cyber_apocalypse/ui/pause_menu.dart';
import 'package:cyber_apocalypse/assets.dart';
import 'package:cyber_apocalypse/cyber_apocalypse.dart';
import 'package:cyber_apocalypse/high_scores.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  await HighScores.load();
  await Assets.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterProvider()),
      ],
      child: MaterialApp(
        title: 'Cyber Apocalypse',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Routes.routes,
      ),
    ),
  );
}

class MyGameWidget extends StatelessWidget {
  const MyGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return 
        GameWidget(
          game: CyberApocalypse(context),
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
