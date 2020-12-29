import 'dart:ui';
import 'package:santa_inferno/inferno.dart';
import 'package:flame/sprite.dart';
import 'package:santa_inferno/components/bullet.dart';

class Object {
  final Inferno game;
  Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  double get speed => game.tileSize * 3;
  Offset targetLocation;

  Object(this.game) {
    setTargetLocation();
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(flyRect.width / 2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, flyRect.inflate(flyRect.width / 2));
    }
  }

  void update(double t) {
    if (!isDead) {
      game.bullets.forEach((Bullet b) {
        if (b.rect.contains(flyRect.bottomCenter)) {
          isDead = true;
          game.score++;
          if (game.score > (game.storage.getInt('highscore') ?? 0)) {
            game.storage.setInt('highscore', game.score);
            game.highscoreDisplay.updateHighscore();
          }
        }
      });
    }

    if (!isDead) {
      if (game.spaceShip.flyRect.contains(flyRect.bottomCenter)) {
        game.lost = true;
        game.playing = false;
      }
    }


    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }

    double stepDistance;
    switch (flyingSpriteIndex.toInt()) {
      case 0:
        stepDistance = speed * t;
        break;
      default:
        stepDistance = speed * t * 2;
        break;
    }

    Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      flyRect = flyRect.shift(stepToTarget);
    } else {
      flyRect = flyRect.shift(toTarget);
      setTargetLocation();
    }

    if (!isDead) {
      if (toTarget.dx < 0) {
        flyingSpriteIndex = 0;
      } else {
        flyingSpriteIndex = 1;
      }
    }
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 1.35));
    double y = (game.rnd.nextDouble() *
        (game.screenSize.height - (game.tileSize * 3)));
    targetLocation = Offset(x, y);
  }
}
