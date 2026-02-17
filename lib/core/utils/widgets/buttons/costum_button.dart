import 'package:flutter/material.dart';

/// Tamamen özelleştirilebilir genel amaçlı buton widget'ı.
///
/// Tüm property'ler opsiyoneldir — yalnızca ihtiyaç duyulan
/// parametreler verilir, geri kalanı varsayılan değerleri kullanır.
///
/// ```dart
/// CostumButton(
///   onPressed: () {},
///   text: 'Giriş Yap',
///   icon: Icons.login,
///   backgroundColor: AppColors.primary,
/// )
/// ```
class CostumButton extends StatelessWidget {
  const CostumButton({
    super.key,

    // ── İçerik ──
    this.child,
    this.text,
    this.icon,
    this.iconData,
    this.iconSize,
    this.iconColor,
    this.iconSpacing,

    // ── Aksiyon ──
    this.onPressed,
    this.onLongPress,

    // ── Boyut ──
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.margin,

    // ── Renk ──
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.overlayColor,
    this.shadowColor,

    // ── Kenarlık ──
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.borderSide,
    this.shape,

    // ── Tipografi ──
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.textAlign,

    // ── Yükseklik & Gölge ──
    this.elevation,
    this.pressedElevation,
    this.disabledElevation,

    // ── Animasyon ──
    this.animationDuration,
    this.splashFactory,

    // ── Düzen ──
    this.alignment,
    this.iconAlignment,
    this.isExpanded,
    this.isLoading,
    this.isDisabled,
    this.loadingWidget,
    this.loadingSize,
    this.loadingColor,
    this.loadingStrokeWidth,

    // ── Gradient ──
    this.gradient,

    // ── Tooltip ──
    this.tooltip,

    // ── Focus ──
    this.focusNode,
    this.autofocus,
  });

  // ═══════════════════════════════════════════════════════════════════
  // İÇERİK
  // ═══════════════════════════════════════════════════════════════════

  /// Butonun içeriği. Verilirse [text] ve [icon] yok sayılır.
  final Widget? child;

  /// Buton metni. [child] verilmezse kullanılır.
  final String? text;

  /// Butonun soluna (veya [iconAlignment] yönüne) eklenen ikon widget'ı.
  /// [iconData] yerine özel bir widget verilmek istenirse kullanılır.
  final Widget? icon;

  /// Butonun soluna eklenen Material ikon verisi.
  final IconData? iconData;

  /// İkon boyutu.
  final double? iconSize;

  /// İkon rengi. Verilmezse [foregroundColor] kullanılır.
  final Color? iconColor;

  /// İkon ile metin arasındaki boşluk. Varsayılan: 8
  final double? iconSpacing;

  // ═══════════════════════════════════════════════════════════════════
  // AKSİYON
  // ═══════════════════════════════════════════════════════════════════

  /// Butona tıklandığında çağrılır.
  final VoidCallback? onPressed;

  /// Butona uzun basıldığında çağrılır.
  final VoidCallback? onLongPress;

  // ═══════════════════════════════════════════════════════════════════
  // BOYUT
  // ═══════════════════════════════════════════════════════════════════

  /// Butonun sabit genişliği.
  final double? width;

  /// Butonun sabit yüksekliği.
  final double? height;

  /// Minimum genişlik.
  final double? minWidth;

  /// Maksimum genişlik.
  final double? maxWidth;

  /// Minimum yükseklik.
  final double? minHeight;

  /// Maksimum yükseklik.
  final double? maxHeight;

  /// İç padding.
  final EdgeInsetsGeometry? padding;

  /// Dış margin.
  final EdgeInsetsGeometry? margin;

  // ═══════════════════════════════════════════════════════════════════
  // RENK
  // ═══════════════════════════════════════════════════════════════════

  /// Butonun arka plan rengi.
  final Color? backgroundColor;

  /// Metin ve ikon rengi.
  final Color? foregroundColor;

  /// Devre dışı durumdaki arka plan rengi.
  final Color? disabledBackgroundColor;

  /// Devre dışı durumdaki metin/ikon rengi.
  final Color? disabledForegroundColor;

  /// Tıklama efekti rengi (ripple/splash).
  final Color? overlayColor;

  /// Gölge rengi.
  final Color? shadowColor;

  // ═══════════════════════════════════════════════════════════════════
  // KENARLIK
  // ═══════════════════════════════════════════════════════════════════

