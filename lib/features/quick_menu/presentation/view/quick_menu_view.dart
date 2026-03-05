// ignore_for_file: deprecated_member_use

import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/home/presentation/model/menu_item_model.dart';
import 'package:campus_hub/features/quick_menu/navigation/quick_menu_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

// ─────────────────────────────────────────────────────────────────────────────
// QuickMenuView
// ─────────────────────────────────────────────────────────────────────────────

class _MenuCategory {
  const _MenuCategory({
    required this.title,
    required this.icon,
    required this.indices,
    required this.accentColor,
  });

  final String title;
  final IconData icon;
  final List<int> indices;
  final Color accentColor;
}

// ─────────────────────────────────────────────────────────────────────────────

class QuickMenuView extends StatefulWidget {
  const QuickMenuView({super.key});

  @override
  State<QuickMenuView> createState() => _QuickMenuViewState();
}

class _QuickMenuViewState extends State<QuickMenuView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<_MenuCategory> _categories = [
    _MenuCategory(
      title: 'Yoklama & Takvimler',
      icon: Icons.calendar_today_outlined,
      indices: [0, 1, 2],
      accentColor: AppColors.primary,
    ),
    _MenuCategory(
      title: 'Dersler & Sınavlar',
      icon: Icons.menu_book_outlined,
      indices: [3, 4, 5],
      accentColor: AppColors.secondary,
    ),
    _MenuCategory(
      title: 'Akademik Bilgiler',
      icon: Icons.school_outlined,
      indices: [6, 7, 8],
      accentColor: AppColors.success,
    ),
    _MenuCategory(
      title: 'Durum & Müfredat',
      icon: Icons.leaderboard_outlined,
      indices: [9, 10, 11],
      accentColor: AppColors.warning,
    ),
    _MenuCategory(
      title: 'Diğer',
      icon: Icons.apps_outlined,
      indices: [12, 13, 14],
      accentColor: AppColors.info,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() => _searchQuery = _searchController.text.trim().toLowerCase());
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  /// Her öğeye kendi başlangıç gecikmesiyle staggered animasyon verir.
  Animation<double> _itemAnim(int globalIndex) {
    final start = (globalIndex * 0.04).clamp(0.0, 0.65);
    final end = (start + 0.42).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  // ── Search filtrelemesi ──
  List<({MenuItemModel item, Color accent, int globalIndex})> get _filtered {
    final allItems = MenuItemModel.quickMenuItems;
    final result = <({MenuItemModel item, Color accent, int globalIndex})>[];

    for (final cat in _categories) {
      for (final index in cat.indices) {
        final item = allItems[index];
        if (item.label.toLowerCase().contains(_searchQuery)) {
          result.add((item: item, accent: cat.accentColor, globalIndex: index));
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSearching = _searchQuery.isNotEmpty;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(title: AppStrings.quickMenu),
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            // ── Arama çubuğu ──
            SliverToBoxAdapter(
              child: _SearchBar(controller: _searchController),
            ),

            if (isSearching)
              _buildSearchResults(colorScheme)
            else
              _buildCategoryList(),

            SliverToBoxAdapter(
              child: SizedBox(
                height: AppSize.v48 + MediaQuery.of(context).viewInsets.bottom,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    final allItems = MenuItemModel.quickMenuItems;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.v16,
        vertical: AppSize.v4,
      ),
      sliver: SliverList.builder(
        itemCount: _categories.length,
        itemBuilder: (context, catIndex) {
          final cat = _categories[catIndex];
          return _CategorySection(
            category: cat,
            items: cat.indices.map((i) => allItems[i]).toList(),
            animations: cat.indices.map(_itemAnim).toList(),
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(ColorScheme colorScheme) {
    final results = _filtered;
    if (results.isEmpty) {
      return SliverFillRemaining(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: AppSize.v64,
              color: colorScheme.onSurface.withOpacity(0.25),
            ),
            const SizedBox(height: AppSize.v12),
            Text(
              'Sonuç bulunamadı',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.45),
              ),
            ),
          ],
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.v16,
        vertical: AppSize.v8,
      ),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: AppSize.v10,
          mainAxisSpacing: AppSize.v10,
          childAspectRatio: 0.95,
        ),
        itemCount: results.length,
        itemBuilder: (context, i) {
          final r = results[i];
          return _QuickMenuGridItem(
            item: r.item,
            accentColor: r.accent,
            animation: _itemAnim(r.globalIndex),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _SearchBar
// ─────────────────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v12,
        AppSize.v16,
        AppSize.v4,
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Menüde ara…',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.4),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: colorScheme.onSurface.withOpacity(0.45),
            size: AppSize.v20,
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, value, _) => value.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: AppSize.v18,
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                    onPressed: controller.clear,
                  )
                : const SizedBox.shrink(),
          ),
          filled: true,
          fillColor: colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(vertical: AppSize.v12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.v14),
            borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.v14),
            borderSide: BorderSide(
              color: colorScheme.primary.withOpacity(0.6),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _CategorySection
// ─────────────────────────────────────────────────────────────────────────────

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.category,
    required this.items,
    required this.animations,
  });

  final _MenuCategory category;
  final List<MenuItemModel> items;
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
          // ── Kategori başlığı ──
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

          // ── Grid ──
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSize.v10,
              mainAxisSpacing: AppSize.v10,
              childAspectRatio: 0.95,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => _QuickMenuGridItem(
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

// ─────────────────────────────────────────────────────────────────────────────
// _QuickMenuGridItem — Animasyonlu, press-scale efektli kart
// ─────────────────────────────────────────────────────────────────────────────

class _QuickMenuGridItem extends StatefulWidget {
  const _QuickMenuGridItem({
    required this.item,
    required this.accentColor,
    required this.animation,
  });

  final MenuItemModel item;
  final Color accentColor;
  final Animation<double> animation;

  @override
  State<_QuickMenuGridItem> createState() => _QuickMenuGridItemState();
}

class _QuickMenuGridItemState extends State<_QuickMenuGridItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accent = widget.accentColor;

    return FadeTransition(
      opacity: widget.animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.25),
          end: Offset.zero,
        ).animate(widget.animation),
        child: AnimatedScale(
          scale: _pressed ? 0.92 : 1.0,
          duration: const Duration(milliseconds: 110),
          curve: Curves.easeOut,
          child: GestureDetector(
            onTapDown: (_) => setState(() => _pressed = true),
            onTapUp: (_) => setState(() => _pressed = false),
            onTapCancel: () => setState(() => _pressed = false),
            onTap: () {
              HapticFeedback.lightImpact();
              context.pushPage(QuickMenuNavigator.pageFor(widget.item.route));
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppSize.v16),
                border: Border.all(
                  color: _pressed
                      ? accent.withOpacity(0.4)
                      : colorScheme.outline.withOpacity(0.18),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(_pressed ? 0.12 : 0.06),
                    blurRadius: _pressed ? 10 : 6,
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
                  // ── İkon ──
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.all(AppSize.v10),
                    decoration: BoxDecoration(
                      color: _pressed
                          ? accent.withOpacity(0.18)
                          : accent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.item.icon,
                      size: AppSize.v20,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: AppSize.v8),

                  // ── Etiket ──
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
        ),
      ),
    );
  }
}
