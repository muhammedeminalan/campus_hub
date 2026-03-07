import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

import '../cubit/navigation_cubit.dart';
import '../enum/page_type.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  static const _tabs = [
    NavigationTab.home,
    NavigationTab.courses,
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
      padding: EdgeInsets.zero,
      child: Row(
        children: _tabs
            .map(
              (tab) => Expanded(
                child: _NavItem(
                  tab: tab,
                  isSelected: tab == current,
                  onTap: () => context.read<NavigationCubit>().updateTab(tab),
                ),
              ),
            )
            .toList(),
      ),
    );
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
          tab.navLabel.text
              .style(TextStyle(fontSize: AppSize.v10, color: color))
              .maxLine(1),
        ]
        .column(mainAxisSize: MainAxisSize.min, spacing: AppSize.v4)
        .paddingSymmetric(v: AppSize.v4)
        .center
        .onTap(onTap);
  }

  Color _resolveColor(BuildContext context) =>
      isSelected ? context.primaryColor : context.onSurfaceColor.withAlpha(153);
}
