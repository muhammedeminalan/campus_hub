import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

import 'mixin/style_mixin.dart';

/// Login sayfasındaki Öğrenci / Öğretmen seçimi için modern segment TabBar.
class LoginTabBar extends StatefulWidget {
  const LoginTabBar({super.key, required this.controller});

  final TabController controller;

  @override
  State<LoginTabBar> createState() => _LoginTabBarState();
}

class _LoginTabBarState extends State<LoginTabBar> with StyleMixin {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.controller,
      indicator: indicatorBoxDecoration,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      labelColor: Colors.white,
      unselectedLabelColor: context.primaryColor,
      labelStyle: labelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      splashBorderRadius: tabBarBorderRadius,
      tabs: [
        _LoginTab(icon: studentIcon, label: AppStrings.student),
        _LoginTab(icon: teacherIcon, label: AppStrings.teacher),
      ],
    ).container(
      decoration: tabBarContainerDecoration,
      margin: tabBarContainerMargin,
      padding: tabBarContainerPadding,
    );
  }
}

/// TabBar içindeki tek bir sekme.
class _LoginTab extends StatelessWidget {
  const _LoginTab({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: [
        Icon(icon, size: AppSize.v20),
        AppSize.v8.width,
        label.text,
      ].row(mainAxisAlignment: MainAxisAlignment.center),
    );
  }
}
