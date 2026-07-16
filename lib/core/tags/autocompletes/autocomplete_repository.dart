// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import '../../../foundation/debugs/print.dart';
import 'translation.dart';
import 'types.dart';

abstract class AutocompleteRepository {
  Future<List<AutocompleteData>> getAutocomplete(AutocompleteQuery query);
}

class AutocompleteRepositoryBuilder
    with DebugPrintMixin
    implements AutocompleteRepository {
  AutocompleteRepositoryBuilder({
    required this.autocomplete,
  });

  final Future<List<AutocompleteData>> Function(AutocompleteQuery query)
  autocomplete;

  @override
  Future<List<AutocompleteData>> getAutocomplete(
    AutocompleteQuery query,
  ) async {
    if (query.text.isEmpty) {
      printDebug('Query text is empty, returning empty list');
      return Future.value([]);
    }

    // Check if query text contains Chinese characters
    final hasChinese = RegExp(r'[\u4e00-\u9fa5]').hasMatch(query.text);
    if (hasChinese) {
      final matches = TagTranslation.searchChinese(query.text);
      if (matches.length >= 20) {
        return matches + [const AutocompleteData(label: '__more__', value: '__more__')];
      }
      return matches;
    }

    final fresh = await autocomplete(query);

    return fresh;
  }

  @override
  bool get debugPrintEnabled => kDebugMode;

  @override
  String get debugTargetName => 'Autocomplete Builder';
}

class EmptyAutocompleteRepository implements AutocompleteRepository {
  @override
  Future<List<AutocompleteData>> getAutocomplete(AutocompleteQuery query) {
    return Future.value([]);
  }
}
