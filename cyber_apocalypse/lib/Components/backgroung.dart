import 'package:flutter/material.dart';
import 'package:cyber_apocalypse/cyber_apocalypse.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef<CyberApocalypse> {
  Background() : super(size: gameSize);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('../ui/background2.png');
  }
}