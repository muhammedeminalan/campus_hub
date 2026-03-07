import 'package:flutter/material.dart';

/// Hızlı menü kategorisini temsil eden saf veri sınıfı.
///
/// [indices] → [MenuItemModel.quickMenuItems] listesindeki sıra numaraları.
/// [accentColor] → kategori başlığı ve kartlarda kullanılan vurgu rengi.
/// Presentation katmanına özgüdür; domain modeliyle karıştırılmamalıdır.
class QuickMenuCategory {
  const QuickMenuCategory({
    required this.title,
    required this.icon,
    required this.indices,
    required this.accentColor,
  });

  /// Kategori başlığı (örn. "Dersler & Sınavlar").
  final String title;

  /// Pill başlıkta gösterilen ikon.
  final IconData icon;

  /// Bu kategoriye ait öğelerin [MenuItemModel.quickMenuItems] içindeki sıraları.
  final List<int> indices;

  /// Başlık, ikon arka planı ve kart effektlerinde kullanılan renk.
  final Color accentColor;
}
