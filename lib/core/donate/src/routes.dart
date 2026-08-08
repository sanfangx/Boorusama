// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../foundation/boot/providers.dart';
import '../../router.dart';
import 'donation_page.dart';

GoRoute donationRoutes(Ref ref) => GoRoute(
  path: 'donate',
  name: '/donate',
  redirect: (context, state) {
    // Redirect to premium page if not foss build
    if (!ref.read(isFossBuildProvider)) {
      return '/premium';
    }
    return null;
  },
  pageBuilder: largeScreenAwarePageBuilder(
    useDialog: true,
    builder: (context, state) {
      final landscape = context.orientation.isLandscape;

      const page = DonationPage();

      return landscape
          ? const KurumiDialog(
              padding: EdgeInsets.all(8),
              child: page,
            )
          : page;
    },
  ),
);
