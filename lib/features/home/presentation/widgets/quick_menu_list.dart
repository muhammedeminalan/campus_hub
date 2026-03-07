import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/ui/widgets/menu_item_card.dart';
import 'package:campus_hub/features/home/presentation/model/menu_item_model.dart';
import 'package:campus_hub/features/quick_menu/navigation/quick_menu_navigator.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

/// Hızlı menü öğelerini yatay kaydırmalı, scroll-parallax animasyonuyla listeler.
///
/// Ortadaki kart tam boyutlu ve opak görünür; yanlardakiler kademeli olarak
/// küçülür, solar ve aşağı kayar.
class QuickMenuList extends StatefulWidget {
  const QuickMenuList({super.key});

  @override
  State<QuickMenuList> createState() => _QuickMenuListState();
}

class _QuickMenuListState extends State<QuickMenuList> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AspectRatio(1.3) × height(128) ≈ 166px genişlik + 8px gap = ~174px/item
    const itemWidth = AppSize.v128 * 1.3;
    const itemExtent = itemWidth + AppSize.v8;

    return AnimatedBuilder(
      animation: _scrollController,
      builder: (_, _) {
        return ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSize.v16),
          itemCount: MenuItemModel.quickMenuItems.length,
          separatorBuilder: (_, _) => AppSize.v8.w,
          itemBuilder: (context, index) {
            var scale = 1.0;
            var opacity = 1.0;
            var translateY = 0.0;

            if (_scrollController.hasClients) {
              final viewport = _scrollController.position.viewportDimension;
              final scrollOffset = _scrollController.offset;
              final itemCenter =
                  index * itemExtent + itemWidth / 2 + AppSize.v16;
              final viewportCenter = scrollOffset + viewport / 2;
              final distance = (itemCenter - viewportCenter).abs();
              // Dar pencere → geçiş daha sert/hızlı hissettiriyor
              final t = (distance / (viewport * 0.38)).clamp(0.0, 1.0);
              // t² ease-in eğrisi: küçük mesafelerde yavaş, uzaklaştıkça sert
              final curved = t * t;

              scale = 1.0 - curved * 0.28; // 1.0 → 0.72
              opacity = 1.0 - curved * 0.60; // 1.0 → 0.40
              translateY = curved * 14; // 0   → 14px aşağı
            }

            final item = MenuItemModel.quickMenuItems[index];
            return Transform.translate(
              offset: Offset(0, translateY),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: AspectRatio(
                    aspectRatio: 1.3,
                    child: MenuitemCard(
                      label: item.label,
                      icon: item.icon,
                      onPressed: () => context.pushPage(
                        QuickMenuNavigator.pageFor(item.route),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
