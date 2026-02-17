import 'package:flutter/material.dart';

/// Alignment extensions for Widget.
extension AlignmentExtensions on Widget {
  /// Widget'i Center ile sarar
  Widget get center => Center(child: this);

  /// Widget'i sola hizalar
  Widget get alignLeft => Align(alignment: Alignment.centerLeft, child: this);

  /// Widget'i sağa hizalar
  Widget get alignRight => Align(alignment: Alignment.centerRight, child: this);

  /// Widget'i üste hizalar
  Widget get alignTop => Align(alignment: Alignment.topCenter, child: this);

  /// Widget'i alta hizalar
  Widget get alignBottom =>
      Align(alignment: Alignment.bottomCenter, child: this);

  /// Custom alignment
  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);
}
