import 'package:flutter/material.dart';

/// Chainable Text builder.
///
/// Kullanım:
/// ```dart
/// "Hello".text.bold.headline4(context).color(Colors.red)
/// ```
class TextBuilder extends StatelessWidget {
  final String _text;
  final TextStyle _style;
  final TextAlign? _textAlign;
  final int? _maxLines;
  final TextOverflow? _overflow;

  const TextBuilder(
    this._text, {
    super.key,
    TextStyle style = const TextStyle(),
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : _style = style,
       _textAlign = textAlign,
       _maxLines = maxLines,
       _overflow = overflow;

  TextBuilder _copyWith({
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return TextBuilder(
      _text,
      style: style ?? _style,
      textAlign: textAlign ?? _textAlign,
      maxLines: maxLines ?? _maxLines,
      overflow: overflow ?? _overflow,
    );
  }

  // ========================================
  // Font Weight
  // ========================================
  TextBuilder get thin =>
      _copyWith(style: _style.copyWith(fontWeight: FontWeight.w100));
  TextBuilder get extraLight =>
      _copyWith(style: _style.copyWith(fontWeight: FontWeight.w200));
  TextBuilder get light =>
      _copyWith(style: _style.copyWith(fontWeight: FontWeight.w300));
  TextBuilder get regular =>
      _copyWith(style: _style.copyWith(fontWeight: FontWeight.w400));
  TextBuilder get medium =>
      _copyWith(style: _style.copyWith(fontWeight: FontWeight.w500));
  TextBuilder get semiBold =>
      _copyWith(style: _style.copyWith(fontWeight: FontWeight.w600));
  TextBuilder get bold =>
      _copyWith(style: _style.copyWith(fontWeight: FontWeight.w700));
  TextBuilder get extraBold =>
      _copyWith(style: _style.copyWith(fontWeight: FontWeight.w800));
  TextBuilder get black =>
      _copyWith(style: _style.copyWith(fontWeight: FontWeight.w900));

  // ========================================
  // Font Style
  // ========================================
  TextBuilder get italic =>
      _copyWith(style: _style.copyWith(fontStyle: FontStyle.italic));
  TextBuilder get normal =>
      _copyWith(style: _style.copyWith(fontStyle: FontStyle.normal));

  // ========================================
  // Text Decoration
  // ========================================
  TextBuilder get underline =>
      _copyWith(style: _style.copyWith(decoration: TextDecoration.underline));
  TextBuilder get lineThrough =>
      _copyWith(style: _style.copyWith(decoration: TextDecoration.lineThrough));
  TextBuilder get overline =>
      _copyWith(style: _style.copyWith(decoration: TextDecoration.overline));
  TextBuilder get noDecoration =>
      _copyWith(style: _style.copyWith(decoration: TextDecoration.none));

  // ========================================
  // Text Align
  // ========================================
  TextBuilder get alignLeft => _copyWith(textAlign: TextAlign.left);
  TextBuilder get alignRight => _copyWith(textAlign: TextAlign.right);
  TextBuilder get alignCenter => _copyWith(textAlign: TextAlign.center);
  TextBuilder get alignJustify => _copyWith(textAlign: TextAlign.justify);

  // ========================================
  // Overflow
  // ========================================
  TextBuilder get ellipsis => _copyWith(overflow: TextOverflow.ellipsis);
  TextBuilder get fade => _copyWith(overflow: TextOverflow.fade);
  TextBuilder get clip => _copyWith(overflow: TextOverflow.clip);
  TextBuilder get visible => _copyWith(overflow: TextOverflow.visible);

  // ========================================
  // Typography Styles (Theme Based)
  // ========================================
  TextBuilder displayLarge(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.displayLarge?.merge(_style) ?? _style,
  );
  TextBuilder displayMedium(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.displayMedium?.merge(_style) ?? _style,
  );
  TextBuilder displaySmall(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.displaySmall?.merge(_style) ?? _style,
  );

  TextBuilder headlineLarge(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.headlineLarge?.merge(_style) ?? _style,
  );
  TextBuilder headlineMedium(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.headlineMedium?.merge(_style) ?? _style,
  );
  TextBuilder headlineSmall(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.headlineSmall?.merge(_style) ?? _style,
  );

  TextBuilder titleLarge(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.titleLarge?.merge(_style) ?? _style,
  );
  TextBuilder titleMedium(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.titleMedium?.merge(_style) ?? _style,
  );
  TextBuilder titleSmall(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.titleSmall?.merge(_style) ?? _style,
  );

  TextBuilder bodyLarge(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.bodyLarge?.merge(_style) ?? _style,
  );
  TextBuilder bodyMedium(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.bodyMedium?.merge(_style) ?? _style,
  );
  TextBuilder bodySmall(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.bodySmall?.merge(_style) ?? _style,
  );

  TextBuilder labelLarge(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.labelLarge?.merge(_style) ?? _style,
  );
  TextBuilder labelMedium(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.labelMedium?.merge(_style) ?? _style,
  );
  TextBuilder labelSmall(BuildContext context) => _copyWith(
    style: Theme.of(context).textTheme.labelSmall?.merge(_style) ?? _style,
  );

  // Legacy support (headline4 = headlineMedium in Material 3)
  TextBuilder headline1(BuildContext context) => displayLarge(context);
  TextBuilder headline2(BuildContext context) => displayMedium(context);
  TextBuilder headline3(BuildContext context) => displaySmall(context);
  TextBuilder headline4(BuildContext context) => headlineMedium(context);
  TextBuilder headline5(BuildContext context) => headlineSmall(context);
  TextBuilder headline6(BuildContext context) => titleLarge(context);
  TextBuilder subtitle1(BuildContext context) => titleMedium(context);
  TextBuilder subtitle2(BuildContext context) => titleSmall(context);
  TextBuilder body1(BuildContext context) => bodyLarge(context);
  TextBuilder body2(BuildContext context) => bodyMedium(context);
  TextBuilder caption(BuildContext context) => bodySmall(context);
  TextBuilder button(BuildContext context) => labelLarge(context);

  // ========================================
  // Methods with Parameters
  // ========================================
  TextBuilder color(Color color) =>
      _copyWith(style: _style.copyWith(color: color));
  TextBuilder backgroundColor(Color color) =>
      _copyWith(style: _style.copyWith(backgroundColor: color));
  TextBuilder fontSize(double size) =>
      _copyWith(style: _style.copyWith(fontSize: size));
  TextBuilder letterSpacing(double spacing) =>
      _copyWith(style: _style.copyWith(letterSpacing: spacing));
  TextBuilder wordSpacing(double spacing) =>
      _copyWith(style: _style.copyWith(wordSpacing: spacing));
  TextBuilder height(double height) =>
      _copyWith(style: _style.copyWith(height: height));
  TextBuilder maxLine(int lines) => _copyWith(maxLines: lines);
  TextBuilder fontFamily(String family) =>
      _copyWith(style: _style.copyWith(fontFamily: family));

  TextBuilder style(TextStyle textStyle) =>
      _copyWith(style: _style.merge(textStyle));

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: _style,
      textAlign: _textAlign,
      maxLines: _maxLines,
      overflow: _overflow,
    );
  }
}

extension TextBuilderExtension on String {
  /// Chainable text builder başlatır.
  ///
  /// Kullanım:
  /// ```dart
  /// "Hello".text.bold.headline4(context).color(Colors.red)
  /// ```
  TextBuilder get text => TextBuilder(this);
}
