import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

import '../cubit/navigation_cubit.dart';
import '../enum/page_type.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  /// Sol taraftaki tab listesi (FAB'ın solunda)
  static const _leftTabs = [NavigationTab.home, NavigationTab.courses];

  /// Sağ taraftaki tab listesi (FAB'ın sağında)
  static const _rightTabs = [
    NavigationTab.examResults,
    NavigationTab.quickMenu,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationTab>(
      builder: (context, state) => _buildAppBar(context, state),
    );
  }

  Widget _buildAppBar(BuildContext context, NavigationTab current) {
    return BottomAppBar(
      color: context.surfaceColor,
      elevation: AppSize.v8,
      notchMargin: AppSize.v8,
      shape: const CircularNotchedRectangle(),
      child: Row(
        children: [
          ..._buildItems(context, _leftTabs, current),
          const Spacer(),
          ..._buildItems(context, _rightTabs, current),
        ],
      ),
    );
  }

  List<Widget> _buildItems(
    BuildContext context,
    List<NavigationTab> tabs,
    NavigationTab current,
  ) {
    return tabs
        .map(
          (tab) => _NavItem(
            tab: tab,
            isSelected: tab == current,
            onTap: () => context.read<NavigationCubit>().updateTab(tab),
          ),
        )
        .toList();
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final NavigationTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor(context);
    return [
          Icon(
            isSelected ? tab.activeIcon : tab.icon,
            color: color,
            size: AppSize.v24,
          ),

          tab.label.text.style(TextStyle(fontSize: AppSize.v10, color: color)),
        ]
        .column(mainAxisSize: MainAxisSize.min, spacing: AppSize.v4)
        .paddingSymmetric(h: AppSize.v8, v: AppSize.v4)
        .onTap(onTap);
  }

  Color _resolveColor(BuildContext context) =>
      isSelected ? context.primaryColor : context.onSurfaceColor.withAlpha(153);
}
