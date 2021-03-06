import '../../debug.dart';
import '../../engine.dart';
import '../action/ray.dart';

class ConeMove extends Move {
  final Attack attack;
  int get range => attack.range;

  num get experience =>
      attack.damage * 3.0 * attack.element.experience * (1.0 + range / 10.0);

  ConeMove(num rate, this.attack) : super(rate);

  bool shouldUse(Monster monster) {
    var target = monster.game.hero.pos;

    // Don't fire if out of range.
    var toTarget = target - monster.pos;
    if (toTarget > range) {
      Debug.monsterLog(monster, "cone move too far");
      return false;
    }

    // TODO: Should minimize friendly fire.
    if (!monster.canView(target)) {
      Debug.monsterLog(monster, "cone move can't target");
      return false;
    }

    Debug.monsterLog(monster, "cone move OK");
    return true;
  }

  Action onGetAction(Monster monster) =>
      RayAction.cone(monster.pos, monster.game.hero.pos, attack.createHit());

  String toString() => "Cone $attack rate: $rate";
}
