// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../router.dart';
import 'pages/metatag_list_page.dart';
import 'types/metatag.dart';

void goToMetatagsPage(
  BuildContext context, {
  required List<Metatag> metatags,
  required void Function(Metatag tag) onSelected,
}) {
  Kurumi.showAdaptiveBottomSheet(
    context,
    settings: const RouteSettings(
      name: RouterPageConstant.metatags,
    ),
    builder: (context) => MetatagListPage(
      metatags: metatags,
      onSelected: onSelected,
    ),
  );
}