  /// Kenarlık rengi. Verilirse outline tarzı buton görünümü oluşur.
  final Color? borderColor;

  /// Kenarlık kalınlığı. Varsayılan: 1
  final double? borderWidth;

  /// Köşe yuvarlaklığı. Tek değer ile 4 köşe aynı radius alır.
  final double? borderRadius;

  /// Özel kenarlık. Verilirse [borderColor] ve [borderWidth] yok sayılır.
  final BorderSide? borderSide;

  /// Buton şekli. Verilirse [borderRadius] yok sayılır.
  final OutlinedBorder? shape;

  // ═══════════════════════════════════════════════════════════════════
  // TİPOGRAFİ
  // ═══════════════════════════════════════════════════════════════════

  /// Metin stili. Verilirse [fontSize], [fontWeight], [letterSpacing] yok sayılır.
  final TextStyle? textStyle;

  /// Yazı boyutu.
  final double? fontSize;

  /// Yazı kalınlığı.
  final FontWeight? fontWeight;

  /// Harf aralığı.
  final double? letterSpacing;

  /// Metin hizalama.
  final TextAlign? textAlign;

  // ═══════════════════════════════════════════════════════════════════
  // YÜKSEKLİK & GÖLGE
  // ═══════════════════════════════════════════════════════════════════

  /// Normal durumdaki elevation.
  final double? elevation;

  /// Basılı durumdaki elevation.
  final double? pressedElevation;

  /// Devre dışı durumdaki elevation.
  final double? disabledElevation;

  // ═══════════════════════════════════════════════════════════════════
  // ANİMASYON
  // ═══════════════════════════════════════════════════════════════════

  /// Stil geçiş animasyon süresi.
  final Duration? animationDuration;

  /// Splash (ripple) efekti fabrikası.
  final InteractiveInkFeatureFactory? splashFactory;

  // ═══════════════════════════════════════════════════════════════════
  // DÜZEN & DURUM
  // ═══════════════════════════════════════════════════════════════════

  /// İçerik hizalaması.
  final AlignmentGeometry? alignment;

  /// İkonun konumu (sol veya sağ).
  final IconAlignment? iconAlignment;

  /// `true` ise buton tüm genişliği kaplar.
  final bool? isExpanded;

  /// `true` ise loading göstergesi gösterir ve tıklamayı devre dışı bırakır.
  final bool? isLoading;

  /// `true` ise buton devre dışı kalır (onPressed çalışmaz).
  final bool? isDisabled;

  /// Özel loading widget'ı. Verilmezse [CircularProgressIndicator] kullanılır.
  final Widget? loadingWidget;

  /// Loading göstergesi boyutu. Varsayılan: 20
  final double? loadingSize;

  /// Loading göstergesi rengi. Varsayılan: [foregroundColor]
  final Color? loadingColor;

  /// Loading göstergesi çizgi kalınlığı.
  final double? loadingStrokeWidth;

  // ═══════════════════════════════════════════════════════════════════
  // GRADİENT
  // ═══════════════════════════════════════════════════════════════════

  /// Gradient verilirse [backgroundColor] yok sayılır ve buton
  /// gradient arka planlı olur.
  final Gradient? gradient;

  // ═══════════════════════════════════════════════════════════════════
  // TOOLTIP
  // ═══════════════════════════════════════════════════════════════════

  /// Erişilebilirlik için uzun basınca gösterilen ipucu metni.
  final String? tooltip;

  // ═══════════════════════════════════════════════════════════════════
  // FOCUS
  // ═══════════════════════════════════════════════════════════════════

  /// Odak düğümü.
  final FocusNode? focusNode;

  /// `true` ise widget oluşturulduğunda otomatik odaklanır.
  final bool? autofocus;

  // ═══════════════════════════════════════════════════════════════════
  // YARDIMCILAR
  // ═══════════════════════════════════════════════════════════════════

  bool get _isActive => !(isDisabled ?? false) && !(isLoading ?? false);

  BorderSide get _resolvedBorder {
    if (borderSide != null) return borderSide!;
    if (borderColor != null) {
      return BorderSide(color: borderColor!, width: borderWidth ?? 1);
    }
    return BorderSide.none;
  }

