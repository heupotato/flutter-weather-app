import 'dart:ui';

class Palette {
  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
  static const blueGrey = Color(0xff272933);
  static const blue = Color(0xff7eaffc);
  static const transparent = Color(0x00000000);

  static const primary = blueGrey;
  static const secondary = blue;

  static const primaryText = white;
  static const secondaryText = blue;

  static Color primaryBackground = primary.withAlpha(200);
  static Color secondaryBackground = white.withAlpha(60);
  static Color separatorColor = Color(0xffaaaaaa);
}
