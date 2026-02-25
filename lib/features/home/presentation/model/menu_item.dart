import 'package:flutter/material.dart';

final class MenuItem {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  MenuItem({required this.label, required this.icon, this.onPressed});
  static final List<MenuItem> quickMenuItems = [
    MenuItem(label: 'Yoklama', icon: Icons.how_to_reg),
    MenuItem(label: 'Sınav Takvimi', icon: Icons.calendar_month),
    MenuItem(label: 'Akademik Takvim', icon: Icons.event_note),
    MenuItem(label: 'Alınan Dersler', icon: Icons.bookmark_added),
    MenuItem(label: 'Sınav Sonuçları', icon: Icons.fact_check),
    MenuItem(label: 'Dönem Ortalamaları', icon: Icons.bar_chart),
    MenuItem(label: 'Transkript', icon: Icons.school),
    MenuItem(label: 'Ders Programı', icon: Icons.calendar_view_week),
    MenuItem(label: 'Harç Bilgileri', icon: Icons.payments),
    MenuItem(label: 'Devamsızlık Durumu', icon: Icons.visibility_off),
    MenuItem(label: 'Akademik Durum', icon: Icons.leaderboard),
    MenuItem(label: 'Müfredat', icon: Icons.format_list_bulleted),
    MenuItem(label: 'Yapılacaklar', icon: Icons.checklist),
    MenuItem(label: 'Akademik Danışman', icon: Icons.support_agent),
    MenuItem(label: 'Hazırlık Bilgileri', icon: Icons.assignment_ind),
  ];
}
