import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:santa_inferno/inferno.dart';
import 'dart:math';

class Bullet {
  final Inferno game;
  Rect rect;
  Sprite sprite;
  bool fired = true;
  double radAngle = 0.0;
  double speed = 300.0;
  bool isOffScreen = false;

  Bullet(this.game, Rect spaceShip, double rA) {
    sprite = Sprite('elf.png');
    radAngle = rA;
    rect = Rect.fromLTWH(
      game.screenSize.width/2- 30,
      game.screenSize.height - 180,
      spaceShip.width/2,
      spaceShip.height/2,
    );
  }

  void render(Canvas c) {
    if(fired) {
      c.save();
      c.translate(rect.center.dx, rect.center.dy);
      c.rotate(radAngle == 0.0 ? 0.0 : radAngle + (pi / 2));
      c.translate(-rect.center.dx, -rect.center.dy);
      sprite.renderRect(c, rect);
      c.restore();
    }
  }

  void update(double t) {
    if(fired) {
      if(radAngle==0.0)
        radAngle = -pi/2;
      double nextX = (speed * t) * cos(radAngle);
      double nextY = (speed * t) * sin(radAngle);
      Offset nextPoint = Offset(nextX, nextY);
      Offset toTarget = Offset(
          rect.center.dx + nextPoint.dx,
          rect.center.dy + nextPoint.dy) - rect.center;
      rect= rect.shift(toTarget);

      if (rect.top > game.screenSize.height || rect.bottom < 0 ||
          rect.right> game.screenSize.width || rect.left < 0) {
        fired = false;
      }
    }
  }


}