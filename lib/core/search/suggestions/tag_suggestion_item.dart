// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import '../../../foundation/html.dart';
import '../../configs/config/types.dart';
import '../../tags/autocompletes/types.dart';
import '../../tags/autocompletes/translation.dart';
import '../../tags/metatag/providers.dart';
import '../../tags/metatag/types.dart';
import '../../tags/tag/providers.dart';
import '../../themes/theme/types.dart';

class TagSuggestionItem extends StatelessWidget {
  const TagSuggestionItem({
    required this.onItemTap,
    required this.tag,
    required this.dense,
    required this.currentQuery,
    required this.textColor,
    required this.showCount,
    required this.metatagExtractor,
    super.key,
  });

  final ValueChanged<AutocompleteData> onItemTap;
  final AutocompleteData tag;
  final bool dense;
  final String currentQuery;
  final Color? textColor;
  final bool showCount;
  final MetatagExtractor? metatagExtractor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () => onItemTap(tag),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(bottom: 2),
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: dense ? 4 : 12,
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildTitle(),
            ),
            if (showCount)
              Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  NumberFormat.compact().format(tag.postCount),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.hintColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return AsynchronousTranslationHtml(
      tag: tag,
      currentQuery: currentQuery,
      metatagExtractor: metatagExtractor,
      textColor: textColor,
    );
  }
}

class AsynchronousTranslationHtml extends StatefulWidget {
  final AutocompleteData tag;
  final String currentQuery;
  final MetatagExtractor? metatagExtractor;
  final Color? textColor;

  const AsynchronousTranslationHtml({
    required this.tag,
    required this.currentQuery,
    required this.metatagExtractor,
    required this.textColor,
    super.key,
  });

  @override
  State<AsynchronousTranslationHtml> createState() => _AsynchronousTranslationHtmlState();
}

class _AsynchronousTranslationHtmlState extends State<AsynchronousTranslationHtml> {
  String? _translationLabel;
  String? _translationAntecedent;

  @override
  void initState() {
    super.initState();
    _loadTranslations();
  }

  void _loadTranslations() {
    Future.microtask(() {
      if (!mounted) return;
      final transLabel = TagTranslation.translate(widget.tag.label);
      final transAntecedent = widget.tag.antecedent != null 
          ? TagTranslation.translate(widget.tag.antecedent!) 
          : null;
      if (transLabel != null || transAntecedent != null) {
        setState(() {
          _translationLabel = transLabel;
          _translationAntecedent = transAntecedent;
        });
      }
    });
  }

  @override
  void didUpdateWidget(AsynchronousTranslationHtml oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tag != widget.tag || oldWidget.currentQuery != widget.currentQuery) {
      _loadTranslations();
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.tag.label;
    final antecedent = widget.tag.antecedent;
    final query = widget.currentQuery;
    final metatagExtractor = widget.metatagExtractor;

    final noOperatorQuery = (query.startsWith('-') || query.startsWith('~'))
        ? query.substring(1)
        : query;
    final rawQuery = noOperatorQuery.replaceAll('_', ' ').toLowerCase();
    final metatag = metatagExtractor?.fromString(query);
    final cleanQuery = metatag != null
        ? rawQuery.replaceFirst('$metatag:', '')
        : rawQuery;

    String replaceAndHighlight(String text) {
      return text.replaceAllMapped(
        RegExp(
          RegExp.escape(cleanQuery),
          caseSensitive: false,
        ),
        (match) => '<b>${match.group(0)}</b>',
      );
    }

    final displayLabel = _translationLabel != null ? '$label ($_translationLabel)' : label;

    String htmlData;
    if (widget.tag.hasAlias) {
      final displayAntecedent = _translationAntecedent != null ? '$antecedent ($_translationAntecedent)' : antecedent!;
      htmlData = '<p>${replaceAndHighlight(displayAntecedent.replaceAll('_', ' '))} ➞ ${replaceAndHighlight(displayLabel.replaceAll('_', ' '))}</p>';
    } else {
      htmlData = '<p>${replaceAndHighlight(displayLabel.replaceAll('_', ' '))}</p>';
    }

    return AppHtml(
      style: {
        'p': Style(
          fontSize: FontSize.medium,
          color: widget.textColor,
          margin: Margins.zero,
        ),
        'b': Style(
          fontWeight: FontWeight.w900,
        ),
      },
      selectable: false,
      data: htmlData,
    );
  }
}

class DefaultTagSuggestionItem extends ConsumerWidget {
  const DefaultTagSuggestionItem({
    required this.config,
    required this.tag,
    required this.onItemTap,
    required this.currentQuery,
    required this.dense,
    super.key,
  });

  final BooruConfigAuth config;
  final AutocompleteData tag;
  final ValueChanged<AutocompleteData> onItemTap;
  final String currentQuery;
  final bool dense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = tag.category;
    final color = category != null
        ? ref.watch(tagColorProvider((config, category)))
        : null;
    final metatagExtractor = ref.watch(metatagExtractorProvider(config));

    return TagSuggestionItem(
      key: ValueKey(tag.value),
      showCount: tag.hasCount,
      onItemTap: onItemTap,
      tag: tag,
      dense: dense,
      currentQuery: currentQuery,
      textColor: color,
      metatagExtractor: metatagExtractor,
    );
  }
}
