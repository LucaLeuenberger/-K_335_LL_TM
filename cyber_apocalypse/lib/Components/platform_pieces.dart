import 'package:cyber_apocalypse/cyber_apocalypse.dart';
import 'package:cyber_apocalypse/Components/platform.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:cyber_apocalypse/assets.dart';


class PlatformPieces extends BodyComponent<CyberApocalypse> {
  static Vector2 size = Vector2(.62, .5);
  final bool isLeftSide;
  final Vector2 _position;
  final PlatformType type;

  PlatformPieces({
    required double x,
    required double y,
    required this.isLeftSide,
    required this.type,
  }) : _position = Vector2(x, y);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    late Sprite sprite;

    switch (type) {
       case PlatformType.beigeBroken:
          sprite = Assets.platformBeigeLight;
        break;
      case PlatformType.blueBroken:
        sprite = Assets.platformBlueLight;
        break;
      case PlatformType.greenBroken:
        sprite = Assets.platformGreenLight;
        break;
      default:
        throw ('Wrong platform type exception');
    }

    add(
      SpriteComponent(
        sprite: sprite,
        size: size,
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

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
      type: BodyType.dynamic,
    );

    final angularVelocity = isLeftSide ? radians(100) : radians(-100);

    final shape = PolygonShape()..setAsBoxXY(.2, .11);
    final fixtureDef = FixtureDef(shape)
      ..isSensor = true
      ..density = 20;
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef)
      ..angularVelocity = angularVelocity;
  }
}
