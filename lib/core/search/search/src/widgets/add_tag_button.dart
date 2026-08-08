// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddTagButton extends StatelessWidget {
  const AddTagButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 4),
      child: KurumiCircularIconButton(
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        onPressed: onPressed,
        icon: const Icon(
          Symbols.add,
          size: 28,
        ),
      ),
    );
  }
}
