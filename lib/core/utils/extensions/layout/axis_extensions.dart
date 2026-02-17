import 'package:flutter/material.dart';

/// Column CrossAxis Extensions
extension ColumnCrossAxis on Column {
  Column _copyWith({CrossAxisAlignment? cross, MainAxisAlignment? main}) =>
      Column(
        key: key,
        mainAxisAlignment: main ?? mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: cross ?? crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: children,
      );

  Column get crossStart => _copyWith(cross: CrossAxisAlignment.start);
  Column get crossCenter => _copyWith(cross: CrossAxisAlignment.center);
  Column get crossEnd => _copyWith(cross: CrossAxisAlignment.end);
  Column get crossStretch => _copyWith(cross: CrossAxisAlignment.stretch);
}

/// Column MainAxis Extensions
extension ColumnMainAxis on Column {
  Column _copyWithMain(MainAxisAlignment main) => Column(
    key: key,
    mainAxisAlignment: main,
    mainAxisSize: mainAxisSize,
    crossAxisAlignment: crossAxisAlignment,
    textDirection: textDirection,
    verticalDirection: verticalDirection,
    textBaseline: textBaseline,
    children: children,
  );

  Column get mainStart => _copyWithMain(MainAxisAlignment.start);
  Column get mainCenter => _copyWithMain(MainAxisAlignment.center);
  Column get mainEnd => _copyWithMain(MainAxisAlignment.end);
  Column get mainSpaceBetween => _copyWithMain(MainAxisAlignment.spaceBetween);
  Column get mainSpaceAround => _copyWithMain(MainAxisAlignment.spaceAround);
  Column get mainSpaceEvenly => _copyWithMain(MainAxisAlignment.spaceEvenly);
}

/// Row CrossAxis Extensions
extension RowCrossAxis on Row {
  Row _copyWith({CrossAxisAlignment? cross}) => Row(
    key: key,
    mainAxisAlignment: mainAxisAlignment,
    mainAxisSize: mainAxisSize,
    crossAxisAlignment: cross ?? crossAxisAlignment,
    textDirection: textDirection,
    verticalDirection: verticalDirection,
    textBaseline: textBaseline,
    children: children,
  );

  Row get crossStart => _copyWith(cross: CrossAxisAlignment.start);
  Row get crossCenter => _copyWith(cross: CrossAxisAlignment.center);
  Row get crossEnd => _copyWith(cross: CrossAxisAlignment.end);
  Row get crossStretch => _copyWith(cross: CrossAxisAlignment.stretch);
}

/// Row MainAxis Extensions
extension RowMainAxis on Row {
  Row _copyWithMain(MainAxisAlignment main) => Row(
    key: key,
    mainAxisAlignment: main,
    mainAxisSize: mainAxisSize,
    crossAxisAlignment: crossAxisAlignment,
    textDirection: textDirection,
    verticalDirection: verticalDirection,
    textBaseline: textBaseline,
    children: children,
  );

  Row get mainStart => _copyWithMain(MainAxisAlignment.start);
  Row get mainCenter => _copyWithMain(MainAxisAlignment.center);
  Row get mainEnd => _copyWithMain(MainAxisAlignment.end);
  Row get mainSpaceBetween => _copyWithMain(MainAxisAlignment.spaceBetween);
  Row get mainSpaceAround => _copyWithMain(MainAxisAlignment.spaceAround);
  Row get mainSpaceEvenly => _copyWithMain(MainAxisAlignment.spaceEvenly);
}
