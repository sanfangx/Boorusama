// Package imports:
import 'package:kurumi/cupertino.dart';
import 'package:kurumi/kurumi.dart';

// Project imports:
import '../../../../../../core/router.dart';
import '../pages/user_feedback_page.dart';

final danbooruUserFeedbackRoutes = GoRoute(
  path: '/danbooru/user_feedbacks',
  name: 'user_feedbacks',
  pageBuilder: largeScreenAwarePageBuilder(
    useDialog: true,
    builder: (context, state) {
      final userId = int.tryParse(
        state.uri.queryParameters['search[user_id]'] ?? '',
      );

      final landscape = context.orientation.isLandscape;

      if (userId == null) {
        return const KurumiDialog(
          padding: EdgeInsets.all(8),
          child: InvalidPage(
            message: 'Invalid user ID',
          ),
        );
      }

      final page = UserFeedbackPage(userId: userId);

      return landscape
          ? KurumiDialog(
              padding: const EdgeInsets.all(8),
              child: page,
            )
          : page;
    },
  ),
);
