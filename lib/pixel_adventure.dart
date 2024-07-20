import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import '../components/player.dart';
import '../components/level.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showJoystick = false;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    final world = Level(
      player: player,
      levelName: 'Level-02'
    );

    cam = CameraComponent.withFixedResolution(world: world, width: 680, height: 400);
    cam.viewfinder.anchor = Anchor.topLeft;
    cam.priority = 0;
    // Add the camera and world components first
    addAll([cam, world]);
    if (showJoystick) {
      addJoystick();
    }
    addJoystick();
    // Add the joystick after the camera and world

    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 20, bottom: 20), // Adjusted margin for better visibility
    );
    // Set a very high priority layer for the joystick
    joystick.priority = 9999; 
    add(joystick);
  }

  

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        // player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        // player.playerDirection = PlayerDirection.right;
        break;
      default:
        // player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
