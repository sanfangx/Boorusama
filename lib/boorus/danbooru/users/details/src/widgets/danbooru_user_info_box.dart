// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foundation/foundation.dart';
import 'package:kurumi/kurumi.dart';

// Project imports:
import '../../../../../../core/themes/colors/providers.dart';
import '../../../../../../core/users/widgets.dart';
import '../../../user/providers.dart';
import '../types/user_details.dart';

class DanbooruUserInfoBox extends ConsumerWidget {
  const DanbooruUserInfoBox({
    required this.user,
    super.key,
    this.loading,
  });

  final UserDetails user;
  final bool? loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userColor = DanbooruUserColor.of(context);
    final theme = Kurumi.themeOf(context);
    final colors = ref
        .watch(booruChipColorsProvider)
        .fromColor(
          userColor.fromLevel(user.level),
        );

    return UserInfoBox(
      loading: loading,
      username: UserInfoNameText(
        name: user.name ?? 'Unknown',
        color: theme.brightness.isLight
            ? userColor.fromLevel(user.level)
            : colors?.foregroundColor,
      ),
      userLevel: KurumiSelectableChip(
        tapEnabled: false,
        label: Text(
          user.level?.name.sentenceCase ?? 'Unknown',
          style: TextStyle(
            color: colors?.foregroundColor,
          ),
        ),
        backgroundColor: colors?.backgroundColor,
      ),
      joinedDate: user.joinedDate,
    );
  }
}
