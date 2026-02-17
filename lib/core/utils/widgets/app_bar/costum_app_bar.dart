import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Tamamen özelleştirilebilir AppBar widget'ı.
///
/// [PreferredSizeWidget] implement eder, doğrudan `Scaffold.appBar`'a verilebilir.
/// Tüm property'ler opsiyoneldir — yalnızca ihtiyaç duyulanlar verilir.
///
/// ```dart
/// CostumAppBar(
///   title: 'Ana Sayfa',
///   leadingIcon: Icons.menu,
///   actions: [CostumIconButton(iconData: Icons.search, onPressed: () {})],
/// )
/// ```
class CostumAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CostumAppBar({
    super.key,

    // ── Başlık ──
    this.title,
    this.titleWidget,
    this.titleStyle,
    this.titleColor,
    this.titleFontSize,
    this.titleFontWeight,
    this.titleSpacing,
    this.centerTitle,

    // ── Leading ──
    this.leading,
    this.leadingIcon,
    this.leadingIconColor,
    this.leadingIconSize,
    this.onLeadingPressed,
    this.automaticallyImplyLeading,
    this.leadingWidth,

    // ── Actions ──
    this.actions,
    this.actionsIconTheme,
    this.actionsPadding,

    // ── Renk & Arka Plan ──
    this.backgroundColor,
    this.foregroundColor,
    this.surfaceTintColor,
    this.gradient,
    this.shadowColor,

    // ── Yükseklik ──
    this.elevation,
    this.scrolledUnderElevation,

    // ── Boyut ──
    this.toolbarHeight,
    this.toolbarOpacity,

    // ── Şekil ──
    this.shape,
    this.borderRadius,
    this.border,

    // ── Bottom (TabBar vb.) ──
    this.bottom,

    // ── FlexibleSpace ──
    this.flexibleSpace,

    // ── Status Bar ──
    this.systemOverlayStyle,
    this.brightness,

    // ── Davranış ──
    this.primary,
    this.excludeHeaderSemantics,
    this.forceMaterialTransparency,
    this.clipBehavior,

    // ── Ek İçerik ──
    this.bottomSeparator,
    this.bottomSeparatorColor,
    this.bottomSeparatorHeight,
  });

  // ═══════════════════════════════════════════════════════════════════
  // BAŞLIK
  // ═══════════════════════════════════════════════════════════════════

  /// AppBar başlık metni. [titleWidget] verilirse yok sayılır.
  final String? title;

  /// Özel başlık widget'ı. Verilirse [title] yok sayılır.
  final Widget? titleWidget;

  /// Başlık metin stili. Verilirse [titleColor], [titleFontSize],
  /// [titleFontWeight] yok sayılır.
  final TextStyle? titleStyle;

  /// Başlık metin rengi.
  final Color? titleColor;

  /// Başlık yazı boyutu.
  final double? titleFontSize;

  /// Başlık yazı kalınlığı.
  final FontWeight? titleFontWeight;

  /// Başlık sol boşluğu (leading ile arasındaki mesafe).
  final double? titleSpacing;

  /// Başlığı ortala. Varsayılan: platform bağımlı.
  final bool? centerTitle;

  // ═══════════════════════════════════════════════════════════════════
  // LEADING
  // ═══════════════════════════════════════════════════════════════════

  /// Sol taraftaki özel widget. Verilirse [leadingIcon] yok sayılır.
  final Widget? leading;

  /// Leading ikonu. [leading] verilmezse bu ikon kullanılır.
  final IconData? leadingIcon;

  /// Leading ikon rengi.
  final Color? leadingIconColor;

  /// Leading ikon boyutu.
  final double? leadingIconSize;

  /// Leading ikona tıklama. Verilmezse varsayılan `Navigator.pop`.
  final VoidCallback? onLeadingPressed;

  /// `true` ise leading otomatik gösterilir (back button vb.). Varsayılan: true.
  final bool? automaticallyImplyLeading;

  /// Leading widget genişliği.
  final double? leadingWidth;

  // ═══════════════════════════════════════════════════════════════════
  // ACTIONS
  // ═══════════════════════════════════════════════════════════════════

  /// Sağ taraftaki aksiyon widget listesi.
  final List<Widget>? actions;

  /// Action ikonları için tema.
  final IconThemeData? actionsIconTheme;

  /// Actions bölümü padding.
  final EdgeInsetsGeometry? actionsPadding;

  // ═══════════════════════════════════════════════════════════════════
  // RENK & ARKA PLAN
  // ═══════════════════════════════════════════════════════════════════

  /// Arka plan rengi.
  final Color? backgroundColor;

  /// İkon ve metin rengi.
  final Color? foregroundColor;

  /// Material 3 surface tint rengi. `Colors.transparent` ile kapatılabilir.
  final Color? surfaceTintColor;

  /// Gradient arka plan. Verilirse [backgroundColor] yok sayılır.
  final Gradient? gradient;

  /// Gölge rengi.
  final Color? shadowColor;

  // ═══════════════════════════════════════════════════════════════════
  // YÜKSEKLİK
  // ═══════════════════════════════════════════════════════════════════

  /// Normal elevation.
  final double? elevation;

  /// Scroll durumundaki elevation (Material 3).
  final double? scrolledUnderElevation;

  // ═══════════════════════════════════════════════════════════════════
  // BOYUT
  // ═══════════════════════════════════════════════════════════════════

  /// Toolbar yüksekliği. Varsayılan: kToolbarHeight (56).
  final double? toolbarHeight;

  /// Toolbar opaklığı (0.0 – 1.0).
  final double? toolbarOpacity;

  // ═══════════════════════════════════════════════════════════════════
  // ŞEKİL
  // ═══════════════════════════════════════════════════════════════════

  /// AppBar şekli (alt kısım yuvarlaklığı vb.).
  final ShapeBorder? shape;

  /// Alt köşe yuvarlaklığı. Kısayol — verilirse [shape] oluşturulur.
  final double? borderRadius;

  /// Alt kenarlık çizgisi.
  final BorderSide? border;

  // ═══════════════════════════════════════════════════════════════════
  // BOTTOM (TabBar vb.)
  // ═══════════════════════════════════════════════════════════════════

  /// AppBar altına eklenen widget (genelde TabBar).
  final PreferredSizeWidget? bottom;

  // ═══════════════════════════════════════════════════════════════════
  // FLEXIBLE SPACE
  // ═══════════════════════════════════════════════════════════════════

  /// Arka planda gösterilen flexible space widget'ı.
  final Widget? flexibleSpace;

  // ═══════════════════════════════════════════════════════════════════
  // STATUS BAR
  // ═══════════════════════════════════════════════════════════════════

  /// Durum çubuğu stil ayarı (ikon rengi, arka plan vb.).
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Status bar parlaklığı kısayolu. [systemOverlayStyle] yerine kullanılabilir.
  final Brightness? brightness;

  // ═══════════════════════════════════════════════════════════════════
  // DAVRANIŞ
  // ═══════════════════════════════════════════════════════════════════

  /// `true` ise AppBar üst padding'e (status bar) uyum sağlar. Varsayılan: true.
  final bool? primary;

  /// Semantik header etiketini kaldır.
  final bool? excludeHeaderSemantics;

  /// `true` ise AppBar tamamen şeffaf material olarak render edilir.
  final bool? forceMaterialTransparency;

  /// Kırpma davranışı.
  final Clip? clipBehavior;

  // ═══════════════════════════════════════════════════════════════════
  // EK İÇERİK
  // ═══════════════════════════════════════════════════════════════════

  /// `true` ise AppBar altına ince bir ayırıcı çizgi eklenir.
  final bool? bottomSeparator;

  /// Alt ayırıcı rengi.
  final Color? bottomSeparatorColor;

  /// Alt ayırıcı yüksekliği. Varsayılan: 1
  final double? bottomSeparatorHeight;

  // ═══════════════════════════════════════════════════════════════════
  // YARDIMCILAR
  // ═══════════════════════════════════════════════════════════════════

  ShapeBorder? get _resolvedShape {
    if (shape != null) return shape!;
    if (borderRadius != null) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(borderRadius!),
        ),
        side: border ?? BorderSide.none,
      );
    }
    if (border != null) {
      return Border(bottom: border!);
    }
    return null;
  }

  TextStyle get _resolvedTitleStyle {
    if (titleStyle != null) return titleStyle!;
    return TextStyle(
      color: titleColor ?? foregroundColor,
      fontSize: titleFontSize,
      fontWeight: titleFontWeight ?? FontWeight.w600,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;
    if (leadingIcon != null) {
      return IconButton(
        icon: Icon(
          leadingIcon,
          size: leadingIconSize,
          color: leadingIconColor ?? foregroundColor,
        ),
        onPressed: onLeadingPressed ?? () => Navigator.maybePop(context),
      );
    }
    return null;
  }

  Widget _buildTitleWidget() {
    if (titleWidget != null) return titleWidget!;
    if (title != null) {
      return Text(title!, style: _resolvedTitleStyle);
    }
    return const SizedBox.shrink();
  }

  List<Widget>? _buildActions() {
    if (actions == null) return null;
    if (actionsPadding == null) return actions;
    return [
      Padding(
        padding: actionsPadding!,
        child: Row(children: actions!),
      ),
    ];
  }

  PreferredSizeWidget? _buildBottom() {
    if (bottom != null && (bottomSeparator ?? false)) {
      return PreferredSize(
        preferredSize: Size.fromHeight(
          bottom!.preferredSize.height + (bottomSeparatorHeight ?? 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            bottom!,
            Divider(
              height: bottomSeparatorHeight ?? 1,
              thickness: bottomSeparatorHeight ?? 1,
              color: bottomSeparatorColor,
            ),
          ],
        ),
      );
    }

    if (bottomSeparator ?? false) {
      return PreferredSize(
        preferredSize: Size.fromHeight(bottomSeparatorHeight ?? 1),
        child: Divider(
          height: bottomSeparatorHeight ?? 1,
          thickness: bottomSeparatorHeight ?? 1,
          color: bottomSeparatorColor,
        ),
      );
    }

    return bottom;
  }

  SystemUiOverlayStyle? get _resolvedSystemOverlay {
    if (systemOverlayStyle != null) return systemOverlayStyle;
    if (brightness != null) {
      return brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark;
    }
    return null;
  }

  // ═══════════════════════════════════════════════════════════════════
  // PREFERRED SIZE
  // ═══════════════════════════════════════════════════════════════════

  @override
  Size get preferredSize {
    final bottomHeight = _buildBottom()?.preferredSize.height ?? 0;
    return Size.fromHeight((toolbarHeight ?? kToolbarHeight) + bottomHeight);
  }

  // ═══════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    Widget appBar = AppBar(
      // ── Başlık ──
      title: _buildTitleWidget(),
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      titleTextStyle: _resolvedTitleStyle,

      // ── Leading ──
      leading: _buildLeading(context),
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      leadingWidth: leadingWidth,

      // ── Actions ──
      actions: _buildActions(),
      actionsIconTheme: actionsIconTheme,

      // ── Renk ──
      backgroundColor: gradient != null ? Colors.transparent : backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: surfaceTintColor,
      shadowColor: shadowColor,

      // ── Yükseklik ──
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,

      // ── Boyut ──
      toolbarHeight: toolbarHeight,
      toolbarOpacity: toolbarOpacity ?? 1.0,

      // ── Şekil ──
      shape: _resolvedShape,

      // ── Bottom ──
      bottom: _buildBottom(),

      // ── FlexibleSpace ──
      flexibleSpace: gradient != null
          ? Container(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: borderRadius != null
                    ? BorderRadius.vertical(
                        bottom: Radius.circular(borderRadius!),
                      )
                    : null,
              ),
            )
          : flexibleSpace,

      // ── Status Bar ──
      systemOverlayStyle: _resolvedSystemOverlay,

      // ── Davranış ──
      primary: primary ?? true,
      excludeHeaderSemantics: excludeHeaderSemantics ?? false,
      forceMaterialTransparency: forceMaterialTransparency ?? false,
      clipBehavior: clipBehavior,
    );

    // ── Gradient + borderRadius → Clip ──
    if (gradient != null && borderRadius != null) {
      appBar = ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(borderRadius!),
        ),
        child: appBar,
      );
    }

    return appBar;
  }
}
