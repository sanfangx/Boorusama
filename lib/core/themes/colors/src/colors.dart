// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kurumi/kurumi.dart';

const kLightWhiteColor = KurumiColorTokens.lightWhite;
const kDimWhiteColor = KurumiColorTokens.dimWhite;

// AMOLED Dark theme
const kPrimaryAmoledDarkColor = KurumiColorTokens.primaryAmoledDark;
const kOnPrimaryAmoledDarkColor = KurumiColorTokens.onPrimaryAmoledDark;
const kErrorAmoledDarkColor = KurumiColorTokens.errorAmoledDark;
const kOnErrorAmoledDarkColor = KurumiColorTokens.onErrorAmoledDark;
const kHintAmoledDarkColor = KurumiColorTokens.hintAmoledDark;

// Dark theme
const kPrimaryDarkColor = KurumiColorTokens.primaryDark;
const kOnPrimaryDarkColor = KurumiColorTokens.onPrimaryDark;
const kErrorDarkColor = KurumiColorTokens.errorDark;
const kOnErrorDarkColor = KurumiColorTokens.onErrorDark;
const kIconDarkColor = KurumiColorTokens.iconDark;

// Light theme
const kPrimaryLightColor = KurumiColorTokens.primaryLight;
const kOnPrimaryLightColor = KurumiColorTokens.onPrimaryLight;
const kOnBackgroundLightColor = KurumiColorTokens.onBackgroundLight;
const kOnSurfaceLightColor = KurumiColorTokens.onSurfaceLight;
const kErrorLightColor = KurumiColorTokens.errorLight;
const kOnErrorLightColor = KurumiColorTokens.onErrorLight;
const kHintLightColor = KurumiColorTokens.hintLight;

class BoorusamaColors extends ThemeExtension<BoorusamaColors> {
  const BoorusamaColors({
    required this.upvoteColor,
    required this.downvoteColor,
  });

  final Color upvoteColor;
  final Color downvoteColor;

  @override
  ThemeExtension<BoorusamaColors> copyWith({
    Color? upvoteColor,
    Color? downvoteColor,
  }) => BoorusamaColors(
    upvoteColor: upvoteColor ?? this.upvoteColor,
    downvoteColor: downvoteColor ?? this.downvoteColor,
  );

  @override
  ThemeExtension<BoorusamaColors> lerp(
    covariant ThemeExtension<BoorusamaColors>? other,
    double t,
  ) {
    if (other is! BoorusamaColors) return this;

    return BoorusamaColors(
      upvoteColor: Color.lerp(upvoteColor, other.upvoteColor, t) ?? upvoteColor,
      downvoteColor:
          Color.lerp(downvoteColor, other.downvoteColor, t) ?? downvoteColor,
    );
  }
}
