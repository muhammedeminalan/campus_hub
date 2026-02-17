import 'package:flutter/material.dart';

/// Tamamen özelleştirilebilir dairesel ikon buton widget'ı.
///
/// Tüm property'ler opsiyoneldir — yalnızca ihtiyaç duyulan
/// parametreler verilir, geri kalanı varsayılan değerleri kullanır.
///
/// ```dart
/// CostumIconButton(
///   iconData: Icons.favorite,
///   onPressed: () {},
///   backgroundColor: AppColors.primary,
///   iconColor: Colors.white,
///   size: 48,
/// )
/// ```
class CostumIconButton extends StatelessWidget {
  const CostumIconButton({
    super.key,

    // ── İçerik ──
    this.icon,
    this.iconData,
    this.iconSize,
    this.iconColor,

    // ── Aksiyon ──
    this.onPressed,
    this.onLongPress,

    // ── Boyut ──
    this.size,
    this.minSize,
    this.maxSize,
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
    this.borderSide,

    // ── Yükseklik & Gölge ──
    this.elevation,
    this.pressedElevation,
    this.disabledElevation,

    // ── Animasyon ──
    this.animationDuration,
    this.splashFactory,
    this.splashRadius,

    // ── Durum ──
    this.isLoading,
    this.isDisabled,
    this.loadingWidget,
    this.loadingSize,
    this.loadingColor,
    this.loadingStrokeWidth,

    // ── Gradient ──
    this.gradient,

    // ── Badge ──
    this.badgeCount,
    this.badgeColor,
    this.badgeTextColor,
    this.showBadge,

    // ── Tooltip ──
    this.tooltip,

    // ── Focus ──
    this.focusNode,
    this.autofocus,
  });

  // ═══════════════════════════════════════════════════════════════════
  // İÇERİK
  // ═══════════════════════════════════════════════════════════════════

  /// Özel ikon widget'ı. Verilirse [iconData] yok sayılır.
  final Widget? icon;

  /// Material ikon verisi.
  final IconData? iconData;

  /// İkon boyutu. Varsayılan: 24
  final double? iconSize;

  /// İkon rengi. Verilmezse [foregroundColor] kullanılır.
  final Color? iconColor;

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

  /// Butonun çapı (genişlik = yükseklik). Varsayılan: 48
  final double? size;

  /// Minimum boyut.
  final double? minSize;

  /// Maksimum boyut.
  final double? maxSize;

  /// İç padding. Varsayılan: EdgeInsets.all(8)
  final EdgeInsetsGeometry? padding;

  /// Dış margin.
  final EdgeInsetsGeometry? margin;

  // ═══════════════════════════════════════════════════════════════════
  // RENK
  // ═══════════════════════════════════════════════════════════════════

  /// Butonun arka plan rengi.
  final Color? backgroundColor;

  /// İkon / içerik rengi.
  final Color? foregroundColor;

  /// Devre dışı durumdaki arka plan rengi.
  final Color? disabledBackgroundColor;

  /// Devre dışı durumdaki ikon rengi.
  final Color? disabledForegroundColor;

  /// Tıklama efekti rengi (ripple / splash).
  final Color? overlayColor;

  /// Gölge rengi.
  final Color? shadowColor;

  // ═══════════════════════════════════════════════════════════════════
  // KENARLIK
  // ═══════════════════════════════════════════════════════════════════

  /// Kenarlık rengi. Verilirse daire etrafına çizgi çizilir.
  final Color? borderColor;

  /// Kenarlık kalınlığı. Varsayılan: 1
  final double? borderWidth;

  /// Özel kenarlık. Verilirse [borderColor] ve [borderWidth] yok sayılır.
  final BorderSide? borderSide;

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

  /// Splash efekti yarıçapı.
  final double? splashRadius;

  // ═══════════════════════════════════════════════════════════════════
  // DURUM
  // ═══════════════════════════════════════════════════════════════════

  /// `true` ise loading göstergesi gösterir ve tıklamayı devre dışı bırakır.
  final bool? isLoading;

  /// `true` ise buton devre dışı kalır.
  final bool? isDisabled;

  /// Özel loading widget'ı.
  final Widget? loadingWidget;

  /// Loading göstergesi boyutu. Varsayılan: 20
  final double? loadingSize;

  /// Loading göstergesi rengi.
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
  // BADGE
  // ═══════════════════════════════════════════════════════════════════

  /// Badge'de gösterilecek sayı. `null` ise badge gizlenir.
  final int? badgeCount;

  /// Badge arka plan rengi. Varsayılan: kırmızı
  final Color? badgeColor;

  /// Badge metin rengi. Varsayılan: beyaz
  final Color? badgeTextColor;

  /// Badge'i sayı olmadan nokta olarak göster.
  final bool? showBadge;

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

  double get _resolvedSize => size ?? 48;

  // ═══════════════════════════════════════════════════════════════════
  // LOADING WIDGET
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildLoadingIndicator() {
    final effectiveSize = loadingSize ?? (iconSize ?? 20);
    return loadingWidget ??
        SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: CircularProgressIndicator(
            strokeWidth: loadingStrokeWidth ?? 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              loadingColor ?? foregroundColor ?? iconColor ?? Colors.white,
            ),
          ),
        );
  }

  // ═══════════════════════════════════════════════════════════════════
  // BADGE
  // ═══════════════════════════════════════════════════════════════════

  Widget _wrapWithBadge(Widget child) {
    final hasBadge =
        (showBadge ?? false) || (badgeCount != null && badgeCount! > 0);
    if (!hasBadge) return child;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            padding: badgeCount != null
                ? const EdgeInsets.symmetric(horizontal: 4, vertical: 1)
                : const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: badgeColor ?? Colors.red,
              shape: badgeCount != null ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: badgeCount != null
                  ? BorderRadius.circular(8)
                  : null,
            ),
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: badgeCount != null
                ? Center(
                    child: Text(
                      badgeCount! > 99 ? '99+' : '$badgeCount',
                      style: TextStyle(
                        color: badgeTextColor ?? Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // İÇERİK
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildContent() {
    if (isLoading ?? false) return _buildLoadingIndicator();

    if (icon != null) return icon!;

    if (iconData != null) {
      return Icon(iconData, size: iconSize, color: iconColor);
    }

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
      padding: WidgetStatePropertyAll(padding ?? const EdgeInsets.all(8)),
      shape: WidgetStatePropertyAll(CircleBorder(side: _resolvedBorder)),
      fixedSize: WidgetStatePropertyAll(Size.square(_resolvedSize)),
      minimumSize: minSize != null
          ? WidgetStatePropertyAll(Size.square(minSize!))
          : null,
      maximumSize: maxSize != null
          ? WidgetStatePropertyAll(Size.square(maxSize!))
          : null,
      alignment: Alignment.center,
      animationDuration: animationDuration,
      splashFactory: splashFactory,
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
          shape: BoxShape.circle,
        ),
        child: button,
      );
    }

    // ── Badge ──
    button = _wrapWithBadge(button);

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
