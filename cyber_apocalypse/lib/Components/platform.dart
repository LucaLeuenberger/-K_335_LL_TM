import 'package:cyber_apocalypse/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:cyber_apocalypse/cyber_apocalypse.dart';

enum PlatformType {
   blue,
  blueLight,
  blueBroken,
  beige,
  beigeLight,
  beigeBroken, 
  gray,
  green,
  greenLight,
  greenBroken,
  pink,
}

extension PlatformTypeExtension on PlatformType {
  Sprite get sprite {
    switch (this) {
      case PlatformType.beige:
        return Assets.platformBeige;
      case PlatformType.blue:
        return Assets.platformBlue;
      case PlatformType.blueLight:
        return Assets.platformBlueLight;
      case PlatformType.beigeLight:
        return Assets.platformBeigeLight;
      case PlatformType.beigeBroken:
        return Assets.platformBeigeBroken;
      case PlatformType.blueBroken:
        return Assets.platformBlueBroken; 
      case PlatformType.gray:
        return Assets.platformGray; 
      case PlatformType.green:
        return Assets.platformGreen;
      case PlatformType.greenLight:
        return Assets.platformGreenLight;
      case PlatformType.greenBroken:
        return Assets.platformGreenBroken;
      case PlatformType.pink:
        return Assets.platformPink;
    }
  }

  bool get isBroken {
    switch (this) {
      case PlatformType.blueBroken:
      case PlatformType.beigeBroken: 
      case PlatformType.greenBroken:
        return true;
      default:
        return false;
    }
  }
}

class Platform extends BodyComponent<CyberApocalypse> {
  static Vector2 size = Vector2(1.2, .5);
  final Vector2 _position;
  bool destroy = false;

  final PlatformType type;

  Platform({
    required double x,
    required double y,
  })  : _position = Vector2(x, y),
        type = PlatformType.values
            .elementAt(random.nextInt(PlatformType.values.length));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;

    add(
      SpriteComponent(
        sprite: type.sprite,
        size: size,
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    bool isOutOfScreen = game.isOutOfScreen(body.position);

    if (destroy || isOutOfScreen) {
      world.destroyBody(body);
     if (type.isBroken) game.addBrokenPlatformPieces(this);
    }
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: _position,
      type: BodyType.static,
    );

    final shape = PolygonShape()..setAsBoxXY(.58, .23);
    final fixtureDef = FixtureDef(shape);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
