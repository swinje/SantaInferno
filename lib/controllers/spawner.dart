import 'package:santa_inferno/inferno.dart';
import 'package:santa_inferno/components/object.dart';

class Spawner {
  final Inferno game;
  final int maxSpawnInterval = 4000;
  final int minSpawnInterval = 1000;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 10;
  int currentInterval;
  int nextSpawn;

  Spawner(this.game);

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.objects.forEach((Object obj) => obj.isDead = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingObjects = 0;
    game.objects.forEach((Object obj) {
      if (!obj.isDead) livingObjects += 1;
    });

    if (nowTimestamp >= nextSpawn && livingObjects < maxFliesOnScreen) {
      game.spawn();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}