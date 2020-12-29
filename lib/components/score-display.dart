import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:santa_inferno/inferno.dart';

class ScoreDisplay {
  final Inferno game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  ScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.right,
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
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
      painter.text = TextSpan(
        text: game.score.toString(),
        style: textStyle,
      );

      painter.layout();

      position = Offset(
        (game.screenSize.width) - (painter.width+30),
        painter.height / 2,
      );
    }
}