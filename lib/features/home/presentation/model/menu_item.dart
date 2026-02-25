import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

final class MenuItem {
  final String label;
  final IconData icon;
  final Widget page;

  const MenuItem({required this.label, required this.icon, required this.page});

  // ---------------------------------------------------------------
  // Quick Menu Items
  // ---------------------------------------------------------------

  static final List<MenuItem> quickMenuItems = [
    // Yoklama & Takvimler
    MenuItem(label: AppStrings.attendance, icon: Icons.how_to_reg, page: _demo),
    MenuItem(label: AppStrings.examSchedule, icon: Icons.calendar_month, page: _demo),
    MenuItem(label: AppStrings.academicCalendar, icon: Icons.event_note, page: _demo),

    // Dersler & Sınavlar
    MenuItem(label: AppStrings.takenCourses, icon: Icons.bookmark_added, page: _demo),
    MenuItem(label: AppStrings.examResults, icon: Icons.fact_check, page: _demo),
    MenuItem(label: AppStrings.termAverages, icon: Icons.bar_chart, page: _demo),

    // Akademik Bilgiler
    MenuItem(label: AppStrings.transcript, icon: Icons.school, page: _demo),
    MenuItem(
      label: AppStrings.courseSchedule,
      icon: Icons.calendar_view_week,
      page: _demo,
    ),
    MenuItem(label: AppStrings.tuitionInfo, icon: Icons.payments, page: _demo),

    // Durum & Müfredat
    MenuItem(
      label: AppStrings.absenceStatus,
      icon: Icons.visibility_off,
      page: _demo,
    ),
    MenuItem(label: AppStrings.academicStatus, icon: Icons.leaderboard, page: _demo),
    MenuItem(label: AppStrings.curriculum, icon: Icons.format_list_bulleted, page: _demo),

    // Diğer
    MenuItem(label: AppStrings.todos, icon: Icons.checklist, page: _demo),
    MenuItem(
      label: AppStrings.academicAdvisor,
      icon: Icons.support_agent,
      page: _demo,
    ),
    MenuItem(
      label: AppStrings.preparatoryInfo,
      icon: Icons.assignment_ind,
      page: _demo,
    ),
  ];

  static Widget get _demo => 'Demo'.text.center;
}
