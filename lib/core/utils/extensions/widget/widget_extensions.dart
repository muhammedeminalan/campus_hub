import 'package:flutter/material.dart';

/// ## WidgetDecorationExtensions
///
/// Widget'lara dekorasyon, etkileşim ve görünürlük kısayolları sağlar.
///
/// **Kapsam:** Yuvarlak kapsül, arka plan, gölge, dokunma, opacity,
/// görünürlük, tooltip, Hero, AspectRatio, ignore/absorb pointer, SafeArea.
///
/// **Not:** Padding, margin, center, expanded, sized gibi kısayollar
/// diğer extension dosyalarında tanımlıdır. Burada tekrar edilmez.
///
/// ### Kullanım Örnekleri
/// ```dart
/// // Yuvarlak kapsül
/// Text('Merhaba').roundedBox(radius: 12, backgroundColor: Colors.blue)
///
/// // Arka plan
/// Icon(Icons.star).withBackground(Colors.amber, radius: 8)
///
/// // Dokunma
/// Text('Tıkla').onTap(() => print('tapped'))
///
/// // Görünürlük
/// Text('Gizli').withVisibility(false)
///
/// // Opacity
/// Text('Soluk').withOpacity(0.5)
/// ```
extension WidgetDecorationExtensions on Widget {
  // ═══════════════════════════════════════════════════════════════════
  // DEKORASYON
  // ═══════════════════════════════════════════════════════════════════

  /// Widget'ı yuvarlak / rounded bir kutu içine sarar.
  ///
  /// - [radius] : Köşe yuvarlaklığı. `null` ise tam yuvarlak (9999).
  /// - [backgroundColor] : Kutu arka plan rengi.
  /// - [gradient] : Arka plan gradyanı. `backgroundColor` ile birlikte
  ///   verilirse gradient öncelik alır.
  /// - [border] : Kenarlık.
  /// - [shadow] : Kutu gölgeleri.
  /// - [innerPadding] : İçerik ile kutu arası boşluk.
  /// - [outerMargin] : Kutu ile dış widget arası boşluk.
  /// - [width], [height] : Sabit boyut kısıtlaması.
  /// - [alignment] : İçerik hizalaması.
  /// - [clipBehavior] : Taşan içeriğin kırpılma davranışı.
  Widget roundedBox({
    double? radius,
    Color? backgroundColor,
    Gradient? gradient,
    Border? border,
    List<BoxShadow>? shadow,
    EdgeInsetsGeometry? innerPadding,
    EdgeInsetsGeometry? outerMargin,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    final borderRadius = BorderRadius.circular(radius ?? 9999);

    Widget child = this;

    if (innerPadding != null) {
      child = Padding(padding: innerPadding, child: child);
    }

    if (alignment != null) {
      child = Align(alignment: alignment, child: child);
    }

    child = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        borderRadius: borderRadius,
        border: border,
        boxShadow: shadow,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: clipBehavior,
        child: child,
      ),
    );

    if (width != null || height != null) {
      child = SizedBox(width: width, height: height, child: child);
    }

    if (outerMargin != null) {
      child = Padding(padding: outerMargin, child: child);
    }

