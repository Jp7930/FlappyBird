import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  static const String id = 'gameOver';
  final FlappyBirdGame game;
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Score Text
            Text(
              'Score: ${game.bird.score}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: 'Game',
                // fontFamily: GoogleFonts.pressStart2p().fontFamily,
              ),
            ),
            Image.asset(Assets.gameOver),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                onRestart();
              },
              child: const Text(
                'Restart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Game',
                  // fontFamily: GoogleFonts.pressStart2p().fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onRestart() {
    game.bird.reset();
    game.overlays.remove(id);
    game.resumeEngine();
  }
}
