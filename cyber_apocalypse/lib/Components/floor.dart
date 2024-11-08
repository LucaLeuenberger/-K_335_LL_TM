import 'package:cyber_apocalypse/cyber_apocalypse.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Floor extends BodyComponent<CyberApocalypse> {
  @override
  void update(double dt) {
    super.update(dt);

    if (game.isOutOfScreen(body.position)) {
      world.destroyBody(body);
      world.remove(this);
    }
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
      type: BodyType.static,
    );

    final shape = EdgeShape()..set(Vector2.zero(), Vector2(worldSize.x, 0));
    final fixtureDef = FixtureDef(shape);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
