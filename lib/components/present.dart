import 'package:flame/sprite.dart';
import 'package:santa_inferno/components/object.dart';
import 'package:santa_inferno/inferno.dart';
import 'dart:ui';

class Present extends Object {
  Present(Inferno game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * .5, game.tileSize * .5);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('present1.png'));
    flyingSprite.add(Sprite('present2.png'));
    deadSprite = Sprite('present_dead.png');
  }
}