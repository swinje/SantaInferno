import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:santa_inferno/inferno.dart';

class HomeView {
  final Inferno game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
      game.tileSize/2  - game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 6),
      game.tileSize * 9,
      game.tileSize * 7,
    );
    titleSprite = Sprite('title.png');

  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {}
}