    return child;
  }

  /// Widget'a arka plan rengi uygular.
  ///
  /// - [color] : Arka plan rengi.
  /// - [radius] : Köşe yuvarlaklığı. `0` ise düz dikdörtgen.
  /// - [innerPadding] : İçerik boşluğu.
  /// - [outerMargin] : Dış boşluk.
  Widget withBackground(
    Color color, {
    double radius = 0,
    EdgeInsetsGeometry? innerPadding,
    EdgeInsetsGeometry? outerMargin,
  }) {
    return roundedBox(
      radius: radius,
      backgroundColor: color,
      innerPadding: innerPadding,
      outerMargin: outerMargin,
      clipBehavior: radius == 0 ? Clip.none : Clip.antiAlias,
    );
  }

  /// Widget'a kutu gölgesi ekler.
  ///
  /// - [color] : Gölge rengi (varsayılan: siyah %10).
  /// - [blurRadius] : Bulanıklık yarıçapı.
  /// - [offset] : Gölge konumu.
  /// - [spreadRadius] : Yayılma yarıçapı.
  /// - [borderRadius] : Köşe yuvarlama.
  Widget withShadow({
    Color color = const Color(0x1A000000),
    double blurRadius = 8,
    Offset offset = const Offset(0, 2),
    double spreadRadius = 0,
    double borderRadius = 0,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: blurRadius,
            offset: offset,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
      child: this,
    );
  }

  /// Widget'ı bir [Card] içine sarar.
  ///
  /// - [elevation] : Kart yüksekliği (varsayılan: 2).
  /// - [color] : Kart arka plan rengi.
  /// - [radius] : Köşe yuvarlaklığı.
  /// - [margin] : Kart dış boşluğu.
  Widget asCard({
    double elevation = 2,
    Color? color,
    double radius = 12,
    EdgeInsetsGeometry? margin,
  }) {
    return Card(
      elevation: elevation,
      color: color,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: this,
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // ETKİLEŞİM
  // ═══════════════════════════════════════════════════════════════════

  /// Widget'a dokunma (tap) davranışı ekler.
  ///
  /// - [onTap] : Dokunulduğunda çalışacak callback.
  /// - [borderRadius] : Kırpma yarıçapı (opsiyonel).
  /// - [behavior] : Hit test davranışı.
  Widget onTap(
    VoidCallback onTap, {
    BorderRadius? borderRadius,
    HitTestBehavior behavior = HitTestBehavior.opaque,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: behavior,
      child: borderRadius == null
          ? this
          : ClipRRect(borderRadius: borderRadius, child: this),
    );
  }

  /// Widget'a InkWell (Material ripple) efekti ekler.
  ///
  /// - [onTap] : Dokunulduğunda çalışacak callback.
  /// - [borderRadius] : Ripple efekti için köşe yarıçapı.
  /// - [splashColor] : Ripple rengi.
  /// - [highlightColor] : Basılı tutma rengi.
  Widget onInkTap(
    VoidCallback onTap, {
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        splashColor: splashColor,
        highlightColor: highlightColor,
        child: this,
      ),
    );
  }

  /// Widget'a uzun basma davranışı ekler.
  ///
  /// - [onLongPress] : Uzun basılınca çalışacak callback.
  Widget onLongPress(VoidCallback onLongPress) {
    return GestureDetector(onLongPress: onLongPress, child: this);
  }

  // ═══════════════════════════════════════════════════════════════════
  // GÖRÜNÜRLÜK & OPACITY
  // ═══════════════════════════════════════════════════════════════════

  /// Widget'ın görünürlüğünü kontrol eder.
  ///
  /// - [visible] : `true` ise widget gösterilir, `false` ise gizlenir.
  /// - [maintainSize] : `true` ise gizlendiğinde yer kaplamaya devam eder.
  Widget withVisibility(bool visible, {bool maintainSize = false}) {
    return Visibility(
      visible: visible,
      maintainSize: maintainSize,
      maintainAnimation: maintainSize,
      maintainState: maintainSize,
      child: this,
    );
  }

  /// Widget'ın opaklığını ayarlar.
  ///
  /// - [opacity] : 0.0 (tamamen saydam) ile 1.0 (tamamen opak) arası.
  /// - [alwaysIncludeSemantics] : Saydam olsa bile erişilebilirlik ağacında
  ///   kalıp kalmayacağını belirler.
  Widget withOpacity(double opacity, {bool alwaysIncludeSemantics = false}) {
    return Opacity(
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      child: this,
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // DÖNÜŞTÜRME & KONUM
  // ═══════════════════════════════════════════════════════════════════

  /// Widget'ı belirtilen açıyla döndürür.
  ///
  /// - [angle] : Dönüş açısı (radyan cinsinden).
  /// - [alignment] : Dönüş merkezi (varsayılan: center).
  Widget rotated(double angle, {Alignment alignment = Alignment.center}) {
    return Transform.rotate(angle: angle, alignment: alignment, child: this);
  }

  /// Widget'ı X ve Y ekseninde ölçekler.
  ///
  /// - [scale] : Ölçek faktörü (1.0 = orijinal boyut).
  /// - [alignment] : Ölçekleme merkezi.
  Widget scaled(double scale, {Alignment alignment = Alignment.center}) {
    return Transform.scale(scale: scale, alignment: alignment, child: this);
  }

  /// Widget'ı X ve Y ekseninde kaydırır.
  ///
  /// - [offset] : Kaydırma miktarı.
  Widget translated(Offset offset) {
    return Transform.translate(offset: offset, child: this);
  }

  // ═══════════════════════════════════════════════════════════════════
  // YARDIMCI SARIMLAYICILAR
  // ═══════════════════════════════════════════════════════════════════

  /// Widget'a tooltip ekler.
  ///
  /// - [message] : Tooltip metni.
  Widget withTooltip(String message) {
    return Tooltip(message: message, child: this);
  }

  /// Widget'ı [Hero] animasyonu ile sarar.
  ///
  /// - [tag] : Hero etiket değeri (benzersiz olmalı).
  Widget asHero(Object tag) {
    return Hero(tag: tag, child: this);
  }

  /// Widget'ı belirtilen en-boy oranıyla kısıtlar.
  ///
  /// - [ratio] : En-boy oranı (örn. 16/9).
  Widget withAspectRatio(double ratio) {
    return AspectRatio(aspectRatio: ratio, child: this);
  }

  /// Widget'ı [SafeArea] ile sarar.
  ///
  /// - [top], [bottom], [left], [right] : Hangi kenarların korunacağını belirler.
  Widget safeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // DOKUNMA KONTROLÜ
  // ═══════════════════════════════════════════════════════════════════

  /// Widget'ın dokunma olaylarını yok saymasını sağlar.
  ///
  /// - [ignoring] : `true` ise dokunmalar geçirilir (alt widget'a ulaşır).
  Widget ignorePointer({bool ignoring = true}) {
    return IgnorePointer(ignoring: ignoring, child: this);
  }

  /// Widget'ın dokunma olaylarını yutmasını sağlar.
  ///
  /// - [absorbing] : `true` ise dokunmalar alt widget'a ulaşmaz.
  Widget absorbPointer({bool absorbing = true}) {
    return AbsorbPointer(absorbing: absorbing, child: this);
  }

  // ═══════════════════════════════════════════════════════════════════
  // KLİP
  // ═══════════════════════════════════════════════════════════════════

  /// Widget'ı dikdörtgen olarak kırpar.
  ///
  /// - [clipBehavior] : Kırpma davranışı.
  Widget clipRect({Clip clipBehavior = Clip.hardEdge}) {
    return ClipRect(clipBehavior: clipBehavior, child: this);
  }

  /// Widget'ı oval / daire olarak kırpar.
  Widget clipOval() {
    return ClipOval(child: this);
  }

  /// Widget'ı dairesel (circular) bir container içine yerleştirir.
  ///
  /// Avatar, profil fotoğrafı gibi daire içinde gösterilmesi gereken
  /// widget'lar için idealdir.
  ///
  /// - [size] : Dairenin çapı (genişlik & yükseklik).
  /// - [backgroundColor] : Dairenin arka plan rengi.
  /// - [border] : Opsiyonel kenarlık.
  /// - [shadow] : Opsiyonel gölge listesi.
  ///
  /// ```dart
  /// Image.network(url).asCircle(size: 80, backgroundColor: Colors.grey);
  /// ```
  Widget asCircle({
    double? size,
    Color? backgroundColor,
    BoxBorder? border,
    List<BoxShadow>? shadow,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: border,
        boxShadow: shadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: this,
    );
  }

  /// Widget'ı yuvarlak köşeli dikdörtgen olarak kırpar.
  ///
  /// - [radius] : Köşe yuvarlaklığı.
  Widget clipRounded(double radius) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }

  /// Widget'a kenarlık çizer.
  ///
  /// - [color] : Kenarlık rengi.
  /// - [width] : Kenarlık kalınlığı.
  /// - [radius] : Köşe yuvarlaklığı.
  Widget withBorder({
    Color color = const Color(0xFFE0E0E0),
    double width = 1,
    double radius = 0,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: width),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: this,
    );
  }
}
