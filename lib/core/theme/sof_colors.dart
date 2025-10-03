import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/gen/colors.gen.dart';

@Deprecated('Use ColorName.* constants from lib/gen/colors.gen.dart instead.')
abstract class SOFColors {
  static const Color orange = ColorName.sofOrange;
  static const Color blue = ColorName.sofBlue;
  static const Color text = ColorName.sofText;
  static const Color muted = ColorName.sofMuted;
  static const Color border = ColorName.sofBorder;
  static const Color bg = ColorName.sofBg;
  static const Color tagBg = ColorName.sofTagBg;
  static const Color tagText = ColorName.sofTagText;

  static const Color success = ColorName.sofSuccess;
  static const Color danger = ColorName.sofDanger;

  static const Color badgeGold = ColorName.sofBadgeGold;
  static const Color badgeSilver = ColorName.sofBadgeSilver;
  static const Color badgeBronze = ColorName.sofBadgeBronze;
}
