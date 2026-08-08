// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../providers/local_providers.dart';
import '../types/upload_date_range.dart';

class UploadDateRangeSelectorButton extends ConsumerWidget {
  const UploadDateRangeSelectorButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KurumiOptionDropDownButton(
      alignment: AlignmentDirectional.centerStart,
      value: ref.watch(selectedUploadDateRangeSelectorTypeProvider),
      onChanged: (value) =>
          ref.read(selectedUploadDateRangeSelectorTypeProvider.notifier).state =
              value ?? UploadDateRange.last30Days,
      items: UploadDateRange.values
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(switch (value) {
                UploadDateRange.last7Days => context.t.time.filter.last_7_days,
                UploadDateRange.last30Days =>
                  context.t.time.filter.last_30_days,
                UploadDateRange.last3Months =>
                  context.t.time.filter.last_90_days,
                UploadDateRange.last6Months =>
                  context.t.time.filter.last_6_months,
                UploadDateRange.lastYear => context.t.time.filter.last_year,
              }),
            ),
          )
          .toList(),
    );
  }
}
