// ignore_for_file: deprecated_member_use

import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/features/quick_menu/presentation/model/quick_menu_category.dart';
import 'package:campus_hub/shared/models/menu_item_model.dart';
import 'package:flutter/material.dart';

import 'quick_menu_grid_item.dart';

/// Tek bir menü kategorisini başlık pill'i + 3 sütunlu grid olarak render eder.
///
/// [animations] listesi view'daki [AnimationController]'dan kesilmiş
/// dilimlerdir; her öğe kendi staggered gecikmesiyle belirir.
/// Grid [NeverScrollableScrollPhysics] kullanır çünkü kaydırmayı üst
/// [CustomScrollView] yönetir.
class QuickMenuCategorySection extends StatelessWidget {
  const QuickMenuCategorySection({
    super.key,
    required this.category,
    required this.items,
    required this.animations,
  });

  final QuickMenuCategory category;
  final List<MenuItemModel> items;

  /// Her öğeye karşılık gelen animasyon dilimi; [items] ile aynı uzunlukta olmalı.
  final List<Animation<double>> animations;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accent = category.accentColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.v20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Kategori başlığı: renk + ikon + başlık pill rozeti ──
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.v10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.v10,
                    vertical: AppSize.v6,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(AppSize.v24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(category.icon, size: AppSize.v14, color: accent),
                      const SizedBox(width: AppSize.v6),
                      Text(
                        category.title,
                        style: textTheme.labelMedium?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── 3 sütunlu öğe grid'i ──
          GridView.builder(
            shrinkWrap: true,
            // Dış CustomScrollView kaydırmayı yönetir.
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSize.v10,
              mainAxisSpacing: AppSize.v10,
              childAspectRatio: 0.95,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => QuickMenuGridItem(
              item: items[index],
              accentColor: category.accentColor,
              animation: animations[index],
            ),
          ),
        ],
      ),
    );
  }
}
