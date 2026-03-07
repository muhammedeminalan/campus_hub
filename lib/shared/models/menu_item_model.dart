import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/quick_menu/enum/quick_menu_route.dart';
import 'package:flutter/material.dart';

/// Hızlı menü öğesini tanımlayan model.
///
/// [route] → hangi sayfaya gidileceğini [QuickMenuRoute] enum üzerinden belirtir.
/// Sayfa çözümlemesi [QuickMenuNavigator.pageFor] ile yapılır;
/// model Flutter widget'larına doğrudan bağımlı değildir.
final class MenuItemModel {
  final String label;
  final IconData icon;
  final QuickMenuRoute route;

  const MenuItemModel({
    required this.label,
    required this.icon,
    required this.route,
  });

  // ---------------------------------------------------------------
  // Quick Menu Items
  // ---------------------------------------------------------------

  static const List<MenuItemModel> quickMenuItems = [
    // Yoklama & Takvimler
    MenuItemModel(
      label: AppStrings.attendance,
      icon: Icons.how_to_reg,
      route: QuickMenuRoute.attendance,
    ),
    MenuItemModel(
      label: AppStrings.examSchedule,
      icon: Icons.calendar_month,
      route: QuickMenuRoute.examSchedule,
    ),
    MenuItemModel(
      label: AppStrings.academicCalendar,
      icon: Icons.event_note,
      route: QuickMenuRoute.academicCalendar,
    ),

    // Dersler & Sınavlar
    MenuItemModel(
      label: AppStrings.takenCourses,
      icon: Icons.bookmark_added,
      route: QuickMenuRoute.takenCourses,
    ),
    MenuItemModel(
      label: AppStrings.examResults,
      icon: Icons.fact_check,
      route: QuickMenuRoute.examResults,
    ),
    MenuItemModel(
      label: AppStrings.termAverages,
      icon: Icons.bar_chart,
      route: QuickMenuRoute.termAverages,
    ),

    // Akademik Bilgiler
    MenuItemModel(
      label: AppStrings.transcript,
      icon: Icons.school,
      route: QuickMenuRoute.transcript,
    ),
    MenuItemModel(
      label: AppStrings.courseSchedule,
      icon: Icons.calendar_view_week,
      route: QuickMenuRoute.courseSchedule,
    ),
    MenuItemModel(
      label: AppStrings.tuitionInfo,
      icon: Icons.payments,
      route: QuickMenuRoute.tuitionInfo,
    ),

    // Durum & Müfredat
    MenuItemModel(
      label: AppStrings.absenceStatus,
      icon: Icons.visibility_off,
      route: QuickMenuRoute.absenceStatus,
    ),
    MenuItemModel(
      label: AppStrings.academicStatus,
      icon: Icons.leaderboard,
      route: QuickMenuRoute.academicStatus,
    ),
    MenuItemModel(
      label: AppStrings.curriculum,
      icon: Icons.format_list_bulleted,
      route: QuickMenuRoute.curriculum,
    ),

    // Diğer
    MenuItemModel(
      label: AppStrings.todos,
      icon: Icons.checklist,
      route: QuickMenuRoute.todos,
    ),
    MenuItemModel(
      label: AppStrings.academicAdvisor,
      icon: Icons.support_agent,
      route: QuickMenuRoute.academicAdvisor,
    ),
    MenuItemModel(
      label: AppStrings.preparatoryInfo,
      icon: Icons.assignment_ind,
      route: QuickMenuRoute.preparatoryInfo,
    ),
  ];
}
