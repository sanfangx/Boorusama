// Package imports:
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';

// Project imports:
import '../controllers/home_page_controller.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final Widget icon;
  final Widget title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final homeController = InheritedHomePageController.maybeOf(context);

    return KurumiSideMenuTile(
      icon: icon,
      title: title,
      onTap: () {
        // Workaround to make the animation smoother
        Future.delayed(
          const Duration(milliseconds: 250),
          () {
            if (context.mounted) {
              homeController?.closeMenu();
            }
          },
        );
        onTap();
      },
    );
  }
}
