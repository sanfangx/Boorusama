// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kurumi/kurumi.dart';

class BooruConfigSettingsHeader extends StatelessWidget {
  const BooruConfigSettingsHeader({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) => KurumiSettingsHeader(
    label: label,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
  );
}
