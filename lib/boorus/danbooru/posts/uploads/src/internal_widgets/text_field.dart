// Package imports:
import 'package:anchor_ui/anchor_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foundation/foundation.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../../../../../../core/configs/config/providers.dart';
import '../../../../../../core/search/suggestions/providers.dart';
import '../../../../../../core/search/suggestions/widgets.dart';
import '../../../../../../core/tags/autocompletes/types.dart';
import '../pages/tag_edit_upload_text_controller.dart';

class TagEditUploadTextField extends ConsumerStatefulWidget {
  const TagEditUploadTextField({
    super.key,
    required this.textEditingController,
  });

  final TagEditUploadTextController textEditingController;

  @override
  ConsumerState<TagEditUploadTextField> createState() =>
      _TagEditUploadTextFieldState();
}

class _TagEditUploadTextFieldState
    extends ConsumerState<TagEditUploadTextField> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watchConfigAuth;

    return AnchorPopover(
      placement: Placement.top,
      triggerMode: AnchorTriggerMode.focus(
        focusNode: _focusNode,
      ),
      arrowShape: const NoArrow(),
      spacing: 4,
      backgroundColor: Kurumi.themeOf(context).colorScheme.surfaceContainer,
      overlayBuilder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: 200,
          maxWidth:
              AnchorData.of(context).geometry.childBounds?.width ??
              MediaQuery.widthOf(context),
        ),
        child: ValueListenableBuilder<String?>(
          valueListenable: widget.textEditingController.lastWordNotifier,
          builder: (context, lastQuery, child) {
            final tags = lastQuery != null
                ? ref.watch(suggestionProvider((config, lastQuery))).toIList()
                : <AutocompleteData>[].lock;

            return tags.isEmpty
                ? const SizedBox.shrink()
                : TagSuggestionItems(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    backgroundColor: Colors.transparent,
                    config: config,
                    dense: true,
                    tags: tags,
                    reverse: true,
                    onItemTap: (tag) {
                      widget.textEditingController.replaceLastWordWith(
                        tag.value,
                      );
                    },
                    currentQuery: lastQuery ?? '',
                  );
          },
        ),
      ),
      child: KurumiTextFormField(
        focusNode: _focusNode,
        controller: widget.textEditingController,
        autocorrect: false,
        maxLines: 4,
        minLines: 4,
        validator: (p0) => null,
      ),
    );
  }
}
