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
      QuickMenuRoute.examResults => const _ComingSoonPage(
        title: 'Sınav Sonuçları',
      ),
      QuickMenuRoute.takenCourses => const _ComingSoonPage(
        title: 'Alınan Dersler',
      ),
      QuickMenuRoute.attendance => const _ComingSoonPage(title: 'Yoklama'),
      QuickMenuRoute.examSchedule => const _ComingSoonPage(
        title: 'Sınav Programı',
      ),
      QuickMenuRoute.academicCalendar => const _ComingSoonPage(
        title: 'Akademik Takvim',
      ),
      QuickMenuRoute.termAverages => const _ComingSoonPage(
        title: 'Dönem Ortalamaları',
      ),
      QuickMenuRoute.transcript => const _ComingSoonPage(title: 'Transkript'),
      QuickMenuRoute.courseSchedule => const _ComingSoonPage(
        title: 'Ders Programı',
      ),
      QuickMenuRoute.tuitionInfo => const _ComingSoonPage(
        title: 'Harç Bilgileri',
      ),
      QuickMenuRoute.absenceStatus => const _ComingSoonPage(
        title: 'Devamsızlık Durumu',
      ),
      QuickMenuRoute.academicStatus => const _ComingSoonPage(
        title: 'Akademik Durum',
      ),
      QuickMenuRoute.curriculum => const _ComingSoonPage(title: 'Müfredat'),
      QuickMenuRoute.todos => const _ComingSoonPage(title: 'Yapılacaklar'),
      QuickMenuRoute.academicAdvisor => const _ComingSoonPage(
        title: 'Akademik Danışman',
      ),
      QuickMenuRoute.preparatoryInfo => const _ComingSoonPage(
        title: 'Hazırlık Bilgileri',
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
