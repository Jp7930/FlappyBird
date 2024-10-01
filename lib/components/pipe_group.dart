import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flutter/material.dart';

import '../game/flappy_bird_game.dart';
import '../game/pipe_position.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final Random random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;
    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + random.nextDouble() * (heightMinusGround - spacing);
    addAll([
      Pipe(
        height: centerY - spacing / 2,
        pipePosition: PipePosition.top,
      ),
      Pipe(
        height: heightMinusGround - (centerY + spacing / 2),
        pipePosition: PipePosition.bottom,
      ),
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    // Remove the pipe group when it is out of the screen
    if (position.x < -10) {
      debugPrint('Pipe group removed');
      removeFromParent();
      updateScore();
      FlameAudio.play(Assets.point);
    }

    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  updateScore() {
    gameRef.bird.score++;
  }
}
