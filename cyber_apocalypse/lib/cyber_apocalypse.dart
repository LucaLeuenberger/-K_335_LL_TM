import 'dart:math';

import 'package:cyber_apocalypse/Components/backgroung.dart';
import 'package:cyber_apocalypse/Components/bullet.dart';
import 'package:cyber_apocalypse/Components/cloud_enemy.dart';
import 'package:cyber_apocalypse/Components/coin.dart';
import 'package:cyber_apocalypse/Components/floor.dart';
import 'package:cyber_apocalypse/Components/heart_enemy.dart';
import 'package:cyber_apocalypse/Components/platform_pieces.dart';
import 'package:cyber_apocalypse/Player/player.dart';
import 'package:cyber_apocalypse/components/power_up.dart';
import 'package:cyber_apocalypse/Components/platform.dart';
import 'package:cyber_apocalypse/high_scores.dart';
import 'package:cyber_apocalypse/ui/game_ui.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/widgets.dart';


final gameSize = Vector2(428, 926);
final worldSize = Vector2(4.28, 9.26);

final random = Random();

enum GameState {
  running,
  gameOver,
}


class CyberApocalypse extends Forge2DGame
    with HasKeyboardHandlerComponents, TapCallbacks {
  late final Player player;
  final BuildContext context;

  int score = 0;
  int coins = 0;
  int bullets = 0;
  double generatedWorldHeight = -2.55;

  var state = GameState.running;

  // Scale the screenSize by 100 and set the gravity of 15
  CyberApocalypse(this.context)
      : super(
          zoom: 100,
          camera: CameraComponent.withFixedResolution(
            width: gameSize.x,
            height: gameSize.y,
          ),
          gravity: Vector2(0, 9.8),
        );

  @override
  Future<void> onLoad() async {
    camera.backdrop.add(Background());
    camera.viewport.add(GameUI());

    world.add(Floor());
    player = Player(context);

    world.add(player);
    final worldBounds = Rectangle.fromLTRB(
      worldSize.x / 2,
      -double.maxFinite,
      worldSize.x / 2,
      -worldSize.y / 2,
    );
    camera.follow(player);
    camera.setBounds(worldBounds);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (state == GameState.running) {
      if (generatedWorldHeight > player.body.position.y - worldSize.y / 1.15) {
        generateNextSectionOfWorld();
        checkForGrayPlatform();
      }

      
      final heroY = (player.body.position.y - worldSize.y) * -1;

      if (score < heroY) {
        score = heroY.toInt();
      }

      if (score - 7 > heroY) {
        player.hit();
      }

      if (player.state == HeroState.dead) {
        state = GameState.gameOver;
        HighScores.saveNewScore(context ,score);
        overlays.add('GameOverMenu');
      }
    }
  }

  bool isOutOfScreen(Vector2 position) {
    final heroY = (player.body.position.y - worldSize.y) * -1;
    final otherY = (position.y - worldSize.y) * -1;

    return otherY < heroY - worldSize.y / 2;
  }

  void generateNextSectionOfWorld() {
    const double platformHeight = 1.0; // Adjust based on your platform height
  for (int i = 0; i < 10; i++) {
    Vector2 newPosition;
    do {
      newPosition = Vector2(
        worldSize.x * random.nextDouble(),
        generatedWorldHeight,
      );
    } while (isOverlapping(newPosition, platformHeight));

    world.add(Platform(
      x: newPosition.x,
      y: newPosition.y,
    ));

    if (random.nextDouble() < .2) {
      Vector2 newPosition2;
      do {
        newPosition2 = Vector2(
          worldSize.x * random.nextDouble(),
          generatedWorldHeight - 3 + (random.nextDouble() * 6),
        );
      } while (isOverlapping(newPosition2, platformHeight));

      world.add(Platform(
        x: newPosition2.x,
        y: newPosition2.y,
      ));
    }

    if (random.nextBool()) {
      world.add(HearthEnemy(
        x: worldSize.x * random.nextDouble(),
        y: generatedWorldHeight - 11,
      ));
    } 
      if (random.nextDouble() < .3) {
        world.add(PowerUp(
          x: worldSize.x * random.nextDouble(),
          y: generatedWorldHeight - 1.5,
        ));
        if (random.nextDouble() < 21.2) {
          addCoins();
        }
      }

      generatedWorldHeight -= 2.4;
    }

  }

  bool isOverlapping(Vector2 newPosition, double newPlatformHeight) {
  for (final component in world.children) {
    if (component is Platform) {
      final existingPosition = component.position;
      final existingHeight = Platform.size.y;

      if ((newPosition.y - newPlatformHeight / 2 < existingPosition.y + existingHeight / 2) &&
          (newPosition.y + newPlatformHeight / 2 > existingPosition.y - existingHeight / 2)) {
        return true;
      }      
    }
  }
  return false;
}

  void checkForGrayPlatform() {
    for (final component in world.children) {
      if (component is Platform) {
        if (component.type == PlatformType.gray) {
          world.add(Platform(x: 
           worldSize.x * random.nextDouble(),
            y: component.position.y,
          ),
          );
        }
      }
    }
  }

  void addBrokenPlatformPieces(var platform) {
    final x = platform.body.position.x;
    final y = platform.body.position.y;

    final leftSide = PlatformPieces(
      x: x - (PlatformPieces.size.x / 2),
      y: y,
      isLeftSide: true,
      type: platform.type,
    );

    final rightSide = PlatformPieces(
      x: x + (PlatformPieces.size.x / 2),
      y: y,
      isLeftSide: false,
      type: platform.type,
    );

    world.add(leftSide);
    world.add(rightSide);
  }

  void addCoins() {
    final rows = random.nextInt(8) + 1;
    final cols = random.nextInt(3) + 1;

    final x = (worldSize.x - (Coin.size.x * cols)) * random.nextDouble() +
        Coin.size.x / 2;

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row <= rows; row++) {
        world.add(Coin(
          x: x + (col * Coin.size.x),
          y: generatedWorldHeight + (row * Coin.size.y) - 2,
        ));
      }
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    player.fireBullet();
  }

  void addBullets() {
    bullets -= 3;
    if (bullets < 0) bullets = 0;
    if (bullets == 0) return;
    final x = player.body.position.x;
    final y = player.body.position.y;

    world.add(Bullet(x: x, y: y, accelX: 0));
  }

  @override
  void onRemove() {
    super.onRemove();
    player.cancelSensor();
  }

    @override
  void pauseEngine() {
    super.pauseEngine();
    player.saveGameState();
  }

  @override
  void onDetach() {
    super.onDetach();
    player.saveGameState();
  }
}
