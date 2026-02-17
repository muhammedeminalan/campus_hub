import 'package:flutter/widgets.dart';

/// Padding & Margin extensions for Widget.
extension PaddingExtensions on Widget {
  // ========== PADDING ==========

  /// Tüm kenarlara eşit padding
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Sadece yatay padding
  Widget paddingHorizontal(double value) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );

  /// Sadece dikey padding
  Widget paddingVertical(double value) => Padding(
    padding: EdgeInsets.symmetric(vertical: value),
    child: this,
  );

  /// Simetrik padding
  Widget paddingSymmetric({double h = 0, double v = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
    child: this,
  );

  /// Custom padding
  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  /// EdgeInsets ile padding
  Widget padding(EdgeInsets insets) => Padding(padding: insets, child: this);

  // ========== MARGIN (Container ile) ==========

  /// Tüm kenarlara eşit margin
  Widget marginAll(double value) =>
      Container(margin: EdgeInsets.all(value), child: this);

  /// Sadece yatay margin
  Widget marginHorizontal(double value) => Container(
    margin: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );

  /// Sadece dikey margin
  Widget marginVertical(double value) => Container(
    margin: EdgeInsets.symmetric(vertical: value),
    child: this,
  );

  /// Custom margin
  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Container(
    margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    child: this,
  );
}
