import 'package:flutter/material.dart';

/// Tamamen özelleştirilebilir BottomSheet widget'ı ve yardımcı `show` metodu.
///
/// İki kullanım biçimi vardır:
/// 1. **Fonksiyon**: `CostumBottomSheet.show(context, ...)` — hızlı açma.
/// 2. **Widget**: `CostumBottomSheet(...)` — `DraggableScrollableSheet` içinde
///    veya doğrudan bir builder içinde kullanılabilir.
///
/// Tüm property'ler opsiyoneldir.
///
/// ```dart
/// CostumBottomSheet.show(
///   context,
///   title: 'Filtre',
///   child: FilterWidget(),
/// );
/// ```
class CostumBottomSheet extends StatelessWidget {
  const CostumBottomSheet({
    super.key,

    // ── İçerik ──
    this.child,
    this.children,
    this.title,
    this.titleWidget,
    this.titleStyle,
    this.titleColor,
    this.titleFontSize,
    this.titleFontWeight,
    this.titleAlignment,
    this.subtitle,
    this.subtitleWidget,
    this.subtitleStyle,
    this.message,
    this.messageWidget,
    this.messageStyle,
    this.icon,
    this.iconData,
    this.iconSize,
    this.iconColor,
    this.image,

    // ── Üst Bar (Handle) ──
    this.showHandle,
    this.handleColor,
    this.handleWidth,
    this.handleHeight,
    this.handleMargin,
    this.handleDecoration,

    // ── Kapatma Butonu ──
    this.showCloseButton,
    this.closeIcon,
    this.closeIconColor,
    this.closeIconSize,
    this.onClose,
    this.closeButtonAlignment,

    // ── Header ──
    this.header,
    this.headerPadding,
    this.headerDecoration,
    this.headerSeparator,
    this.headerSeparatorColor,
    this.headerSeparatorHeight,

    // ── Footer ──
    this.footer,
    this.footerPadding,
    this.footerDecoration,
    this.footerSeparator,
    this.footerSeparatorColor,
    this.footerSeparatorHeight,

    // ── Aksiyonlar ──
    this.primaryAction,
    this.primaryActionText,
    this.onPrimaryAction,
    this.secondaryAction,
    this.secondaryActionText,
    this.onSecondaryAction,
    this.actionsAxis,
    this.actionsSpacing,
    this.actionsPadding,

    // ── Renk & Arka Plan ──
    this.backgroundColor,
    this.barrierColor,
    this.surfaceTintColor,
    this.gradient,
    this.shadowColor,

    // ── Boyut ──
    this.height,
    this.minHeight,
    this.maxHeight,
    this.width,
    this.padding,
    this.contentPadding,
    this.margin,

    // ── Şekil & Kenarlık ──
    this.borderRadius,
    this.topLeftRadius,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.border,
    this.borderColor,
    this.borderWidth,
    this.shape,

    // ── Yükseklik & Gölge ──
    this.elevation,

    // ── Scroll ──
    this.isScrollable,
    this.scrollController,
    this.scrollPhysics,
    this.scrollPadding,
    this.shrinkWrap,

    // ── Draggable ──
    this.isDraggable,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.snap,
    this.snapSizes,
    this.shouldCloseOnMinExtent,

    // ── Davranış ──
    this.isDismissible,
    this.enableDrag,
    this.isModal,
    this.useRootNavigator,
    this.useSafeArea,

    // ── Animasyon ──
    this.animationDuration,
    this.animationCurve,
    this.transitionAnimationController,

    // ── Erişilebilirlik ──
    this.semanticLabel,
    this.routeSettings,

    // ── Constraints ──
    this.constraints,

    // ── Callback ──
    this.onDismissed,
  });

  // ═══════════════════════════════════════════════════════════════════
  // İÇERİK
  // ═══════════════════════════════════════════════════════════════════

  /// Ana içerik widget'ı. [children] verilirse yok sayılır.
  final Widget? child;

  /// İçerik widget listesi (Column içinde sıralanır).
  final List<Widget>? children;

  /// Başlık metni. [titleWidget] verilirse yok sayılır.
  final String? title;

  /// Özel başlık widget'ı.
  final Widget? titleWidget;

