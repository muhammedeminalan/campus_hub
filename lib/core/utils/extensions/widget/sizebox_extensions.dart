import 'package:flutter/material.dart';

/// Size constraint extensions for Widget.
extension SizeConstraintExtensions on Widget {
  /// Custom boyut verir
  SizedBox sized({double? height, double? width}) =>
      SizedBox(height: height, width: width, child: this);

  /// Kare boyut verir
  SizedBox square(double size) =>
      SizedBox(height: size, width: size, child: this);

  /// Sonsuz genişlik
  SizedBox get expandedWidth => SizedBox(width: double.infinity, child: this);

  /// Sonsuz yükseklik
  SizedBox get expandedHeight => SizedBox(height: double.infinity, child: this);

  /// ConstrainedBox ile min/max boyut
  Widget constrained({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) => ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: minWidth ?? 0,
      maxWidth: maxWidth ?? double.infinity,
      minHeight: minHeight ?? 0,
      maxHeight: maxHeight ?? double.infinity,
    ),
    child: this,
  );
}
