import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:santa_inferno/inferno.dart';
import 'package:flutter/material.dart';

class StartButton {
  final Inferno game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
    sprite = Sprite('start-button.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void onTapDown() {
    print("tap down");
    game.score = 0;
    game.playing = true;
    game.lost = false;
    game.spawn();
    game.spawner.start();
  }

}