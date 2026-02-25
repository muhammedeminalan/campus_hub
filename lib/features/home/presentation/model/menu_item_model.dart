import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

final class MenuItemModel {
  final String label;
  final IconData icon;
  final Widget page;

  const MenuItemModel({
    required this.label,
    required this.icon,
    required this.page,
  });

  // ---------------------------------------------------------------
  // Quick Menu Items
  // ---------------------------------------------------------------

  static final List<MenuItemModel> quickMenuItems = [
    // Yoklama & Takvimler
    MenuItemModel(
      label: AppStrings.attendance,
      icon: Icons.how_to_reg,
      page: _demo,
    ),
    MenuItemModel(
      label: AppStrings.examSchedule,
      icon: Icons.calendar_month,
      page: _demo,
    ),
    MenuItemModel(
      label: AppStrings.academicCalendar,
      icon: Icons.event_note,
      page: _demo,
    ),

    // Dersler & Sınavlar
    MenuItemModel(
      label: AppStrings.takenCourses,
      icon: Icons.bookmark_added,
      page: _demo,
    ),
    MenuItemModel(
      label: AppStrings.examResults,
      icon: Icons.fact_check,
      page: _demo,
    ),
    MenuItemModel(
      label: AppStrings.termAverages,
      icon: Icons.bar_chart,
      page: _demo,
    ),

    // Akademik Bilgiler
    MenuItemModel(
      label: AppStrings.transcript,
      icon: Icons.school,
      page: _demo,
    ),
    MenuItemModel(
      label: AppStrings.courseSchedule,
      icon: Icons.calendar_view_week,
      page: _demo,
    ),
    MenuItemModel(
      label: AppStrings.tuitionInfo,
      icon: Icons.payments,
      page: _demo,
    ),

    // Durum & Müfredat
    MenuItemModel(
      label: AppStrings.absenceStatus,
      icon: Icons.visibility_off,
      page: _demo,
    ),
    MenuItemModel(
      label: AppStrings.academicStatus,
      icon: Icons.leaderboard,
      page: _demo,
    ),
    MenuItemModel(
      label: AppStrings.curriculum,
      icon: Icons.format_list_bulleted,
      page: _demo,
    ),

    // Diğer
    MenuItemModel(label: AppStrings.todos, icon: Icons.checklist, page: _demo),
    MenuItemModel(
      label: AppStrings.academicAdvisor,
      icon: Icons.support_agent,
      page: _demo,
    ),
    MenuItemModel(
      label: AppStrings.preparatoryInfo,
      icon: Icons.assignment_ind,
      page: _demo,
    ),
  ];

  static Widget get _demo => 'Demo'.text.center;
}
