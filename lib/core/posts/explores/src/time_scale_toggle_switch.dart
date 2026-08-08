// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import 'types.dart';

class TimeScaleToggleSwitch extends StatelessWidget {
  const TimeScaleToggleSwitch({
    required this.onToggle,
    this.initialValue = TimeScale.day,
    super.key,
  });

  final TimeScale initialValue;
  final void Function(TimeScale category) onToggle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: KurumiSegmentedButton(
        segments: {
          for (final entry in TimeScale.values)
            entry: _timeScaleToString(context, entry),
        },
        initialValue: initialValue,
        onChanged: (value) => onToggle(value),
      ),
    );
  }
}

String _timeScaleToString(BuildContext context, TimeScale scale) =>
    switch (scale) {
      TimeScale.month => context.t.dateRange.month,
      TimeScale.week => context.t.dateRange.week,
      TimeScale.day => context.t.dateRange.day,
    };
