import 'dart:ui';

enum CanteenColor {
  lime(Color(0xffA4C400)),
  emerald(Color(0xff008A00)),
  teal(Color(0xff00ABA9)),
  cobalt(Color(0xff0050EF)),
  violet(Color(0xffAA00FF)),
  magenta(Color(0xffD80073)),
  orange(Color(0xffFA6800)),
  amber(Color(0xffF0A30A)),
  olive(Color(0xff6D8764)),
  sienna(Color(0xffA0522D));

  final Color value;

  const CanteenColor(this.value);
}
