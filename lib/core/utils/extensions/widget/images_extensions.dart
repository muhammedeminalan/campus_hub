import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════
// IMAGE WIDGET EXTENSIONS
// ═══════════════════════════════════════════════════════════════════════

/// Image widget'ına kısayol metodları ekler.
///
/// ### Kullanım Örnekleri
/// ```dart
/// Image.asset('assets/photo.png')
///   .rounded(16)
///   .shadow()
///   .bordered(color: Colors.white, width: 3)
///
/// Image.network(url)
///   .circular(size: 80)
///   .colorFiltered(color: Colors.blue, blendMode: BlendMode.colorBurn)
/// ```
extension ImageExtensions on Image {
  // ─── Şekil ─────────────────────────────────────────────────────

  /// Köşeleri yuvarlatılmış resim.
  Widget rounded(double radius, {Clip clip = Clip.antiAlias}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: clip,
      child: this,
    );
  }

  /// Daire şeklinde kırpılmış resim.
  Widget circular({double? size}) {
    final child = size != null
        ? SizedBox(width: size, height: size, child: this)
        : this;
    return ClipOval(child: child);
  }

  /// Kenarlık ekler.
  Widget bordered({
    Color color = Colors.white,
    double width = 2,
    double? radius,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: width),
        borderRadius: shape == BoxShape.rectangle && radius != null
            ? BorderRadius.circular(radius)
            : null,
        shape: shape,
      ),
      child: shape == BoxShape.circle
          ? ClipOval(child: this)
          : radius != null
          ? ClipRRect(borderRadius: BorderRadius.circular(radius), child: this)
          : this,
    );
  }

  /// Dairesel kenarlıklı avatar tarzı resim.
  ///
  /// ```dart
  /// Image.network(url).circleAvatar(size: 60, borderColor: Colors.white);
  /// ```
  Widget circleAvatar({
    double size = 48,
    Color? borderColor,
    double borderWidth = 2,
    Color? backgroundColor,
    List<BoxShadow>? shadow,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: borderColor != null
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
        boxShadow: shadow,
      ),
      child: ClipOval(
        child: SizedBox(width: size, height: size, child: this),
      ),
    );
  }

  // ─── Gölge & Yükseklik ────────────────────────────────────────

  /// Kutu gölgesi ekler.
  Widget shadow({
    Color color = Colors.black26,
    double blurRadius = 8,
    Offset offset = const Offset(0, 4),
    double spreadRadius = 0,
    double? borderRadius,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius)
            : null,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: blurRadius,
            offset: offset,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
      child: borderRadius != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: this,
            )
          : this,
    );
  }

  // ─── Renk & Filtre ────────────────────────────────────────────

  /// Renk filtresi uygular.
  ///
  /// ```dart
  /// Image.asset('photo.png').colorFiltered(
  ///   color: Colors.red,
  ///   blendMode: BlendMode.colorBurn,
  /// );
  /// ```
  Widget colorFiltered({
    required Color color,
    BlendMode blendMode = BlendMode.srcATop,
  }) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, blendMode),
      child: this,
    );
  }

  /// Siyah-beyaz yapar.
  Widget grayscale() {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.2126, 0.7152, 0.0722, 0, 0, //
        0.2126, 0.7152, 0.0722, 0, 0, //
        0.2126, 0.7152, 0.0722, 0, 0, //
        0, 0, 0, 1, 0, //
      ]),
      child: this,
    );
  }

  /// Sepya (antik) efekti uygular.
  Widget sepia() {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.393, 0.769, 0.189, 0, 0, //
        0.349, 0.686, 0.168, 0, 0, //
        0.272, 0.534, 0.131, 0, 0, //
        0, 0, 0, 1, 0, //
      ]),
      child: this,
    );
  }

  /// Opaklık / saydamlık ayarlar.
  Widget opacity(double value) {
    return Opacity(opacity: value.clamp(0.0, 1.0), child: this);
  }

  // ─── Blur ─────────────────────────────────────────────────────

  /// Bulanıklaştırma efekti.
  ///
  /// ```dart
  /// Image.asset('bg.png').blurred(sigmaX: 5, sigmaY: 5);
  /// ```
  Widget blurred({
    double sigmaX = 5.0,
    double sigmaY = 5.0,
    TileMode tileMode = TileMode.clamp,
  }) {
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
        tileMode: tileMode,
      ),
      child: this,
    );
  }

  // ─── Boyut & Oran ─────────────────────────────────────────────

  /// Sabit boyut verir.
  Widget sized({double? width, double? height, BoxFit fit = BoxFit.cover}) {
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(fit: fit, clipBehavior: Clip.hardEdge, child: this),
    );
  }

  /// En-boy oranı zorlayarak gösterir.
  Widget ratio(double aspectRatio) {
    return AspectRatio(aspectRatio: aspectRatio, child: this);
  }

  // ─── Overlay ──────────────────────────────────────────────────

  /// Resmin üzerine gradient kaplama ekler.
  ///
  /// ```dart
  /// Image.asset('banner.png').gradientOverlay(
  ///   colors: [Colors.transparent, Colors.black87],
  ///   begin: Alignment.topCenter,
  ///   end: Alignment.bottomCenter,
  /// );
  /// ```
  Widget gradientOverlay({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    List<double>? stops,
    double? borderRadius,
  }) {
    final child = Stack(
      fit: StackFit.passthrough,
      children: [
        this,
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: begin,
                end: end,
                stops: stops,
              ),
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(borderRadius)
                  : null,
            ),
          ),
        ),
      ],
    );

    return borderRadius != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: child,
          )
        : child;
  }

  /// Resmin üzerine renk katmanı ekler.
  Widget colorOverlay(Color color, {double? borderRadius}) {
    return gradientOverlay(colors: [color, color], borderRadius: borderRadius);
  }

  // ─── Animasyon ────────────────────────────────────────────────

  /// Fade-in efektiyle görünür.
  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeIn,
  }) {
    return _FadeInImage(duration: duration, curve: curve, child: this);
  }
}

