import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Player/player.dart';

void main() {
  runApp(GameWidget(game: DoodleJumpGame()));
}

class DoodleJumpGame extends FlameGame {
  late Player player;

  @override
  Future<void> onLoad() async {
    player = Player();
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update game logic here
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Render game objects here
  }
}
