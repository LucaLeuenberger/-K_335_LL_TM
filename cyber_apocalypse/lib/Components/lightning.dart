import 'package:cyber_apocalypse/assets.dart';
import 'package:cyber_apocalypse/cyber_apocalypse.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Lightning extends BodyComponent<CyberApocalypse> {
  static Vector2 size = Vector2(.28, 1.02);

  Vector2 _position;

  Lightning({
    required double x,
    required double y,
  }) : _position = Vector2(x, y);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;

    add(
      SpriteAnimationComponent(
        anchor: Anchor.center,
        size: size,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    _position = body.position;

    bool isOutOfScreen = game.isOutOfScreen(body.position);
    
    if (isOutOfScreen) {
      world.destroyBody(body);
      world.remove(this);
    }
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: _position,
      type: BodyType.kinematic,
    );

    final shape = PolygonShape()..setAsBoxXY(.14, .5);
    final fixtureDef = FixtureDef(shape)..isSensor = true;
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef)
      ..linearVelocity = Vector2(0, 3);
  }
}
