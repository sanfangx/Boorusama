// Package imports:
import 'package:kurumi/material.dart';
import 'package:selection_mode/selection_mode.dart';

class SelectionAppBarBuilder extends StatelessWidget
    implements PreferredSizeWidget {
  const SelectionAppBarBuilder({
    required this.builder,
    super.key,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
  });

  final PreferredSizeWidget Function(
    BuildContext context,
    SelectionModeController controller,
    bool isSelectionMode,
  )
  builder;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SelectionConsumer(
      builder: (context, controller, _) =>
          builder(context, controller, controller.isActive),
    );
  }
}
