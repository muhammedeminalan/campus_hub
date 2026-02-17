import 'package:flutter/material.dart';

/// Flex extensions for Widget.
extension FlexExtensions on Widget {
  /// Widget'ı Expanded ile sarar.
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Widget'ı Flexible ile sarar.
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);
}