// ═══════════════════════════════════════════════════════════════════════
// STRING → IMAGE EXTENSIONS
// ═══════════════════════════════════════════════════════════════════════

/// String'den hızlıca Image widget oluşturma kısayolları.
///
/// ```dart
/// 'assets/images/logo.png'.asAssetImage(width: 120)
/// 'https://example.com/photo.jpg'.asNetworkImage(fit: BoxFit.cover)
/// ```
extension StringImageExtensions on String {
  /// Asset yolundan `Image.asset` oluşturur.
  Image asAssetImage({
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    BlendMode? colorBlendMode,
    Alignment alignment = Alignment.center,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image.asset(
      this,
      key: key,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      filterQuality: filterQuality,
    );
  }

  /// URL'den `Image.network` oluşturur.
  Image asNetworkImage({
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    BlendMode? colorBlendMode,
    Alignment alignment = Alignment.center,
    FilterQuality filterQuality = FilterQuality.low,
    Map<String, String>? headers,
    double scale = 1.0,
    Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
    Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
  }) {
    return Image.network(
      this,
      key: key,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      filterQuality: filterQuality,
      headers: headers,
      scale: scale,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
    );
  }

  /// URL'den yüklenen, loading spinner ve hata widget'ı olan `Image.network`.
  ///
  /// ```dart
  /// 'https://example.com/photo.jpg'.asSmartNetworkImage(
  ///   width: 200,
  ///   height: 200,
  ///   fit: BoxFit.cover,
  /// )
  /// ```
  Widget asSmartNetworkImage({
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    BlendMode? colorBlendMode,
    Alignment alignment = Alignment.center,
    FilterQuality filterQuality = FilterQuality.low,
    Map<String, String>? headers,
    Widget? placeholder,
    Widget? errorWidget,
    double? borderRadius,
  }) {
    Widget image = Image.network(
      this,
      key: key,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      filterQuality: filterQuality,
      headers: headers,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ??
            SizedBox(
              width: width,
              height: height,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                  strokeWidth: 2,
                ),
              ),
            );
      },
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: Icon(Icons.broken_image_outlined, color: Colors.grey),
            ),
          ),
    );

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    }

    return image;
  }

  /// Asset yolundan `AssetImage` provider oluşturur.
  AssetImage toAssetImageProvider({String? package}) {
    return AssetImage(this, package: package);
  }

  /// URL'den `NetworkImage` provider oluşturur.
  NetworkImage toNetworkImageProvider({
    double scale = 1.0,
    Map<String, String>? headers,
  }) {
    return NetworkImage(this, scale: scale, headers: headers);
  }

  /// Asset'ten `DecorationImage` oluşturur (Container background vb. için).
  DecorationImage asDecorationImage({
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
    ColorFilter? colorFilter,
    double opacity = 1.0,
  }) {
    return DecorationImage(
      image: AssetImage(this),
      fit: fit,
      alignment: alignment,
      colorFilter: colorFilter,
      opacity: opacity,
    );
  }

  /// Network URL'den `DecorationImage` oluşturur.
  DecorationImage asNetworkDecorationImage({
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
    ColorFilter? colorFilter,
    double opacity = 1.0,
    double scale = 1.0,
    Map<String, String>? headers,
  }) {
    return DecorationImage(
      image: NetworkImage(this, scale: scale, headers: headers),
      fit: fit,
      alignment: alignment,
      colorFilter: colorFilter,
      opacity: opacity,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// IMAGE PROVIDER EXTENSIONS
// ═══════════════════════════════════════════════════════════════════════

/// `ImageProvider` üzerinden hızlıca widget oluşturma.
///
/// ```dart
/// AssetImage('assets/logo.png').toImage(width: 100, fit: BoxFit.contain)
/// NetworkImage(url).toCircleAvatar(radius: 30)
/// ```
extension ImageProviderExtensions on ImageProvider {
  /// ImageProvider'dan `Image` widget'ı oluşturur.
  Image toImage({
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    BlendMode? colorBlendMode,
    Alignment alignment = Alignment.center,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      filterQuality: filterQuality,
    );
  }

  /// ImageProvider'dan `DecorationImage` oluşturur.
  DecorationImage toDecorationImage({
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
    ColorFilter? colorFilter,
    double opacity = 1.0,
  }) {
    return DecorationImage(
      image: this,
      fit: fit,
      alignment: alignment,
      colorFilter: colorFilter,
      opacity: opacity,
    );
  }

  /// `CircleAvatar` oluşturur.
  CircleAvatar toCircleAvatar({
    double? radius,
    Color? backgroundColor,
    Widget? child,
  }) {
    return CircleAvatar(
      backgroundImage: this,
      radius: radius,
      backgroundColor: backgroundColor,
      child: child,
    );
  }

  /// Ink üzerinde arka plan resmi (InkWell/Card içinde kullanım).
  Ink toInk({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    ColorFilter? colorFilter,
    EdgeInsetsGeometry? padding,
    Widget? child,
  }) {
    return Ink(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        image: DecorationImage(image: this, fit: fit, colorFilter: colorFilter),
      ),
      child: child,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// FadeIn Helper (Internal)
// ═══════════════════════════════════════════════════════════════════════

class _FadeInImage extends StatefulWidget {
  const _FadeInImage({
    required this.child,
    required this.duration,
    required this.curve,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<_FadeInImage> createState() => _FadeInImageState();
}

class _FadeInImageState extends State<_FadeInImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}
