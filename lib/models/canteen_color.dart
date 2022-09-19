import 'dart:ui';

enum CanteenColor {
  pink(Color(0xfff368e0)),
  orange(Color(0xffff9f43)),
  red(Color(0xffee5253)),
  cyan(Color(0xff0abde3)),
  teal(Color(0xff10ac84)),
  aqua(Color(0xff00d2d3)),
  blue(Color(0xff54a0ff)),
  purple(Color(0xff5f27cd)),
  grey(Color(0xff576574));

  final Color value;

  const CanteenColor(this.value);
}
