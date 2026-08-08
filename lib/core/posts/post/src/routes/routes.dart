// Package imports:
import 'package:kurumi/cupertino.dart';
import 'package:kurumi/kurumi.dart';

// Project imports:
import '../../../../router.dart';
import '../pages/original_image_page.dart';
import '../types/post.dart';

final originalImageRoutes = GoRoute(
  path: 'original_image_viewer',
  name: '/original_image_viewer',
  pageBuilder: (context, state) {
    final post = state.extra as Post?;

    if (post == null) {
      return const CupertinoPage(
        child: InvalidPage(message: 'Invalid post'),
      );
    }

    return CustomTransitionPage(
      key: state.pageKey,
      name: state.name,
      transitionsBuilder: Kurumi.fadeTransitionBuilder(),
      child: OriginalImagePage.post(post),
    );
  },
);
