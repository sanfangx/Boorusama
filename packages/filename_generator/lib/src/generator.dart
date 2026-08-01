// Package imports:
import 'package:clock/clock.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'parser.dart';
import 'token.dart';
import 'token_option.dart';

String generateFileName(
  Map<String, String?> metadata,
  String format, {
  Clock? clock,
  Uuid uuid = const Uuid(),
  TokenizerConfigs? configs,
}) {
  final cfg = configs ?? TokenizerConfigs.defaultConfigs();
  final tokens = parse(cfg, format);

  // filter null metadata
  final meta = {
    for (final entry in metadata.entries)
      if (entry.value != null) entry.key: entry.value,
  };

  final data = tokens
      .map(
        (e) => applyTokenOptions(
          meta[e.token.name] ?? '',
          TokenContext(
            token: e.token,
            config: cfg,
            options: filterDuplicatedOptions([
              ...parseTokenOptions(cfg.globalOptionToken, e.token.name, cfg),
              ...e.options,
            ]),
          ),
          clock: clock,
          uuid: uuid,
        ),
      )
      .toList();

  final fileName = fillArrayInString(cfg.tokenRegex, format, data);

  return fileName;
}

String applyTokenOptions(
  String data,
  TokenContext context, {
  Clock? clock,
  required Uuid uuid,
}) {
  final supportedOptions = context.options.where(
    (o) =>
        context.config.tokenDefinitions.containsKey(context.token.name) &&
        context.config.tokenDefinitions[context.token.name]!.contains(o.name),
  );

  // `nomod` operates on the original space-separated tag list. Applying it
  // after options such as `delimiter` or `maxlength` can collapse the entire
  // list at the first modifier or measure the uncleaned value, respectively.
  final orderedOptions = [
    ...supportedOptions.whereType<NoModifiersOption>(),
    ...supportedOptions.where((option) => option is! NoModifiersOption),
  ];

  return orderedOptions.fold(
    data,
    (data, option) => getTokenOptionHandler(
      data,
      option,
      clock: clock,
      uuid: uuid,
    )(context),
  );
}

List<TokenOption> filterDuplicatedOptions(List<TokenOption> options) {
  final m = <String, List<int>>{};

  for (var i = 0; i < options.length; i++) {
    final k = options[i].name;
    if (m.containsKey(k)) {
      m[k]!.add(i);
    } else {
      m[k] = [i];
    }
  }

  return m.values.map((e) => options[e.last]).toList();
}

String fillArrayInString(
  RegExp regex,
  String string,
  List<String> array,
) {
  var count = 0;

  return string.replaceAllMapped(
    regex,
    (match) {
      if (count < array.length) {
        final replacement = array[count];
        count++;
        return replacement;
      } else {
        return match.group(0)!;
      }
    },
  );
}

bool formatContainsAnyToken(
  String format,
  Iterable<String> tokens, {
  TokenizerConfigs? configs,
}) {
  final cfg = configs ?? TokenizerConfigs.defaultConfigs();
  final parsedTokens = parse(cfg, format);
  final presentTokens = parsedTokens.map((e) => e.token.name).toSet();

  return tokens.any((token) => presentTokens.contains(token));
}
