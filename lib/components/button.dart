import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:santa_inferno/inferno.dart';
import 'package:flutter/material.dart';

class Button  {
  final Inferno game;
  Rect rect;
  Sprite sprite;

  Button(this.game) {
    var radius = (game.tileSize * 2.5) / 2;

    Offset osBackground = Offset(
        game.screenSize.width - (radius + (radius * 3 / 4)),
        game.screenSize.height - (radius + (radius / 2))
    );
    rect = Rect.fromCircle(
        center: osBackground,
        radius: radius
    );

    sprite = Sprite('button.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  // update and render omitted



}