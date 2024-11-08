import 'package:cyber_apocalypse/navigation/routes.dart';
import 'package:cyber_apocalypse/ui/widgets/my_button.dart';
import 'package:cyber_apocalypse/ui/widgets/my_text.dart';
import 'package:cyber_apocalypse/cyber_apocalypse.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  final CyberApocalypse game;

  const PauseMenu({
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
                  'Paused',
                  fontSize: 56,
                ),
                const SizedBox(height: 40),
                MyButton(
                  'Resume',
                  onPressed: () {
                    game.overlays.remove('PauseMenu');
                    game.paused = false;
                  },
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
