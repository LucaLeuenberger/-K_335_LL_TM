import 'dart:core';

import 'package:cyber_apocalypse/provider/character_provider.dart';
import 'package:cyber_apocalypse/ui/leaderboard_screen.dart';
import 'package:cyber_apocalypse/ui/main_menu_screen.dart';
import 'package:cyber_apocalypse/ui/neu_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:cyber_apocalypse/main.dart';
import 'package:provider/provider.dart';

enum Routes {
  main('/'),
  game('/game'),
  leaderboard('/leaderboard'),
  newgame('/newgame');

  final String route;

  const Routes(this.route);

  static Route routes(RouteSettings settings) {
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }


    final routeName = Routes.values.firstWhere((e) => e.route == settings.name);

    switch (routeName) {
      case Routes.main:
        return buildRoute(MainMenuScreen());
      case Routes.game:
        return buildRoute(const MyGameWidget());
      case Routes.leaderboard:
        return buildRoute(HighScoresScreen());
      case Routes.newgame:
        return buildRoute(NeuGameScreen());
      default:
        throw Exception('Route does not exists');
    }
  }
}

extension BuildContextExtension on BuildContext {
  void pushAndRemoveUntil(Routes route) {
    Navigator.pushNamedAndRemoveUntil(this, route.route, (route) => false);
  }

  void push(Routes route) {
    Navigator.pushNamed(this, route.route);
  }
}
