import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

/// Bottom navigation tab tanımları.
/// Her tab kendi icon, activeIcon, label ve sayfa bilgisini taşır.
///
/// Yeni bir sayfa oluşturduğunda sadece ilgili tab'ın [page] getter'ını
/// güncelle. Örnek:
/// ```dart
/// NavigationTab.home => const HomeView(),
/// ```
enum NavigationTab {
  home(
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    label: AppStrings.home,
  ),
  courses(
    icon: Icons.menu_book_outlined,
    activeIcon: Icons.menu_book,
    label: AppStrings.takenCourses,
  ),
  examResults(
    icon: Icons.assignment_outlined,
    activeIcon: Icons.assignment,
    label: AppStrings.examResults,
  ),
  quickMenu(
    icon: Icons.dashboard_outlined,
    activeIcon: Icons.dashboard,
    label: AppStrings.quickMenu,
  );

  const NavigationTab({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}
