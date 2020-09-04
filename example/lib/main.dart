import 'package:flame/game.dart';
import 'package:flutter/widgets.dart' hide Animation;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AudioGame game = AudioGame();
  runApp(game.widget);
}

class AudioGame extends BaseGame {}
