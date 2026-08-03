// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kurumi/kurumi.dart';

// Project imports:
import '../../types.dart';

class PeriodToggleSwitch extends StatelessWidget {
  const PeriodToggleSwitch({
    required this.onToggle,
    super.key,
  });

  final void Function(MoebooruTimePeriod period) onToggle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: KurumiSegmentedButton(
        segments: {
          for (final entry in MoebooruTimePeriod.values) entry: entry.name,
        },
        initialValue: MoebooruTimePeriod.day,
        onChanged: (value) => onToggle(value),
      ),
    );
  }
}
