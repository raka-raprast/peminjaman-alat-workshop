import 'dart:ui';

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

Color pureWhite() {
  return fromHex("#FFFFFF");
}

Color blue() {
  return fromHex("3669C9");
}

Color halfGrey() {
  return fromHex("#C4C5C4");
}

Color yellow() {
  return fromHex("FFC120");
}

Color lightBlue() {
  return fromHex("5885DA");
}

Color red() {
  return fromHex("FF0000");
}

Color deepOcean() {
  return fromHex("1E9FA7");
}
