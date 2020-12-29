import 'dart:ui';
import 'package:santa_inferno/inferno.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';


class Spaceship {
  final Inferno game;
  Rect flyRect;
  Sprite flyingShip;

  bool move = false;
  double lastMoveRadAngle = 0.0;
  double speed = 40.0;

  Spaceship(this.game) {
    flyingShip = Sprite('tree.png');
    flyRect = Rect.fromLTWH(
      game.screenSize.width/2 - 50,
      game.screenSize.height -200,
      game.tileSize*2,
      game.tileSize*2,
    );
  }

  void render(Canvas c) {
      c.save();
      c.translate(flyRect.center.dx, flyRect.center.dy);
      c.rotate(lastMoveRadAngle == 0.0
          ? 0.0
          : lastMoveRadAngle + (pi / 2));
      c.translate(-flyRect.center.dx, -flyRect.center.dy);
      flyingShip.renderRect(c, flyRect);
      c.restore();
  }

  void update(double t) {
    if (move) {
      double nextX = (speed * t) * cos(lastMoveRadAngle);
      double nextY = (speed * t) * sin(lastMoveRadAngle);
      Offset nextPoint = Offset(nextX, nextY);

      Offset diffBase = Offset(
          flyRect.center.dx + nextPoint.dx,
          flyRect.center.dy + nextPoint.dy) - flyRect.center;
      flyRect = flyRect.shift(diffBase);
    }
  }



}

