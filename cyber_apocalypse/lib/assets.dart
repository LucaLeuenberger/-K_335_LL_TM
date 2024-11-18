import 'package:flame/components.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';

class Assets {
  static late final Sprite button;
  static late final Sprite buttonPause;
  static late final Sprite buttonBack;

  static late final Sprite background;

  static late final Sprite sonicFall;
  static late final Sprite sonicJump;

  static late final Sprite shadowFall;
  static late final Sprite shadowJump;

  static late final SpriteAnimation eggbot;
  static late final SpriteAnimation fireBubble;

  static late final Sprite coin;
  static late final Sprite gun;
  static late final Sprite chaosspear;
  static late final Sprite spring;
  static late final Sprite bubbleSmall;
  static late final Sprite chaosemeralds;
  static late final Sprite shield;

  static late final Sprite supperSonic;
  static late final Sprite supperShadow;

  static late final Sprite StreetPlatform;
  static late final Sprite StreetPlatformBreaking;
  static late final Sprite StreetPlatformBroken;
  
  static late final Sprite SandPlatform;
  static late final Sprite SandPlatformBreaking;
  static late final Sprite SandPlatformBroken;

  static late final Sprite SpikePlatform;

  static late final Sprite GrassPlatform;
  static late final Sprite GrassPlatformBreaking;
  static late final Sprite GrassPlatformBroken;

  static late final Sprite SpringPlatform;

  static Future<void> load() async {
    final atlas = await TexturePackerAtlas.load('atlasMap.atlas');
    final atlas2 = await TexturePackerAtlas.load('atlasMap2.atlas');
    button = atlas.findSpriteByName('button')!;
    buttonPause = atlas.findSpriteByName('buttonPause')!;
    buttonBack = atlas.findSpriteByName('buttonBack')!;
    background = atlas.findSpriteByName('background')!;

    sonicFall = atlas2.findSpriteByName('SonicFall')!;
    sonicJump = atlas2.findSpriteByName('SonicJump')!;

    shadowFall = atlas2.findSpriteByName('ShadowFall')!;
    shadowJump = atlas2.findSpriteByName('ShadowJump')!;

    final enemy1 = atlas2.findSpriteByName('EggbotRight')!;
    final enemy2 = atlas2.findSpriteByName('EggbotLeft')!;

    eggbot = SpriteAnimation.spriteList([
      enemy1,
      enemy2,
    ], stepTime: 1, loop: true);

    coin = atlas2.findSpriteByName('Rings')!;
    gun = atlas.findSpriteByName('Pistol')!;
    chaosspear = atlas2.findSpriteByName('ChaosSpear')!;
    spring = atlas.findSpriteByName('Spring')!;
    bubbleSmall = atlas.findSpriteByName('Bubble_Small')!;
    chaosemeralds = atlas2.findSpriteByName('ChaosEmeralds')!;
    shield = atlas.findSpriteByName('Bubble_Big')!;
  
    supperSonic = atlas2.findSpriteByName('SupperSonic')!;
    supperShadow = atlas2.findSpriteByName('SupperShadow')!;

    final fireBubble1 = atlas2.findSpriteByName('FireBubble1')!;
    final fireBubble2 = atlas2.findSpriteByName('FireBubble2')!;
    final fireBubble3 = atlas2.findSpriteByName('FireBubble3')!;

    fireBubble = SpriteAnimation.spriteList([
      fireBubble1,
      fireBubble2,
      fireBubble3,
    ], stepTime: 0.15, loop: true);

    StreetPlatform = atlas2.findSpriteByName('StreetplatformNormal')!;
    StreetPlatformBreaking = atlas2.findSpriteByName('StreetplatformBreaking')!;
    StreetPlatformBroken = atlas2.findSpriteByName('StreetplatformBroken')!;

    SandPlatform = atlas2.findSpriteByName('SandPlatformNormal')!;
    SandPlatformBreaking = atlas2.findSpriteByName('SandPlatformBreaking')!;
    SandPlatformBroken = atlas2.findSpriteByName('SandPlatformBroken')!;

    SpikePlatform = atlas2.findSpriteByName('PlatformTrapGreen')!;

    GrassPlatform = atlas2.findSpriteByName('PlatformNormalGreen')!;
    GrassPlatformBreaking = atlas2.findSpriteByName('GreenplatformBreaking')!; 
    GrassPlatformBroken = atlas2.findSpriteByName('GreenplatformBroken')!;


    SpringPlatform = atlas2.findSpriteByName('PlatformSpringGreen')!;
  }
}
