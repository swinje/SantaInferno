import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:santa_inferno/inferno.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:santa_inferno/controllers/AllowMultipleGestureRecognizer.dart';

SharedPreferences storage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  storage = await SharedPreferences.getInstance();

  // Force portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown
  ]);

  // Hide status bar
  await SystemChrome.setEnabledSystemUIOverlays([]);

  Flame.images.loadAll(<String>[
    'space2.png',
    'button.png',
    'santa1.png',
    'santa2.png',
    'santa_dead.png',
    'tree.png',
    'present1.png',
    'present2.png',
    'present_dead.png',
    'elf.png',
    'joystick_knob.png',
    'joystick_background.png',
    'title.png',
    'start-button.png',
    'lose-splash.png'
  ]);


  /*Flame.audio.loadAll([
  ]);*/

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);


  runApp(GameApp());
}

class GameApp extends StatelessWidget {
  final Inferno game = Inferno(storage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: RawGestureDetector(
            gestures: {
              AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                  AllowMultipleGestureRecognizer>(
                    () => AllowMultipleGestureRecognizer(), //constructor
                    (AllowMultipleGestureRecognizer instance) { //initializer
                  instance.onTapDown = (TapDownDetails details) => game.onTapDown(details);
                },
              )
            },
            child: game.widget
        ),
      ),
    );
  }
}



