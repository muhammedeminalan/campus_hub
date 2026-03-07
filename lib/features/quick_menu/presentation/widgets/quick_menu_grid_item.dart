// ignore_for_file: deprecated_member_use

import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/features/home/presentation/model/menu_item_model.dart';
import 'package:campus_hub/features/quick_menu/navigation/quick_menu_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Hızlı menü grid kartı widget'ı.
///
/// [animation] ile staggered fade + slide giriş animasyonu oynatır.
/// Karta basıldığında [AnimatedScale] ile %92'ye küçülür;
/// kenarlık ve gölge rengi [_pressed] durumuna göre animasyonlu geçiş yapar.
/// [setState] sadece bu küçük widget'ı etkiler — üst ağaca sıçramaz.
class QuickMenuGridItem extends StatefulWidget {
  const QuickMenuGridItem({
    super.key,
    required this.item,
    required this.accentColor,
    required this.animation,
  });

  final MenuItemModel item;
  final Color accentColor;

  /// [AnimationController]'dan kesilmiş staggered dilim.
  final Animation<double> animation;

  @override
  State<QuickMenuGridItem> createState() => _QuickMenuGridItemState();
}

class _QuickMenuGridItemState extends State<QuickMenuGridItem> {
  /// Basılı tutma efekti için notifier; yalnızca iç Container rebuild olur.
  /// FadeTransition + SlideTransition press olaylarından etkilenmez.
  final ValueNotifier<bool> _pressed = ValueNotifier(false);

  @override
  void dispose() {
    _pressed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Giriş animasyonu: fade + yukarı kayarak belirme.
    // Bu wrapper'lar hiçbir zaman press nedeniyle rebuild olmaz.
    return FadeTransition(
      opacity: widget.animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.25),
          end: Offset.zero,
        ).animate(widget.animation),
        child: ValueListenableBuilder<bool>(
          valueListenable: _pressed,
          builder: (context, pressed, _) => _buildCard(context, pressed),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, bool pressed) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accent = widget.accentColor;

    return AnimatedScale(
      scale: pressed ? 0.92 : 1.0,
      duration: const Duration(milliseconds: 110),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTapDown: (_) => _pressed.value = true,
        onTapUp: (_) => _pressed.value = false,
        onTapCancel: () => _pressed.value = false,
        onTap: () {
          HapticFeedback.lightImpact();
          context.pushPage(QuickMenuNavigator.pageFor(widget.item.route));
        },
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSize.v16),
            border: Border.all(
              color: pressed
                  ? accent.withOpacity(0.4)
                  : colorScheme.outline.withOpacity(0.18),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withOpacity(pressed ? 0.12 : 0.06),
                blurRadius: pressed ? 10 : 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.v8,
            vertical: AppSize.v12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.all(AppSize.v10),
                decoration: BoxDecoration(
                  color: pressed
                      ? accent.withOpacity(0.18)
                      : accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.item.icon, size: AppSize.v20, color: accent),
              ),
              const SizedBox(height: AppSize.v8),
              Text(
                widget.item.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
