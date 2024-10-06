import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomImages {
  static const String _assetPath = 'assets';

  static final SvgPicture homeImageActive = SvgPicture.asset(
      '$_assetPath/icons/home.svg',
      key: Key('homeImageActive'),
      color: Color(0xFF7437FF));

  static final SvgPicture homeImage = SvgPicture.asset(
    '$_assetPath/icons/home.svg',
    key: Key('homeImage'),
    color: Color(0xFF666666),
  );

  static final SvgPicture mapImageActive = SvgPicture.asset(
      '$_assetPath/icons/map.svg',
      key: Key('mapImageActive'),
      color: Color(0xFF7437FF));

  static final SvgPicture mapImage = SvgPicture.asset(
    '$_assetPath/icons/map.svg',
    key: Key('mapImage'),
    color: Color(0xFF666666),
  );

  static final SvgPicture chatImageActive = SvgPicture.asset(
      '$_assetPath/icons/chat.svg',
      key: Key('chatImageActive'),
      color: Color(0xFF7437FF));

  static final SvgPicture chatImage = SvgPicture.asset(
    '$_assetPath/icons/chat.svg',
    key: Key('chatImage'),
    color: Color(0xFF666666),
  );

  static final SvgPicture menuImageActive = SvgPicture.asset(
      '$_assetPath/icons/menu.svg',
      key: Key('menuImageActive'),
      color: Color(0xFF7437FF));

  static final SvgPicture menuImage = SvgPicture.asset(
    '$_assetPath/icons/menu.svg',
    key: Key('menuImage'),
    color: Color(0xFF666666),
  );

  static final SvgPicture closeIcon = SvgPicture.asset(
    '$_assetPath/icons/close.svg',
    width: 24,
    height: 24,
  );
}
