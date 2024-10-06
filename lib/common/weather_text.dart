import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherText extends ConsumerWidget {
  final String text;
  final bool underlined;
  TextStyle style = const TextStyle(height: 1.4);
  final Color color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? lineHeight;
  final bool strikeThrough;
  final int? maxLines;
  final double? letterSpacing;
  bool isTitle;

  WeatherText(
    this.text, {
    super.key,
    this.color = const Color(0xFF1F1F1F),
    required this.style,
    this.underlined = false,
    this.textAlign,
    this.overflow,
    this.lineHeight,
    this.strikeThrough = false,
    this.maxLines,
    this.letterSpacing,
    this.isTitle = false,
  });

  WeatherText.title(
    this.text, {
    super.key,
    double fontSize = 28,
    this.color = const Color(0xFF1F1F1F),
    FontWeight fontWeight = FontWeight.w400,
    this.underlined = false,
    this.textAlign,
    this.overflow,
    this.lineHeight,
    this.strikeThrough = false,
    this.maxLines,
    this.letterSpacing,
    this.isTitle = true,
  }){
    style = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      overflow: overflow,
      height: lineHeight,
      letterSpacing: letterSpacing,
    );
  }

  WeatherText.body(
    this.text, {
    super.key,
    double fontSize = 16,
    this.color = const Color(0xFF1F1F1F),
    this.underlined = false,
    FontWeight fontWeight = FontWeight.w400,
    this.textAlign,
    this.overflow,
    this.lineHeight,
    this.strikeThrough = false,
    this.maxLines,
    this.letterSpacing,
    this.isTitle = false,
  }) {
    style = TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      overflow: overflow,
      height: lineHeight,
      letterSpacing: letterSpacing,
    );
  }

  WeatherText.caption(
  this.text, {
  super.key,
  double fontSize = 12,
  this.color = const Color(0xFF1F1F1F),
  this.underlined = false,
  FontWeight fontWeight = FontWeight.w400,
  this.textAlign,
  this.overflow,
  this.lineHeight,
  this.strikeThrough = false,
  this.maxLines,
  this.letterSpacing,
  this.isTitle = false,
}) {
  style = TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    height: lineHeight,
    overflow: overflow,
    letterSpacing: letterSpacing,
  );
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Text(
      text,
      style: style.copyWith(
        overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
        fontFamily: 'Roboto',
        color: color,
        decoration: TextDecoration.combine([
          if (underlined) ...[TextDecoration.underline],
          if (strikeThrough) ...[TextDecoration.lineThrough]
        ]),
      ),
      strutStyle: StrutStyle(
        fontSize: style.fontSize,
        leading: style.height != null ? (style.height! / style.fontSize!) / 2 : null,
        forceStrutHeight: true,
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
