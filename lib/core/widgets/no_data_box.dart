// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:lottie/lottie.dart';

class NoDataBox extends StatelessWidget {
  const NoDataBox({super.key});

  @override
  Widget build(BuildContext context) {
    return KurumiNoDataBox(
      illustration: Lottie.asset(
        'assets/animations/search-file.json',
        width: MediaQuery.widthOf(context),
        height: 300,
        fit: BoxFit.contain,
      ),
      message: context.t.generic.errors.no_data,
    );
  }
}
