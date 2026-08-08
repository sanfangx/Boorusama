// Package imports:
import 'package:intl/intl.dart';
import 'package:kurumi/material.dart';

const _kDefaultFormat = 'yyyy-MM-dd HH:mm:ss';

class DateTooltip extends StatelessWidget {
  const DateTooltip({
    required this.date,
    required this.child,
    super.key,
    this.format,
  });

  final DateTime date;
  final Widget child;
  final String? format;

  @override
  Widget build(BuildContext context) {
    final message = DateFormat(format ?? _kDefaultFormat).format(date);

    return Semantics(
      label: message,
      child: Tooltip(
        waitDuration: const Duration(milliseconds: 500),
        message: message,
        excludeFromSemantics: true,
        child: child,
      ),
    );
  }
}
