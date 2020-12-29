import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:santa_inferno/inferno.dart';

class HighscoreDisplay {
  final Inferno game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  HighscoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 40,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;

    updateHighscore();
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void updateHighscore() {
    int highscore = game.storage.getInt('highscore') ?? 0;

    painter.text = TextSpan(
      text: highscore.toString(),
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      (game.tileSize * .25) + painter.width,
      painter.height / 2,
    );
  }
}