// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../premiums/routes.dart';
import '../../../premiums/types.dart';
import '../providers/bulk_download_notifier.dart';
import '../types/bulk_download_error.dart';
import '../types/bulk_download_error_code.dart';

class BulkDownloadErrorScope extends ConsumerWidget {
  const BulkDownloadErrorScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(bulkDownloadProvider.notifier);

    ref.listen(
      bulkDownloadProvider.select((state) => state.error),
      (previous, current) {
        if (previous == current || current is! BulkDownloadError) return;

        final isPremiumError = current.code.isPremiumError;
        Kurumi.showSimpleSnackBar(
          context: context,
          content: Text(switch (current.code) {
            BulkDownloadErrorCode.nonPremiumSavedTaskLimit =>
              context.t.bulk_downloads.errors.non_premium_template_limit(
                brand: kPremiumBrandName,
              ),
            BulkDownloadErrorCode.nonPremiumSessionLimit =>
              context.t.bulk_downloads.errors.non_premium_session_limit(
                brand: kPremiumBrandName,
              ),
            BulkDownloadErrorCode.nonPremiumResume =>
              context.t.bulk_downloads.errors.non_premium_resume(
                brand: kPremiumBrandName,
              ),
            BulkDownloadErrorCode.runningSessionDeletion =>
              context.t.bulk_downloads.errors.running_session_deletion,
            BulkDownloadErrorCode.nonPremiumSuspend =>
              context.t.bulk_downloads.errors.non_premium_suspend(
                brand: kPremiumBrandName,
              ),
            _ => current.message,
          }),
          action: isPremiumError
              ? SnackBarAction(
                  label: context.t.premium.upgrade,
                  textColor: Kurumi.themeOf(context).colorScheme.surface,
                  onPressed: () => goToPremiumPage(ref),
                )
              : null,
        );
        notifier.clearError();
      },
    );

    return child;
  }
}
