// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';

// Project imports:
import '../../../config/providers.dart';

void guardLogin(WidgetRef ref, void Function() action) {
  final auth = ref.readConfigAuth;
  final loginDetails = ref.read(booruLoginDetailsProvider(auth));

  if (!loginDetails.hasLogin()) {
    Kurumi.showSimpleSnackBar(
      context: ref.context,
      content: Text(
        ref.context.t.post.detail.login_required_notice,
      ),
      duration: KurumiDurations.shortToast,
    );

    return;
  }

  action();
}

extension GuardLoginSnackBarX on WidgetRef {
  void showSuccessSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
  }) {
    Kurumi.showSuccessToast(
      context,
      message,
      backgroundColor: backgroundColor,
      duration: KurumiDurations.shortToast,
    );
  }
}
