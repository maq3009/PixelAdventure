import 'dart:async';
import 'package:pixel_adventures/pixel_adventure.dart';
import 'package:flame/components.dart';

class BackgroundTile extends SpriteComponent  with HasGameRef<PixelAdventure>{
 final String color;
 BackgroundTile({
    this.color = 'Gray',
    super.position,
  });

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    size = Vector2.all(64);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));
    return super.onLoad();
  } 
}