  /// Başlık metin stili. Verilirse diğer title property'leri yok sayılır.
  final TextStyle? titleStyle;

  /// Başlık rengi.
  final Color? titleColor;

  /// Başlık yazı boyutu.
  final double? titleFontSize;

  /// Başlık yazı kalınlığı.
  final FontWeight? titleFontWeight;

  /// Başlık hizalaması.
  final TextAlign? titleAlignment;

  /// Alt başlık metni.
  final String? subtitle;

  /// Özel alt başlık widget'ı.
  final Widget? subtitleWidget;

  /// Alt başlık stili.
  final TextStyle? subtitleStyle;

  /// İçerik mesajı.
  final String? message;

  /// Özel mesaj widget'ı.
  final Widget? messageWidget;

  /// Mesaj stili.
  final TextStyle? messageStyle;

  /// Başlık üstünde gösterilecek ikon widget'ı.
  final Widget? icon;

  /// Başlık üstünde gösterilecek Material ikon verisi.
  final IconData? iconData;

  /// İkon boyutu. Varsayılan: 40
  final double? iconSize;

  /// İkon rengi.
  final Color? iconColor;

  /// Başlık üstünde gösterilecek resim widget'ı.
  final Widget? image;

  // ═══════════════════════════════════════════════════════════════════
  // ÜST BAR (HANDLE)
  // ═══════════════════════════════════════════════════════════════════

  /// `true` ise üstte sürükleme tutacağı gösterilir. Varsayılan: true.
  final bool? showHandle;

  /// Tutacak rengi.
  final Color? handleColor;

  /// Tutacak genişliği. Varsayılan: 40
  final double? handleWidth;

  /// Tutacak yüksekliği. Varsayılan: 4
  final double? handleHeight;

  /// Tutacak üst/alt boşluğu.
  final EdgeInsetsGeometry? handleMargin;

  /// Tutacak için özel dekorasyon.
  final BoxDecoration? handleDecoration;

  // ═══════════════════════════════════════════════════════════════════
  // KAPATMA BUTONU
  // ═══════════════════════════════════════════════════════════════════

  /// `true` ise sağ üstte kapatma butonu gösterilir.
  final bool? showCloseButton;

  /// Kapatma ikon widget'ı.
  final Widget? closeIcon;

  /// Kapatma ikon rengi.
  final Color? closeIconColor;

  /// Kapatma ikon boyutu.
  final double? closeIconSize;

  /// Kapatma butonuna basıldığında çağrılır.
  /// Verilmezse `Navigator.pop` kullanılır.
  final VoidCallback? onClose;

  /// Kapatma butonu konumu.
  final AlignmentGeometry? closeButtonAlignment;

  // ═══════════════════════════════════════════════════════════════════
  // HEADER
  // ═══════════════════════════════════════════════════════════════════

  /// Özel header widget'ı. Verilirse title/subtitle/icon alanı yok sayılır.
  final Widget? header;

  /// Header padding.
  final EdgeInsetsGeometry? headerPadding;

  /// Header dekorasyonu.
  final BoxDecoration? headerDecoration;

  /// Header altına ayırıcı çizgi.
  final bool? headerSeparator;

  /// Header ayırıcı rengi.
  final Color? headerSeparatorColor;

  /// Header ayırıcı yüksekliği.
  final double? headerSeparatorHeight;

  // ═══════════════════════════════════════════════════════════════════
  // FOOTER
  // ═══════════════════════════════════════════════════════════════════

  /// Özel footer widget'ı. Verilirse aksiyon butonları yok sayılır.
  final Widget? footer;

  /// Footer padding.
  final EdgeInsetsGeometry? footerPadding;

  /// Footer dekorasyonu.
  final BoxDecoration? footerDecoration;

  /// Footer üstüne ayırıcı çizgi.
  final bool? footerSeparator;

  /// Footer ayırıcı rengi.
  final Color? footerSeparatorColor;

  /// Footer ayırıcı yüksekliği.
  final double? footerSeparatorHeight;

  // ═══════════════════════════════════════════════════════════════════
  // AKSİYONLAR
  // ═══════════════════════════════════════════════════════════════════

  /// Birincil aksiyon widget'ı. Verilirse [primaryActionText] yok sayılır.
  final Widget? primaryAction;

