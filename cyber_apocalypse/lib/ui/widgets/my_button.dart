import 'package:cyber_apocalypse/ui/widgets/my_text.dart';
import 'package:cyber_apocalypse/assets.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton(
    this.text, {
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SpriteButton.future(
      sprite: Future.value(Assets.button),
      pressedSprite: Future.value(Assets.button),
      onPressed: onPressed,
      height: 50,
      width: 190,
      label: MyText(
        text,
        fontSize: 23,
        color: Colors.black,
      ),
    );
  }
}
