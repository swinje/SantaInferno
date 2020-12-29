import 'package:flame/sprite.dart';
import 'package:santa_inferno/components/object.dart';
import 'package:santa_inferno/inferno.dart';
import 'dart:ui';

class Santa extends Object {
  Santa(Inferno game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('santa1.png'));
    flyingSprite.add(Sprite('santa2.png'));
    deadSprite = Sprite('santa_dead.png');
  }
}