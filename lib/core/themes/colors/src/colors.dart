// Package imports:
import 'package:kurumi/material.dart';

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

extension BoorusamaThemeDataX on ThemeData {
  /// Adds app-only vote colors while preserving Kurumi's theme extensions.
  ThemeData withBoorusamaColors({
    Color upvoteColor = Colors.redAccent,
    Color downvoteColor = Colors.blueAccent,
  }) {
    final existingExtensions = [
      for (final extension in extensions.values)
        if (extension is! BoorusamaColors) extension,
    ];

    return copyWith(
      extensions: [
        ...existingExtensions,
        BoorusamaColors(
          upvoteColor: upvoteColor,
          downvoteColor: downvoteColor,
        ),
      ],
    );
  }
}
