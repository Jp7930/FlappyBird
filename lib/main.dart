import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game/flappy_bird_game.dart';
import 'screens/game_over_screen.dart';
import 'screens/main_menu_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Flame.device.fullScreen();
  Flame.device.setOrientations([DeviceOrientation.portraitUp]);
  final game = FlappyBirdGame();
  runApp(
    GameWidget(
      game: game,
      initialActiveOverlays: const [MainMenuScreen.id],
      overlayBuilderMap: {
        'mainMenu': (BuildContext context, FlappyBirdGame gameRef) =>
            MainMenuScreen(
              game: gameRef,
            ),
        'gameOver': (BuildContext context, FlappyBirdGame gameRef) =>
            GameOverScreen(
              game: gameRef,
            ),
      },
    ),
  );
}