  /// Birincil aksiyon buton metni.
  final String? primaryActionText;

  /// Birincil aksiyon callback.
  final VoidCallback? onPrimaryAction;

  /// İkincil aksiyon widget'ı.
  final Widget? secondaryAction;

  /// İkincil aksiyon buton metni.
  final String? secondaryActionText;

  /// İkincil aksiyon callback.
  final VoidCallback? onSecondaryAction;

  /// Buton yönü (yatay / dikey). Varsayılan: horizontal.
  final Axis? actionsAxis;

  /// Butonlar arası boşluk. Varsayılan: 12
  final double? actionsSpacing;

  /// Aksiyonlar padding.
  final EdgeInsetsGeometry? actionsPadding;

  // ═══════════════════════════════════════════════════════════════════
  // RENK & ARKA PLAN
  // ═══════════════════════════════════════════════════════════════════

  /// Arka plan rengi.
  final Color? backgroundColor;

  /// Arkadaki karartma rengi (barrier).
  final Color? barrierColor;

  /// Surface tint rengi (Material 3).
  final Color? surfaceTintColor;

  /// Gradient arka plan. Verilirse [backgroundColor] yok sayılır.
  final Gradient? gradient;

  /// Gölge rengi.
  final Color? shadowColor;

  // ═══════════════════════════════════════════════════════════════════
  // BOYUT
  // ═══════════════════════════════════════════════════════════════════

  /// Sabit yükseklik.
  final double? height;

  /// Minimum yükseklik.
  final double? minHeight;

  /// Maksimum yükseklik.
  final double? maxHeight;

  /// Sabit genişlik.
  final double? width;

  /// Tüm içerik için dış padding.
  final EdgeInsetsGeometry? padding;

  /// Sadece ana içerik alanı padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Dış margin (sheet etrafındaki boşluk).
  final EdgeInsetsGeometry? margin;

  // ═══════════════════════════════════════════════════════════════════
  // ŞEKİL & KENARLIK
  // ═══════════════════════════════════════════════════════════════════

  /// Dört köşe aynı radius. Varsayılan: 16
  final double? borderRadius;

  /// Sol üst köşe radius.
  final double? topLeftRadius;

  /// Sağ üst köşe radius.
  final double? topRightRadius;

  /// Sol alt köşe radius.
  final double? bottomLeftRadius;

  /// Sağ alt köşe radius.
  final double? bottomRightRadius;

  /// Özel kenarlık.
  final BoxBorder? border;

  /// Kenarlık rengi kısayolu.
  final Color? borderColor;

  /// Kenarlık kalınlığı kısayolu.
  final double? borderWidth;

  /// Özel şekil (ShapeBorder).
  final ShapeBorder? shape;

  // ═══════════════════════════════════════════════════════════════════
  // YÜKSEKLİK & GÖLGE
  // ═══════════════════════════════════════════════════════════════════

  /// Elevation.
  final double? elevation;

  // ═══════════════════════════════════════════════════════════════════
  // SCROLL
  // ═══════════════════════════════════════════════════════════════════

  /// `true` ise içerik SingleChildScrollView ile sarılır.
  final bool? isScrollable;

  /// Scroll controller.
  final ScrollController? scrollController;

  /// Scroll fiziği.
  final ScrollPhysics? scrollPhysics;

  /// Scroll padding.
  final EdgeInsetsGeometry? scrollPadding;

  /// `true` ise scroll view shrinkWrap aktif olur.
  final bool? shrinkWrap;

  // ═══════════════════════════════════════════════════════════════════
  // DRAGGABLE
  // ═══════════════════════════════════════════════════════════════════

  /// `true` ise DraggableScrollableSheet olarak açılır.
  final bool? isDraggable;

  /// Başlangıç yükseklik oranı (0.0 – 1.0). Varsayılan: 0.5
  final double? initialChildSize;

  /// Minimum yükseklik oranı. Varsayılan: 0.25
  final double? minChildSize;

  /// Maksimum yükseklik oranı. Varsayılan: 0.9
  final double? maxChildSize;

  /// Snap noktalarına yapışma.
  final bool? snap;

  /// Özel snap noktaları.
  final List<double>? snapSizes;

  /// Minimum boyuta ulaşınca kapansın mı.
  final bool? shouldCloseOnMinExtent;

