// Package imports:
import 'package:kurumi/cupertino.dart';
import 'package:kurumi/kurumi.dart';

// Project imports:
import '../../../foundation/display.dart';
import 'widgets/comment_side_sheet_container.dart';

Future<T?> showCommentPage<T>(
  BuildContext context, {
  required Widget Function(BuildContext context, bool useAppBar) builder,
  RouteSettings? settings,
}) => Screen.of(context).size == ScreenSize.small
    ? Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => builder(context, true),
        ),
      )
    : Kurumi.showSideSheetFromRight(
        settings: settings,
        width: MediaQuery.widthOf(context) * 0.41,
        body: CommentSideSheetContainer(
          builder: builder,
        ),
        context: context,
      );
