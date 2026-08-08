// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../tag/types.dart';

class CategoryToggleSwitch extends StatelessWidget {
  const CategoryToggleSwitch({
    required this.onToggle,
    super.key,
  });

  final void Function(TagFilterCategory category) onToggle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: KurumiSegmentedButton(
        initialValue: TagFilterCategory.newest,
        fixedWidth: 120,
        segments: {
          TagFilterCategory.newest: context.t.explore.kNew,
          TagFilterCategory.popular: context.t.explore.popular,
        },
        onChanged: (value) => onToggle(value),
      ),
    );
  }
}
