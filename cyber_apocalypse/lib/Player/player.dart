import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Player extends SpriteComponent with HasGameRef, KeyboardHandler {
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player.png');
    size = Vector2(50, 50);
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    // Add gravity and collision detection here
  }

  @override
  bool onKeyEvent(event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        velocity.x = -200;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        velocity.x = 200;
      }
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft || event.logicalKey == LogicalKeyboardKey.arrowRight) {
        velocity.x = 0;
      }
    }
    return true;
  }
}