  OutlinedBorder get _resolvedShape {
    if (shape != null) return shape!;
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      side: _resolvedBorder,
    );
  }

  TextStyle _resolvedTextStyle(BuildContext context) {
    if (textStyle != null) return textStyle!;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // LOADING WIDGET
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildLoadingIndicator() {
    return loadingWidget ??
        SizedBox(
          width: loadingSize ?? 20,
          height: loadingSize ?? 20,
          child: CircularProgressIndicator(
            strokeWidth: loadingStrokeWidth ?? 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              loadingColor ?? foregroundColor ?? Colors.white,
            ),
          ),
        );
  }

  // ═══════════════════════════════════════════════════════════════════
  // BUTON İÇERİĞİ
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildContent() {
    // Loading durumu
    if (isLoading ?? false) return _buildLoadingIndicator();

    // Özel child verilmişse doğrudan kullan
    if (child != null) return child!;

    // İkon widget'ı
    final iconWidget =
        icon ??
        (iconData != null
            ? Icon(iconData, size: iconSize, color: iconColor)
            : null);

    // Metin widget'ı
    final textWidget = text != null ? Text(text!, textAlign: textAlign) : null;

    // Sadece ikon
    if (textWidget == null && iconWidget != null) return iconWidget;

    // Sadece metin
    if (iconWidget == null && textWidget != null) return textWidget;

    // İkon + metin
    if (iconWidget != null && textWidget != null) {
      final spacing = SizedBox(width: iconSpacing ?? 8);
      final isIconEnd = iconAlignment == IconAlignment.end;

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: isIconEnd
            ? [textWidget, spacing, iconWidget]
            : [iconWidget, spacing, textWidget],
      );
    }

    // Hiçbiri verilmemişse boş SizedBox
    return const SizedBox.shrink();
  }

  // ═══════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = _isActive ? onPressed : null;
    final effectiveOnLongPress = _isActive ? onLongPress : null;

    // ── ButtonStyle ──
    final style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledBackgroundColor ??
              (backgroundColor?.withValues(alpha: 0.5));
        }
        return gradient != null ? Colors.transparent : backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledForegroundColor ??
              foregroundColor?.withValues(alpha: 0.5);
        }
        return foregroundColor;
      }),
      overlayColor: overlayColor != null
          ? WidgetStatePropertyAll(overlayColor)
          : null,
      shadowColor: shadowColor != null
          ? WidgetStatePropertyAll(shadowColor)
          : null,
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledElevation ?? 0;
        }
        if (states.contains(WidgetState.pressed)) {
          return pressedElevation ?? (elevation ?? 0) * 0.5;
        }
        return elevation ?? 0;
      }),
      padding: padding != null ? WidgetStatePropertyAll(padding) : null,
      textStyle: WidgetStatePropertyAll(_resolvedTextStyle(context)),
      shape: WidgetStatePropertyAll(_resolvedShape),
      alignment: alignment,
      animationDuration: animationDuration,
      splashFactory: splashFactory,
      minimumSize: (minWidth != null || minHeight != null)
          ? WidgetStatePropertyAll(Size(minWidth ?? 0, minHeight ?? 0))
          : null,
      maximumSize: (maxWidth != null || maxHeight != null)
          ? WidgetStatePropertyAll(
              Size(maxWidth ?? double.infinity, maxHeight ?? double.infinity),
            )
          : null,
      fixedSize: (width != null || height != null)
          ? WidgetStatePropertyAll(Size(width ?? double.infinity, height ?? 48))
          : null,
    );

    // ── Buton ──
    Widget button = ElevatedButton(
      onPressed: effectiveOnPressed,
      onLongPress: effectiveOnLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus ?? false,
      child: _buildContent(),
    );

    // ── Gradient Katmanı ──
    if (gradient != null) {
      button = DecoratedBox(
        decoration: BoxDecoration(
          gradient: _isActive ? gradient : null,
          color: !_isActive
              ? (disabledBackgroundColor ?? Colors.grey.shade300)
              : null,
          borderRadius: shape == null
              ? BorderRadius.circular(borderRadius ?? 8)
              : null,
          shape: shape != null ? BoxShape.rectangle : BoxShape.rectangle,
        ),
        child: button,
      );
    }

    // ── Genişlik (Expanded) ──
    if (isExpanded ?? false) {
      button = SizedBox(width: double.infinity, child: button);
    }

    // ── Margin ──
    if (margin != null) {
      button = Padding(padding: margin!, child: button);
    }

    // ── Tooltip ──
    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
