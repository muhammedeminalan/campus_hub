import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Proje genelinde kullanılan tip güvenli, özelleştirilebilir ListView sarmalayıcı.
///
/// [T] → listedeki her elemanın tipi (ör. `CourseModel`, `String`).
///
/// Temel özellikler:
/// - Boş liste durumunu [emptyWidget] ile ele alır.
/// - [separatorBuilder] verilirse otomatik `ListView.separated` moduna geçer.
/// - Tüm [ListView.builder] parametreleri desteklenir.
///
/// Kullanım örnekleri:
/// ```dart
/// // Temel kullanım
/// AppListView<String>(
///   items: periods,
///   itemBuilder: (context, item, index) => Text(item),
/// )
///
/// // Loading + boş durum
/// AppListView<CourseModel>(
///   items: courses,
///   isLoading: isLoading,                        // keyfi — verilmezse false
///   loadingWidget: MyShimmerList(),              // keyfi — verilmezse CircularProgressIndicator
///   emptyWidget: EmptyStateWidget(),             // keyfi — verilmezse sessiz geçiştirilir
///   itemBuilder: (context, item, index) => CourseCard(...),
/// )
/// ```
class AppListView<T> extends StatelessWidget {
  const AppListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.separatorBuilder,
    this.emptyWidget,
    this.isLoading = false,
    this.loadingWidget,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.controller,
    this.reverse = false,
    this.primary,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
  });

  // ── Veri ──────────────────────────────────────────────────────────────────

  /// Listelenecek elemanlar. Boşsa [emptyWidget] gösterilir.
  final List<T> items;

  /// Her eleman için oluşturulacak widget.
  /// [item] → o satırın verisi, [index] → sıra numarası.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Elemanlar arasına eklenecek ayraç widget'ı (ör. Divider).
  /// Verilirse `ListView.separated` modu kullanılır.
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// [items] boş olduğunda gösterilecek widget (ör. "Kayıt bulunamadı" mesajı).
  /// Verilmezse boş liste sessizce geçiştirilir.
  final Widget? emptyWidget;

  /// Yükleme durumu. `true` olduğunda liste yerine [loadingWidget] gösterilir.
  final bool isLoading;

  /// [isLoading] `true` iken gösterilecek widget.
  /// Verilmezse merkeze hizalanmış [CircularProgressIndicator] kullanılır.
  final Widget? loadingWidget;

  // ── Kaydırma yönü ─────────────────────────────────────────────────────────

  /// Listenin kaydırma ekseni.
  /// [Axis.vertical] (varsayılan) → dikey, [Axis.horizontal] → yatay.
  final Axis scrollDirection;

  /// Liste elemanlarının ters sırada gösterilip gösterilmeyeceği.
  final bool reverse;

  // ── Boyut ve fizik ────────────────────────────────────────────────────────

  /// Liste etrafındaki boşluk. Verilmezse uygulanmaz.
  final EdgeInsetsGeometry? padding;

  /// Liste kaydırma fiziği (ör. [NeverScrollableScrollPhysics]).
  /// Verilmezse platform varsayılanı kullanılır.
  final ScrollPhysics? physics;

  /// Liste içeriğini kendi boyutuna göre küçültür.
  /// Nested scroll durumlarında `true` yapılması gerekebilir.
  final bool shrinkWrap;

  /// Listenin birincil kaydırma view'u olup olmadığı.
  /// [physics] veya [controller] verildiğinde genellikle `false` yapılır.
  final bool? primary;

  // ── Kontrolcü ve davranış ─────────────────────────────────────────────────

  /// Dış scroll kontrolcüsü. Programatik kaydırma için kullanılır.
  final ScrollController? controller;

  /// Sürükleme başlangıç davranışı.
  final DragStartBehavior dragStartBehavior;

  /// Klavye açıkken listeye kaydırıldığında klavyenin kapatılma davranışı.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Liste kenarlarının kırpma davranışı.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    /// Önce yükleme durumu kontrol edilir — loading varsa listeye bakılmaz
    if (isLoading) {
      return loadingWidget ??
          const Center(child: CircularProgressIndicator.adaptive());
    }

    /// Yükleme bitti, liste boşsa [emptyWidget] göster
    if (items.isEmpty && emptyWidget != null) return emptyWidget!;

    /// [separatorBuilder] varsa separated, yoksa builder modu
    if (separatorBuilder != null) {
      return ListView.separated(
        itemCount: items.length,
        scrollDirection: scrollDirection,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        controller: controller,
        reverse: reverse,
        primary: primary,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        clipBehavior: clipBehavior,
        separatorBuilder: separatorBuilder!,
        itemBuilder: (context, index) =>
            itemBuilder(context, items[index], index),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      controller: controller,
      reverse: reverse,
      primary: primary,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      clipBehavior: clipBehavior,
      itemBuilder: (context, index) =>
          itemBuilder(context, items[index], index),
    );
  }
}
