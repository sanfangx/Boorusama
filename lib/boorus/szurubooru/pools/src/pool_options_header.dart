// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import '../../../../core/widgets/widgets.dart';
import '../providers.dart';
import '../types.dart';

class SzurubooruPoolOptionsHeader extends ConsumerWidget {
  const SzurubooruPoolOptionsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(szurubooruPoolFilterProvider);
    final notifier = ref.watch(szurubooruPoolFilterProvider.notifier);

    return Container(
      color: Kurumi.themeOf(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ChoiceOptionSelectorList(
        icon: const Icon(Symbols.sort),
        options: SzurubooruPoolOrder.values,
        hasNullOption: false,
        optionLabelBuilder: (value) =>
            value != null ? value.localize(context) : 'All'.hc,
        sheetTitle: context.t.sort.sort_by,
        onSelected: (value) {
          notifier.setOrder(value ?? SzurubooruPoolOrder.latest);
        },
        selectedOption: order,
      ),
    );
  }
}
