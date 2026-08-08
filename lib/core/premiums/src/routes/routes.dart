// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../../foundation/boot/providers.dart';
import '../../../router.dart';
import '../pages/premium_page.dart';

export 'route_utils.dart';

GoRoute premiumRoutes(Ref ref) => GoRoute(
  path: 'premium',
  name: '/premium',
  redirect: (context, state) {
    // Redirect to donation page if foss build
    if (ref.read(isFossBuildProvider)) {
      return '/donate';
    }
    return null;
  },
  pageBuilder: largeScreenAwarePageBuilder(
    useDialog: true,
    builder: (context, state) {
      final landscape = context.orientation.isLandscape;

      const page = PremiumPage();

      return landscape
          ? const KurumiDialog(
              padding: EdgeInsets.all(8),
              child: page,
            )
          : page;
    },
  ),
);
