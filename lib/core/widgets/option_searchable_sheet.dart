// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// Project imports:

Future<T?> showOptionSearchableSheet<T extends Object>(
  BuildContext context, {
  required List<T> items,
  required String Function(T option) optionValueBuilder,
  String Function(T option)? optionSheetValueBuilder,
  String? title,
}) {
  return Kurumi.showAdaptiveBottomSheet<T>(
    context,
    builder: (context) => OptionSearchableSheet<T>(
      title: title,
      items: items,
      scrollController: ModalScrollController.of(context),
      onFilter: (query) => items.where((element) {
        final value =
            optionSheetValueBuilder?.call(element) ??
            optionValueBuilder(element);

        return value.toLowerCase().contains(query.toLowerCase());
      }).toList(),
      itemBuilder: (context, option) => ListTile(
        minVerticalPadding: 4,
        title: Text(
          optionSheetValueBuilder?.call(option) ?? optionValueBuilder(option),
        ),
        onTap: () => Navigator.pop(context, option),
      ),
    ),
  );
}

class OptionSearchableSheet<T extends Object> extends StatelessWidget {
  const OptionSearchableSheet({
    required this.items,
    required this.onFilter,
    required this.itemBuilder,
    super.key,
    this.areItemsTheSame,
    this.title,
    this.scrollController,
  });

  final String? title;
  final List<T> items;
  final List<T> Function(String query) onFilter;
  final Widget Function(BuildContext context, T option) itemBuilder;
  final bool Function(T oldItem, T newItem)? areItemsTheSame;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return KurumiOptionSearchableSheet<T>(
      title: title,
      searchHint: context.t.search.hint,
      items: items,
      onFilter: onFilter,
      itemBuilder: itemBuilder,
      areItemsTheSame: areItemsTheSame,
      scrollController: scrollController,
    );
  }
}

class OptionSingleSearchableField<T extends Object> extends StatelessWidget {
  const OptionSingleSearchableField({
    required this.onSelect,
    required this.items,
    required this.optionValueBuilder,
    super.key,
    this.value,
    this.optionSheetValueBuilder,
    this.onTap,
    this.backgroundColor,
    this.sheetTitle,
    this.duration = const Duration(milliseconds: 300),
  });

  final T? value;
  final String? sheetTitle;
  final void Function(T? value) onSelect;
  final List<T> items;
  final String Function(T option) optionValueBuilder;
  final String Function(T option)? optionSheetValueBuilder;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return KurumiOptionSingleSearchableField<T>(
      value: value!,
      optionValueBuilder: optionValueBuilder,
      backgroundColor: backgroundColor,
      onTap:
          onTap ??
          () async {
            final option = await showOptionSearchableSheet<T>(
              context,
              title: sheetTitle,
              items: items,
              optionValueBuilder: optionValueBuilder,
              optionSheetValueBuilder: optionSheetValueBuilder,
            );
            if (option != null) onSelect(option);
          },
    );
  }
}
