import 'package:flutter/gestures.dart';


// To allow both joystick and button to "win"
class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    try {
      acceptGesture(pointer);
    }
    catch(e) {}
  }
}