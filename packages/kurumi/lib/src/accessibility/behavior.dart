import 'package:flutter/foundation.dart';

typedef KurumiFeedbackCallback = void Function();

@immutable
class KurumiBehaviorData {
  const KurumiBehaviorData({
    this.reduceMotion = false,
    this.selectionFeedback,
    this.sliderLimitFeedback,
    this.sliderInteractionFeedback,
    this.refreshFeedback,
    this.menuFeedback,
    this.adaptiveMenuFeedback,
    this.contextMenuShowFeedback,
    this.contextMenuSelectionFeedback,
    this.contextMenuStartFeedbackEnabled = false,
    this.segmentedSelectionFeedback,
    this.enableIMEPersonalizedLearning = true,
  });

  final bool reduceMotion;
  final KurumiFeedbackCallback? selectionFeedback;
  final KurumiFeedbackCallback? sliderLimitFeedback;
  final KurumiFeedbackCallback? sliderInteractionFeedback;
  final KurumiFeedbackCallback? refreshFeedback;
  final KurumiFeedbackCallback? menuFeedback;
  final KurumiFeedbackCallback? adaptiveMenuFeedback;
  final KurumiFeedbackCallback? contextMenuShowFeedback;
  final KurumiFeedbackCallback? contextMenuSelectionFeedback;
  final bool contextMenuStartFeedbackEnabled;
  final KurumiFeedbackCallback? segmentedSelectionFeedback;
  final bool enableIMEPersonalizedLearning;

  Duration effectiveDuration(Duration duration) =>
      reduceMotion ? Duration.zero : duration;

  void provideSelectionFeedback() => selectionFeedback?.call();
}
