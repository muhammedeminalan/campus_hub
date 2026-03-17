import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/academic_advisor/presentation/view/academic_advisor_view.dart';
import 'package:campus_hub/features/courses/presentation/view/courses_view.dart';
import 'package:campus_hub/features/exam_results/presentation/view/exam_results_view.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

import '../enum/quick_menu_route.dart';

/// [QuickMenuRoute] enum değerlerini gerçek sayfa widget'larına çevirir.
///
/// Her yeni özellik sayfası tamamlandığında sadece bu switch güncellenir;
/// [MenuItemModel] ve widget katmanı dokunulmadan kalır.
abstract final class QuickMenuNavigator {
  static Widget pageFor(QuickMenuRoute route) {
    return switch (route) {
      QuickMenuRoute.examResults => const ExamResultsView(),
      QuickMenuRoute.takenCourses => const CoursesView(),
      QuickMenuRoute.attendance => const _ComingSoonPage(
        title: AppStrings.attendance,
      ),
      QuickMenuRoute.examSchedule => const _ComingSoonPage(
        title: AppStrings.examSchedule,
      ),
      QuickMenuRoute.academicCalendar => const _ComingSoonPage(
        title: AppStrings.academicCalendar,
      ),
      QuickMenuRoute.termAverages => const _ComingSoonPage(
        title: AppStrings.termAverages,
      ),
      QuickMenuRoute.transcript => const _ComingSoonPage(
        title: AppStrings.transcript,
      ),
      QuickMenuRoute.courseSchedule => const _ComingSoonPage(
        title: AppStrings.courseSchedule,
      ),
      QuickMenuRoute.tuitionInfo => const _ComingSoonPage(
        title: AppStrings.tuitionInfo,
      ),
      QuickMenuRoute.absenceStatus => const _ComingSoonPage(
        title: AppStrings.absenceStatus,
      ),
      QuickMenuRoute.academicStatus => const _ComingSoonPage(
        title: AppStrings.academicStatus,
      ),
      QuickMenuRoute.curriculum => const _ComingSoonPage(
        title: AppStrings.curriculum,
      ),
      QuickMenuRoute.todos => const _ComingSoonPage(title: AppStrings.todos),
      QuickMenuRoute.academicAdvisor => const AcademicAdvisorView(),
      QuickMenuRoute.preparatoryInfo => const _ComingSoonPage(
        title: AppStrings.preparatoryInfo,
      ),
    };
  }
}

class _ComingSoonPage extends StatelessWidget {
  const _ComingSoonPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title.text),
      body: [
        const Icon(Icons.construction_outlined, size: 64),
        const SizedBox(height: 16),
        '$title — Yakında'.text.titleMedium(context),
      ].column(mainAxisAlignment: MainAxisAlignment.center).center,
    );
  }
}