  // ═══════════════════════════════════════════════════════════════════
  // DAVRANIŞ
  // ═══════════════════════════════════════════════════════════════════

  /// Dışına tıklayınca kapansın mı. Varsayılan: true.
  final bool? isDismissible;

  /// Sürükleyerek kapatma. Varsayılan: true.
  final bool? enableDrag;

  /// `true` ise modal olarak açılır (showModalBottomSheet).
  final bool? isModal;

  /// Root navigator kullan.
  final bool? useRootNavigator;

  /// SafeArea uygula.
  final bool? useSafeArea;

  // ═══════════════════════════════════════════════════════════════════
  // ANİMASYON
  // ═══════════════════════════════════════════════════════════════════

  /// Açılma/kapanma animasyon süresi.
  final Duration? animationDuration;

  /// Animasyon eğrisi.
  final Curve? animationCurve;

  /// Özel animasyon controller.
  final AnimationController? transitionAnimationController;

  // ═══════════════════════════════════════════════════════════════════
  // ERİŞİLEBİLİRLİK
  // ═══════════════════════════════════════════════════════════════════

  /// Semantik etiket.
  final String? semanticLabel;

  /// Route ayarları.
  final RouteSettings? routeSettings;

  // ═══════════════════════════════════════════════════════════════════
  // CONSTRAINTS
  // ═══════════════════════════════════════════════════════════════════

  /// Boyut kısıtlamaları.
  final BoxConstraints? constraints;

  // ═══════════════════════════════════════════════════════════════════
  // CALLBACK
  // ═══════════════════════════════════════════════════════════════════

  /// Sheet kapatıldığında çağrılır.
  final VoidCallback? onDismissed;

  // ═══════════════════════════════════════════════════════════════════
  // YARDIMCILAR
  // ═══════════════════════════════════════════════════════════════════

  BorderRadiusGeometry get _resolvedBorderRadius {
    if (topLeftRadius != null ||
        topRightRadius != null ||
        bottomLeftRadius != null ||
        bottomRightRadius != null) {
      return BorderRadius.only(
        topLeft: Radius.circular(topLeftRadius ?? 0),
        topRight: Radius.circular(topRightRadius ?? 0),
        bottomLeft: Radius.circular(bottomLeftRadius ?? 0),
        bottomRight: Radius.circular(bottomRightRadius ?? 0),
      );
    }
    final r = borderRadius ?? 16;
    return BorderRadius.vertical(top: Radius.circular(r));
  }

  BoxBorder? get _resolvedBorder {
    if (border != null) return border;
    if (borderColor != null) {
      return Border.all(color: borderColor!, width: borderWidth ?? 1);
    }
    return null;
  }

  BoxConstraints? get _resolvedConstraints {
    if (constraints != null) return constraints;
    if (minHeight != null || maxHeight != null || width != null) {
      return BoxConstraints(
        minHeight: minHeight ?? 0,
        maxHeight: maxHeight ?? double.infinity,
        minWidth: width ?? 0,
        maxWidth: width ?? double.infinity,
      );
    }
    return null;
  }

