import 'package:flutter/widgets.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  const NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}

class NoScrollGlowConfig extends ScrollConfiguration {
  const NoScrollGlowConfig({super.key, required Widget child, super.behavior = const NoGlowScrollBehavior()}) : super(child: child);

  @override
  ScrollBehavior get behavior => const NoGlowScrollBehavior();  
}