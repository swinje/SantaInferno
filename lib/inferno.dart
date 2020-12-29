import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:santa_inferno/components/background.dart';
import 'package:santa_inferno/views/homeview.dart';
import 'package:santa_inferno/views/lostview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:santa_inferno/components/spaceship.dart';
import 'package:santa_inferno/components/start-button.dart';
import 'package:santa_inferno/components/button.dart';
import 'package:santa_inferno/components/bullet.dart';
import 'dart:math';
import 'package:santa_inferno/components/object.dart';
import 'package:santa_inferno/components/santa.dart';
import 'package:santa_inferno/components/present.dart';
import 'package:santa_inferno/controllers/spawner.dart';
import 'package:santa_inferno/controllers/joystick.dart';
import 'package:santa_inferno/components/score-display.dart';
import 'package:santa_inferno/components/highscore-display.dart';


class Inferno extends Game with PanDetector {
  Spaceship spaceShip;
  Size screenSize;
  double tileSize;
  Background background;
  HomeView homeView;
  LostView lostView;
  final SharedPreferences storage;
  Random rnd;

  StartButton startButton;
  Button button;
  List<Bullet> bullets;

  List<Object> objects;
  Spawner spawner;

  Joystick joystick;

  bool playing = false;
  bool lost = false;
  int score = 0;
  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;

  Inferno(this.storage) {
    initialize();
  }

  void initialize() async {
    rnd = Random();
    objects = List<Object>();
    resize(await Flame.util.initialDimensions());
    startButton = StartButton(this);
    joystick = Joystick(this);
    spawner = Spawner(this);
    background = Background(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    spaceShip = Spaceship(this);
    button = Button(this);
    bullets = List<Bullet>();
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);
  }


  void render(Canvas canvas) {
    background.render(canvas);
    if(playing) {
      spaceShip.render(canvas);
      button.render(canvas);
      joystick.render(canvas);
      bullets.forEach((Bullet b) => b.render(canvas));
      objects.forEach((Object obj) => obj.render(canvas));
      scoreDisplay.render(canvas);
      highscoreDisplay.render(canvas);
    }
    else {
      startButton.render(canvas);
      if(!lost)
        homeView.render(canvas);
      else
        lostView.render(canvas);
    }
  }

  void update(double t) {
    bullets.forEach((Bullet b) => b.update(t));
    bullets.removeWhere((Bullet b) => b.fired==false);
    joystick.update(t);
    objects.forEach((Object obj) => obj.update(t));
    objects.removeWhere((Object obj) => obj.isOffScreen);
    if(playing) {
      spawner.update(t);
      scoreDisplay.update(t);
      if(lost)
        lostView.update(t);
    }
  }

  void onTapDown(TapDownDetails details) {

    if (button.rect.contains(details.globalPosition)) {
      if(bullets.length <= 5)
        bullets.add(Bullet(this,spaceShip.flyRect,spaceShip.lastMoveRadAngle));
    }

    // start button
    if (!playing && startButton.rect.contains(details.globalPosition)) {
        startButton.onTapDown();
    }

  }

  void onPanStart(DragStartDetails details) {
    joystick.onPanStart(details);
  }

  void onPanUpdate(DragUpdateDetails details) {
    joystick.onPanUpdate(details);
  }

  void onPanEnd(DragEndDetails details) {
    joystick.onPanEnd(details);
  }


  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void spawn() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 1.35));
    double y = (rnd.nextDouble() *
        (screenSize.height - (tileSize * 7)));

    switch (rnd.nextInt(2)) {
      case 0:
        objects.add(Santa(this, x, y));
        break;
      case 1:
        objects.add(Present(this, x, y));
        break;

    }
  }

}