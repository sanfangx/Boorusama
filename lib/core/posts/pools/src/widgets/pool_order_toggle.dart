// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../types/pool_details_order.dart';

class PoolOrderToggle extends StatelessWidget {
  const PoolOrderToggle({
    required this.value,
    required this.onChanged,
    super.key,
    this.fixedWidth = 120,
  });

  final PoolDetailsOrder value;
  final ValueChanged<PoolDetailsOrder> onChanged;
  final double fixedWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: KurumiSegmentedButton(
          initialValue: value,
          fixedWidth: fixedWidth,
          segments: {
            for (final order in PoolDetailsOrder.values)
              order: order.localize(context),
          },
          onChanged: onChanged,
        ),
      ),
    );
  }
}
