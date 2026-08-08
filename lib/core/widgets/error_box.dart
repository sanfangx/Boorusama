// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';
import 'package:kurumi/material.dart';
import 'package:lottie/lottie.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({
    super.key,
    this.errorMessage,
    this.child,
    this.onRetry,
    this.altAction,
  });

  final Widget? child;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final Widget? altAction;

  @override
  Widget build(BuildContext context) {
    return KurumiErrorBox(
      illustration: Lottie.asset(
        'assets/animations/server-error.json',
        width: MediaQuery.widthOf(context),
        height: 400,
        fit: BoxFit.contain,
      ),
      errorMessage: errorMessage ?? context.t.generic.errors.unknown,
      retryLabel: context.t.generic.action.retry,
      onRetry: onRetry,
      altAction: altAction,
    );
  }
}
