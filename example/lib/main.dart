import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart' hide Animation;

AudioPool pool = AudioPool('fire_2.mp3', minPlayers: 3, maxPlayers: 4);

void main() async {
  runApp(GameWidget(game: AudioGame()));
}

/// This example game showcases three possible use cases:
///
/// 1. Use the static FlameAudio class to easily fire a sfx using the default
/// configs for the button tap.
/// 2. Uses a custom AudioPool for extremely efficient audio loading and pooling
/// for tapping elsewhere.
/// 3. Uses the Bgm utility for background music.
class AudioGame extends BaseGame with TapDetector {
  static Paint black = BasicPalette.black.paint;
  static Paint gray = PaletteEntry(Color(0xFFCCCCCC)).paint;
  static TextConfig text = TextConfig(color: BasicPalette.white.color);

  @override
  Future<void> onLoad() async {
    await pool.init();
    startBgmMusic();
  }

  Rect get button => Rect.fromLTWH(20, size.y - 300, size.x - 40, 200);

  void startBgmMusic() {
    FlameAudio.bgm.play('music/bg_music.ogg');
  }

  void fireOne() {
    FlameAudio.audioCache.play('sfx/fire_1.mp3');
  }

  void fireTwo() {
    pool.start();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), black);

    text.render(
      canvas,
      '(click anywhere for 1)',
      Vector2(size.x / 2, 200),
      anchor: Anchor.topCenter,
    );

    canvas.drawRect(button, gray);

    text.render(
      canvas,
      'click here for 2',
      Vector2(size.x / 2, size.y - 200),
      anchor: Anchor.bottomCenter,
    );
  }

  @override
  void onTapDown(TapDownDetails details) {
    if (button.contains(details.localPosition)) {
      fireTwo();
    } else {
      fireOne();
    }
  }
}
