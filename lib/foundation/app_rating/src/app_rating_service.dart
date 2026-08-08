// Package imports:
import 'package:kurumi/material.dart';

abstract class AppRatingService {
  bool get canRate;
  Widget createRatingWidget({required Widget child});
}
