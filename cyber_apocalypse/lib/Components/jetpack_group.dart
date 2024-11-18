import 'package:cyber_apocalypse/assets.dart';
import 'package:cyber_apocalypse/provider/character_provider.dart';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';



class JetpackGroup extends PositionComponent {
  static Vector2 jetpackSize = Vector2(.40, .65);
  static Vector2 fireSize = Vector2(.75, .9);

  final BuildContext context;
  bool isSonic = false;
  late SpriteAnimationComponent fireComponent;

  late final CharacterProvider characterProvider;
  
  JetpackGroup(this.context) {
    characterProvider = Provider.of<CharacterProvider>(context, listen: false);
     fireComponent = SpriteAnimationComponent(
      animation: Assets.fireBubble.clone(),
      size: fireSize,
      anchor: Anchor.center,
    );
    fireComponent.opacity = 0.5; // Set the opacity to 0.5
    add(fireComponent);
  }
  

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    isSonic = characterProvider.isSonic;

    priority = 2;
    add(
      SpriteComponent(
        sprite: isSonic ? Assets.supperSonic : Assets.supperShadow,
        size: jetpackSize,
        anchor: Anchor.center,
      ),
    );
  }
}
