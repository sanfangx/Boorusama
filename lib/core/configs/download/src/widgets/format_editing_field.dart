// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

// Project imports:

class FormatEditingField extends StatelessWidget {
  const FormatEditingField({
    required this.controller,
    super.key,
    this.onChanged,
  });

  final RichTextController controller;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 150),
      child: KurumiTextField(
        controller: controller,
        maxLines: null,
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintMaxLines: 4,
          hintText: '\n\n\n',
        ),
      ),
    );
  }
}
