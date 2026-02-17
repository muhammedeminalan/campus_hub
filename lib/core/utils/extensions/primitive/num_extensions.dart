import 'package:flutter/material.dart';

/// Numeric extensions for spacing and sizing.
extension SizeExtensions on num {
  /// Dikey boşluk: `16.h` -> SizedBox(height: 16)
  SizedBox get h => SizedBox(height: toDouble());

  /// Yatay boşluk: `16.w` -> SizedBox(width: 16)
  SizedBox get w => SizedBox(width: toDouble());

  /// Eski isimlendirme (geriye uyumluluk)
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());

  /// EdgeInsets helpers
  EdgeInsets get all => EdgeInsets.all(toDouble());
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());

  /// BorderRadius helper
  BorderRadius get radius => BorderRadius.circular(toDouble());

  /// Duration helpers
  Duration get ms => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
}
