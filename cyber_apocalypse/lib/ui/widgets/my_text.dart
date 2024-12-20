import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;

  const MyText(
    this.text, {
    super.key,
    this.fontSize = 28,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? Colors.white,
        fontWeight: FontWeight.w800,
        fontFamily: 'DaveysDoodleface',
      ),
    );
  }
}
