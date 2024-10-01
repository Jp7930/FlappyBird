import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe_group.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flutter/material.dart';

import '../components/background.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late TextComponent scoreText;
  final interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  @override
  FutureOr<void> onLoad() {
    addAll(
      [
        Background(),
        Ground(),
        bird = Bird(),
        PipeGroup(),
        scoreText = buildScore(this),
      ],
    );

    interval.onTick = () => add(PipeGroup());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    scoreText.text = 'Score: ${bird.score}';
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }
}

TextComponent buildScore(FlappyBirdGame game) {
  return TextComponent(
    text: 'Score: 0',
    position: Vector2(game.size.x / 2, game.size.y / 2 * 0.2),
    anchor: Anchor.center,
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        fontFamily: 'Game',
      ),
    ),
  );
}
