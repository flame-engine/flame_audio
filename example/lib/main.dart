import 'package:flame/anchor.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart' hide Animation;

AudioPool pool = AudioPool('fire_2.mp3', minPlayers: 3, maxPlayers: 4);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final size = await Flame.util.initialDimensions();
  await pool.init();

  final game = AudioGame(size);
  runApp(game.widget);
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

  AudioGame(Size size) {
    this.size = size;
    startBgmMusic();
  }

  Rect get button => Rect.fromLTWH(20, size.height - 300, size.width - 40, 200);

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
    canvas.drawRect(Offset.zero & size, black);

    text.render(
      canvas,
      '(click anywhere for 1)',
      Position(size.width / 2, 200),
      anchor: Anchor.topCenter,
    );

    canvas.drawRect(button, gray);

    text.render(
      canvas,
      'click here for 2',
      Position(size.width / 2, size.height - 200),
      anchor: Anchor.bottomCenter,
    );
  }

  @override
  void update(double t) {}

  @override
  void onTapDown(TapDownDetails details) {
    if (button.contains(details.localPosition)) {
      fireTwo();
    } else {
      fireOne();
    }
  }
}
