// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({
    required this.title,
    required this.builder,
    required this.onPressed,
    super.key,
  });

  final Widget Function(BuildContext context) builder;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          title: Text(
            title,
            style: Kurumi.themeOf(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
          trailing: onPressed != null
              ? TextButton(
                  onPressed: onPressed,
                  child: Text(
                    context.t.explore.see_more,
                    style: Kurumi.themeOf(context).textTheme.labelLarge,
                  ),
                )
              : null,
        ),
        builder(context),
      ],
    );
  }
}
