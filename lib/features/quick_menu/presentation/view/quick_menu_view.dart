import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/quick_menu/presentation/model/quick_menu_category.dart';
import 'package:campus_hub/features/quick_menu/presentation/widgets/quick_menu_category_section.dart';
import 'package:campus_hub/features/quick_menu/presentation/widgets/quick_menu_grid_item.dart';
import 'package:campus_hub/features/quick_menu/presentation/widgets/quick_menu_search_bar.dart';
import 'package:campus_hub/shared/models/menu_item_model.dart';
import 'package:campus_hub/shared/widgets/app_bar/core_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

typedef _SearchResult = ({MenuItemModel item, Color accent, int globalIndex});

class QuickMenuView extends StatefulWidget {
  const QuickMenuView({super.key});

  @override
  State<QuickMenuView> createState() => _QuickMenuViewState();
}

class _QuickMenuViewState extends State<QuickMenuView> {
  /// Arama kutusu metin controller'ı.
  final TextEditingController _searchController = TextEditingController();

  /// Arama sorgusunu tutan notifier; rebuild'i yalnızca içerik sliverına izole eder.
  final ValueNotifier<String> _searchQuery = ValueNotifier('');

  static const List<QuickMenuCategory> _categories = [
    QuickMenuCategory(
      title: AppStrings.categoryAttendance,
      icon: Icons.calendar_today_outlined,
      indices: [0, 1, 2],
      accentColor: AppColors.primary,
    ),
    QuickMenuCategory(
      title: AppStrings.categoryCoursesExams,
      icon: Icons.menu_book_outlined,
      indices: [3, 4, 5],
      accentColor: AppColors.secondary,
    ),
    QuickMenuCategory(
      title: AppStrings.categoryAcademic,
      icon: Icons.school_outlined,
      indices: [6, 7, 8],
      accentColor: AppColors.success,
    ),
    QuickMenuCategory(
      title: AppStrings.categoryStatus,
      icon: Icons.leaderboard_outlined,
      indices: [9, 10, 11],
      accentColor: AppColors.warning,
    ),
    QuickMenuCategory(
      title: AppStrings.categoryOther,
      icon: Icons.apps_outlined,
      indices: [12, 13, 14],
      accentColor: AppColors.info,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  /// Arama kutusu değiştiğinde [_searchQuery] notifier'ını günceller.
  /// setState çağrılmadığından Scaffold yeniden build edilmez.
  void _onSearchChanged() {
    _searchQuery.value = _searchController.text.trim().toLowerCase();
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  /// Arama sorgusuna göre tüm kategorilerdeki öğeleri filtreler.
  List<_SearchResult> _filtered(String query) {
    final allItems = MenuItemModel.quickMenuItems;
    final result = <_SearchResult>[];

    for (final cat in _categories) {
      for (final index in cat.indices) {
        final item = allItems[index];
        if (item.label.toLowerCase().contains(query)) {
          result.add((item: item, accent: cat.accentColor, globalIndex: index));
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Klavye dışına tıklandığında klavyeyi kapat.
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CoreAppBar(title: AppStrings.quickMenu),
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            // ── Arama çubuğu ──
            SliverToBoxAdapter(
              child: QuickMenuSearchBar(controller: _searchController),
            ),

            // Arama aktifse sonuçları, değilse kategori listesini göster.
            // ValueListenableBuilder sayesinde sadece bu sliver rebuild olur.
            ValueListenableBuilder<String>(
              valueListenable: _searchQuery,
              builder: (context, query, _) => query.isNotEmpty
                  ? _buildSearchResults(context, query)
                  : _buildCategoryList(),
            ),

            // Klavye açıkken alttaki içeriğin gizlenmemesi için boşluk.
            SliverToBoxAdapter(
              child: (AppSize.v48 + MediaQuery.of(context).viewInsets.bottom).h,
            ),
          ],
        ),
      ),
    );
  }

  /// Tüm kategorileri dikey liste olarak render eder.
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
          return QuickMenuCategorySection(
            category: cat,
            items: cat.indices.map((i) => allItems[i]).toList(),
          );
        },
      ),
    );
  }

  /// Arama sonuçlarını 3 sütunlu grid olarak render eder.
  /// Sonuç yoksa boş durum gösterimi (ikon + mesaj) yapar.
  Widget _buildSearchResults(BuildContext context, String query) {
    final results = _filtered(query);

    if (results.isEmpty) {
      // ── Boş durum ──
      return SliverFillRemaining(
        child: [
          Icon(
            Icons.search_off_rounded,
            size: AppSize.v64,
            color: context.onSurfaceColor.withValues(alpha: 0.25),
          ),
          AppSize.v12.h,
          AppStrings.searchNoResult.text
              .bodyMedium(context)
              .color(context.onSurfaceColor.withValues(alpha: 0.45)),
        ].column(mainAxisAlignment: .center).center,
      );
    }

    // ── Eşleşen öğeler grid ──
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
          return QuickMenuGridItem(item: r.item, accentColor: r.accent);
        },
      ),
    );
  }
}
