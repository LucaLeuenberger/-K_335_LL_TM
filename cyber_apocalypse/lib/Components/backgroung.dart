import 'package:cyber_apocalypse/assets.dart';
import 'package:cyber_apocalypse/cyber_apocalypse.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent {
  Background()
      : super(
          sprite: Assets.background,
          size: gameSize,
        );
}