  // ═══════════════════════════════════════════════════════════════════
  // HANDLE
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildHandle() {
    if (!(showHandle ?? true)) return const SizedBox.shrink();

    return Container(
      margin: handleMargin ?? const EdgeInsets.symmetric(vertical: 8),
      width: handleWidth ?? 40,
      height: handleHeight ?? 4,
      decoration:
          handleDecoration ??
          BoxDecoration(
            color: handleColor ?? Colors.grey.shade300,
            borderRadius: BorderRadius.circular((handleHeight ?? 4) / 2),
          ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // CLOSE BUTTON
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildCloseButton(BuildContext context) {
    if (!(showCloseButton ?? false)) return const SizedBox.shrink();

    return Align(
      alignment: closeButtonAlignment ?? Alignment.topRight,
      child: GestureDetector(
        onTap: onClose ?? () => Navigator.pop(context),
        child:
            closeIcon ??
            Icon(
              Icons.close,
              size: closeIconSize ?? 24,
              color: closeIconColor ?? Colors.grey.shade600,
            ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // HEADER
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildHeader(BuildContext context) {
    if (header != null) {
      return Container(
        padding: headerPadding,
        decoration: headerDecoration,
        child: header,
      );
    }

    // İkon / Resim / Başlık / Alt Başlık / Kapat yoksa boş
    final hasIcon = icon != null || iconData != null;
    final hasTitle = title != null || titleWidget != null;
    final hasSubtitle = subtitle != null || subtitleWidget != null;
    final hasClose = showCloseButton ?? false;
    final hasImage = image != null;

    if (!hasIcon && !hasTitle && !hasSubtitle && !hasClose && !hasImage) {
      return const SizedBox.shrink();
    }

    return Container(
      padding:
          headerPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: headerDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Kapatma butonu
          if (hasClose) _buildCloseButton(context),

          // Resim
          if (hasImage) ...[image!, const SizedBox(height: 12)],

          // İkon
          if (hasIcon) ...[
            icon ?? Icon(iconData, size: iconSize ?? 40, color: iconColor),
            const SizedBox(height: 12),
          ],

          // Başlık
          if (hasTitle)
            titleWidget ??
                Text(
                  title!,
                  textAlign: titleAlignment ?? TextAlign.center,
                  style:
                      titleStyle ??
                      TextStyle(
                        color: titleColor,
                        fontSize: titleFontSize ?? 18,
                        fontWeight: titleFontWeight ?? FontWeight.w600,
                      ),
                ),

          // Alt başlık
          if (hasSubtitle) ...[
            const SizedBox(height: 4),
            subtitleWidget ??
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style:
                      subtitleStyle ??
                      TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
          ],
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // CONTENT
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildContent() {
    // Mesaj
    final messageContent =
        messageWidget ??
        (message != null
            ? Text(
                message!,
                style:
                    messageStyle ??
                    TextStyle(color: Colors.grey.shade700, fontSize: 14),
                textAlign: TextAlign.center,
              )
            : null);

    final effectivePadding =
        contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    Widget content;

    if (child != null) {
      content = child!;
    } else if (children != null) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (messageContent != null) ...[
            messageContent,
            const SizedBox(height: 12),
          ],
          ...children!,
        ],
      );
    } else if (messageContent != null) {
      content = messageContent;
    } else {
      return const SizedBox.shrink();
    }

    content = Padding(padding: effectivePadding, child: content);

    if (isScrollable ?? false) {
      content = SingleChildScrollView(
        controller: scrollController,
        physics: scrollPhysics,
        padding: scrollPadding,
        child: content,
      );
      if (shrinkWrap ?? true) {
        // scroll var ama maxHeight ile sınırlandır
      }
    }

    return content;
  }

  // ═══════════════════════════════════════════════════════════════════
  // FOOTER & AKSİYONLAR
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildFooter(BuildContext context) {
    Widget? footerContent;

    if (footer != null) {
      footerContent = footer;
    } else {
      final hasPrimary = primaryAction != null || primaryActionText != null;
      final hasSecondary =
          secondaryAction != null || secondaryActionText != null;

      if (!hasPrimary && !hasSecondary) return const SizedBox.shrink();

      final primaryBtn =
          primaryAction ??
          (primaryActionText != null
              ? ElevatedButton(
                  onPressed: onPrimaryAction ?? () => Navigator.pop(context),
                  child: Text(primaryActionText!),
                )
              : null);

      final secondaryBtn =
          secondaryAction ??
          (secondaryActionText != null
              ? OutlinedButton(
                  onPressed: onSecondaryAction ?? () => Navigator.pop(context),
                  child: Text(secondaryActionText!),
                )
              : null);

      final axis = actionsAxis ?? Axis.horizontal;
      final spacing = actionsSpacing ?? 12;

      final buttons = [
        if (secondaryBtn != null)
          axis == Axis.horizontal
              ? Expanded(child: secondaryBtn)
              : SizedBox(width: double.infinity, child: secondaryBtn),
        if (secondaryBtn != null && primaryBtn != null)
          axis == Axis.horizontal
              ? SizedBox(width: spacing)
              : SizedBox(height: spacing),
        if (primaryBtn != null)
          axis == Axis.horizontal
              ? Expanded(child: primaryBtn)
              : SizedBox(width: double.infinity, child: primaryBtn),
      ];

      footerContent = axis == Axis.horizontal
          ? Row(children: buttons)
          : Column(mainAxisSize: MainAxisSize.min, children: buttons);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (footerSeparator ?? false)
          Divider(
            height: footerSeparatorHeight ?? 1,
            thickness: footerSeparatorHeight ?? 1,
            color: footerSeparatorColor,
          ),
        Container(
          padding:
              footerPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: footerDecoration,
          child: footerContent,
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    final body = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle
        _buildHandle(),

        // Header
        _buildHeader(context),

        // Header separator
        if (headerSeparator ?? false)
          Divider(
            height: headerSeparatorHeight ?? 1,
            thickness: headerSeparatorHeight ?? 1,
            color: headerSeparatorColor,
          ),

        // İçerik
        if (isScrollable ?? false)
          Flexible(child: _buildContent())
        else
          _buildContent(),

        // Footer
        _buildFooter(context),
      ],
    );

    // ── Container Dekorasyon ──
    Widget sheet = Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      constraints: _resolvedConstraints,
      decoration: BoxDecoration(
        color: gradient != null ? null : (backgroundColor ?? Colors.white),
        gradient: gradient,
        borderRadius: _resolvedBorderRadius,
        border: _resolvedBorder,
        boxShadow: shadowColor != null
            ? [
                BoxShadow(
                  color: shadowColor!,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ]
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        left: useSafeArea ?? true,
        right: useSafeArea ?? true,
        bottom: useSafeArea ?? true,
        child: body,
      ),
    );

    return sheet;
  }

  // ═══════════════════════════════════════════════════════════════════
  // STATIC SHOW METODU
  // ═══════════════════════════════════════════════════════════════════

  /// BottomSheet'i gösterir ve kapanınca opsiyonel bir değer döndürür.
  ///
  /// ```dart
  /// final result = await CostumBottomSheet.show<bool>(
  ///   context,
  ///   title: 'Emin misiniz?',
  ///   message: 'Bu işlem geri alınamaz.',
  ///   primaryActionText: 'Evet',
  ///   secondaryActionText: 'Hayır',
  ///   onPrimaryAction: () => Navigator.pop(context, true),
  ///   onSecondaryAction: () => Navigator.pop(context, false),
  /// );
  /// ```
  static Future<T?> show<T>(
    BuildContext context, {
    // ── İçerik ──
    Widget? child,
    List<Widget>? children,
    String? title,
    Widget? titleWidget,
    TextStyle? titleStyle,
    Color? titleColor,
    double? titleFontSize,
    FontWeight? titleFontWeight,
    TextAlign? titleAlignment,
    String? subtitle,
    Widget? subtitleWidget,
    TextStyle? subtitleStyle,
    String? message,
    Widget? messageWidget,
    TextStyle? messageStyle,
    Widget? icon,
    IconData? iconData,
    double? iconSize,
    Color? iconColor,
    Widget? image,

    // ── Handle ──
    bool? showHandle,
    Color? handleColor,
    double? handleWidth,
    double? handleHeight,
    EdgeInsetsGeometry? handleMargin,
    BoxDecoration? handleDecoration,

    // ── Close ──
    bool? showCloseButton,
    Widget? closeIcon,
    Color? closeIconColor,
    double? closeIconSize,
    VoidCallback? onClose,
    AlignmentGeometry? closeButtonAlignment,

    // ── Header ──
    Widget? header,
    EdgeInsetsGeometry? headerPadding,
    BoxDecoration? headerDecoration,
    bool? headerSeparator,
    Color? headerSeparatorColor,
    double? headerSeparatorHeight,

    // ── Footer ──
    Widget? footer,
    EdgeInsetsGeometry? footerPadding,
    BoxDecoration? footerDecoration,
    bool? footerSeparator,
    Color? footerSeparatorColor,
    double? footerSeparatorHeight,

    // ── Aksiyonlar ──
    Widget? primaryAction,
    String? primaryActionText,
    VoidCallback? onPrimaryAction,
    Widget? secondaryAction,
    String? secondaryActionText,
    VoidCallback? onSecondaryAction,
    Axis? actionsAxis,
    double? actionsSpacing,
    EdgeInsetsGeometry? actionsPadding,

    // ── Renk ──
    Color? backgroundColor,
    Color? barrierColor,
    Color? surfaceTintColor,
    Gradient? gradient,
    Color? shadowColor,

    // ── Boyut ──
    double? height,
    double? minHeight,
    double? maxHeight,
    double? width,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? margin,

    // ── Şekil ──
    double? borderRadius,
    double? topLeftRadius,
    double? topRightRadius,
    double? bottomLeftRadius,
    double? bottomRightRadius,
    BoxBorder? border,
    Color? borderColor,
    double? borderWidth,
    ShapeBorder? shape,

    // ── Elevation ──
    double? elevation,

    // ── Scroll ──
    bool? isScrollable,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    EdgeInsetsGeometry? scrollPadding,
    bool? shrinkWrap,

    // ── Draggable ──
    bool? isDraggable,
    double? initialChildSize,
    double? minChildSize,
    double? maxChildSize,
    bool? snap,
    List<double>? snapSizes,
    bool? shouldCloseOnMinExtent,

    // ── Davranış ──
    bool? isDismissible,
    bool? enableDrag,
    bool? useRootNavigator,
    bool? useSafeArea,

    // ── Animasyon ──
    AnimationController? transitionAnimationController,

    // ── Erişilebilirlik ──
    String? semanticLabel,
    RouteSettings? routeSettings,

    // ── Constraints ──
    BoxConstraints? constraints,

    // ── Callback ──
    VoidCallback? onDismissed,
  }) {
    final sheet = CostumBottomSheet(
      child: child,
      children: children,
      title: title,
      titleWidget: titleWidget,
      titleStyle: titleStyle,
      titleColor: titleColor,
      titleFontSize: titleFontSize,
      titleFontWeight: titleFontWeight,
      titleAlignment: titleAlignment,
      subtitle: subtitle,
      subtitleWidget: subtitleWidget,
      subtitleStyle: subtitleStyle,
      message: message,
      messageWidget: messageWidget,
      messageStyle: messageStyle,
      icon: icon,
      iconData: iconData,
      iconSize: iconSize,
      iconColor: iconColor,
      image: image,
      showHandle: showHandle,
      handleColor: handleColor,
      handleWidth: handleWidth,
      handleHeight: handleHeight,
      handleMargin: handleMargin,
      handleDecoration: handleDecoration,
      showCloseButton: showCloseButton,
      closeIcon: closeIcon,
      closeIconColor: closeIconColor,
      closeIconSize: closeIconSize,
      onClose: onClose,
      closeButtonAlignment: closeButtonAlignment,
      header: header,
      headerPadding: headerPadding,
      headerDecoration: headerDecoration,
      headerSeparator: headerSeparator,
      headerSeparatorColor: headerSeparatorColor,
      headerSeparatorHeight: headerSeparatorHeight,
      footer: footer,
      footerPadding: footerPadding,
      footerDecoration: footerDecoration,
      footerSeparator: footerSeparator,
      footerSeparatorColor: footerSeparatorColor,
      footerSeparatorHeight: footerSeparatorHeight,
      primaryAction: primaryAction,
      primaryActionText: primaryActionText,
      onPrimaryAction: onPrimaryAction,
      secondaryAction: secondaryAction,
      secondaryActionText: secondaryActionText,
      onSecondaryAction: onSecondaryAction,
      actionsAxis: actionsAxis,
      actionsSpacing: actionsSpacing,
      actionsPadding: actionsPadding,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      surfaceTintColor: surfaceTintColor,
      gradient: gradient,
      shadowColor: shadowColor,
      height: height,
      minHeight: minHeight,
      maxHeight: maxHeight,
      width: width,
      padding: padding,
      contentPadding: contentPadding,
      margin: margin,
      borderRadius: borderRadius,
      topLeftRadius: topLeftRadius,
      topRightRadius: topRightRadius,
      bottomLeftRadius: bottomLeftRadius,
      bottomRightRadius: bottomRightRadius,
      border: border,
      borderColor: borderColor,
      borderWidth: borderWidth,
      shape: shape,
      elevation: elevation,
      isScrollable: isScrollable,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      scrollPadding: scrollPadding,
      shrinkWrap: shrinkWrap,
      isDraggable: isDraggable,
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      snap: snap,
      snapSizes: snapSizes,
      shouldCloseOnMinExtent: shouldCloseOnMinExtent,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useSafeArea: useSafeArea,
      onDismissed: onDismissed,
    );

    // ── Draggable Mode ──
    if (isDraggable ?? false) {
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        isDismissible: isDismissible ?? true,
        enableDrag: enableDrag ?? true,
        useRootNavigator: useRootNavigator ?? false,
        backgroundColor: Colors.transparent,
        barrierColor: barrierColor,
        elevation: elevation,
        shape: shape,
        constraints: constraints,
        routeSettings: routeSettings,
        transitionAnimationController: transitionAnimationController,
        builder: (ctx) {
          return DraggableScrollableSheet(
            initialChildSize: initialChildSize ?? 0.5,
            minChildSize: minChildSize ?? 0.25,
            maxChildSize: maxChildSize ?? 0.9,
            snap: snap ?? false,
            snapSizes: snapSizes,
            shouldCloseOnMinExtent: shouldCloseOnMinExtent ?? true,
            builder: (_, controller) {
              return CostumBottomSheet(
                child: child,
                children: children,
                title: title,
                titleWidget: titleWidget,
                titleStyle: titleStyle,
                titleColor: titleColor,
                titleFontSize: titleFontSize,
                titleFontWeight: titleFontWeight,
                titleAlignment: titleAlignment,
                subtitle: subtitle,
                subtitleWidget: subtitleWidget,
                subtitleStyle: subtitleStyle,
                message: message,
                messageWidget: messageWidget,
                messageStyle: messageStyle,
                icon: icon,
                iconData: iconData,
                iconSize: iconSize,
                iconColor: iconColor,
                image: image,
                showHandle: showHandle,
                handleColor: handleColor,
                handleWidth: handleWidth,
                handleHeight: handleHeight,
                handleMargin: handleMargin,
                handleDecoration: handleDecoration,
                showCloseButton: showCloseButton,
                closeIcon: closeIcon,
                closeIconColor: closeIconColor,
                closeIconSize: closeIconSize,
                onClose: onClose,
                closeButtonAlignment: closeButtonAlignment,
                header: header,
                headerPadding: headerPadding,
                headerDecoration: headerDecoration,
                headerSeparator: headerSeparator,
                headerSeparatorColor: headerSeparatorColor,
                headerSeparatorHeight: headerSeparatorHeight,
                footer: footer,
                footerPadding: footerPadding,
                footerDecoration: footerDecoration,
                footerSeparator: footerSeparator,
                footerSeparatorColor: footerSeparatorColor,
                footerSeparatorHeight: footerSeparatorHeight,
                primaryAction: primaryAction,
                primaryActionText: primaryActionText,
                onPrimaryAction: onPrimaryAction,
                secondaryAction: secondaryAction,
                secondaryActionText: secondaryActionText,
                onSecondaryAction: onSecondaryAction,
                actionsAxis: actionsAxis,
                actionsSpacing: actionsSpacing,
                actionsPadding: actionsPadding,
                backgroundColor: backgroundColor,
                gradient: gradient,
                shadowColor: shadowColor,
                height: height,
                minHeight: minHeight,
                maxHeight: maxHeight,
                width: width,
                padding: padding,
                contentPadding: contentPadding,
                margin: margin,
                borderRadius: borderRadius,
                topLeftRadius: topLeftRadius,
                topRightRadius: topRightRadius,
                bottomLeftRadius: bottomLeftRadius,
                bottomRightRadius: bottomRightRadius,
                border: border,
                borderColor: borderColor,
                borderWidth: borderWidth,
                elevation: elevation,
                isScrollable: true,
                scrollController: controller,
                scrollPhysics: scrollPhysics,
                scrollPadding: scrollPadding,
                useSafeArea: useSafeArea,
              );
            },
          );
        },
      ).whenComplete(() => onDismissed?.call());
    }

    // ── Normal Modal Mode ──
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollable ?? (height != null || maxHeight != null),
      isDismissible: isDismissible ?? true,
      enableDrag: enableDrag ?? true,
      useRootNavigator: useRootNavigator ?? false,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor,
      elevation: elevation,
      shape: shape,
      constraints: constraints,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      builder: (_) => sheet,
    ).whenComplete(() => onDismissed?.call());
  }
}
