import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/ui/widgets/course_card.dart';
import 'widgets/period_list_tile.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  // Seçili dönem ve dönem listesi
  var _selectedPeriod = "Dönem Seçiniz";
  final _periods = [
    "2025-2026 Güz Dönemi",
    "2025-2026 Bahar Dönemi",
    "2024-2025 Güz Dönemi",
    "2024-2025 Bahar Dönemi",
    "2023-2024 Güz Dönemi",
    "2023-2024 Bahar Dönemi",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context)).safeArea();
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPeriodSelector(context).paddingAll(AppSize.v16),
        _buildCourseList(),
      ],
    );
  }

  // Dönem seçim alanı
  Widget _buildPeriodSelector(BuildContext context) {
    return CustomTextField(
      name: 'selectPeriod',
      hint: _selectedPeriod,
      readOnly: true,
      onTap: () => _showPeriodBottomSheet(context),
      suffixIcon: Icon(Icons.filter_list_alt, color: context.primaryColor),
    );
  }

  // Ders kartı listesi
  Widget _buildCourseList() {
    return ListView.builder(
      padding: AppSize.v16.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildCourseCard(index).paddingOnly(bottom: AppSize.v16);
      },
    ).expanded();
  }

  // Tek bir ders kartı
  Widget _buildCourseCard(int index) {
    return CourseCard(
      title: 'Yazılım Mühendisliği',
      grade: 'FF',
      classInfo: '2.Sınıf - YBS 208 (1)',
      instructor: 'Dr. Öğr. Üyesi Ahmet Yılmaz',
      credit: 3,
      akts: 5,
      onTap: () {
        "CourseCard $index tıklandı".infoLog();
      },
    );
  }

  // Dönem seçim bottom sheet
  Future<void> _showPeriodBottomSheet(BuildContext context) {
    return CostumBottomSheet.show(
      context,
      title: 'Dönem Seçiniz',
      titleColor: context.primaryColor,
      child: [
        _buildPeriodList(),
      ].column(spacing: AppSize.v16, mainAxisSize: .min),
      showHandle: true,
      handleColor: AppColors.onSurface,
      borderRadius: 20,
      elevation: 8,
      maxHeight: 0.8,
      isDismissible: true,
      enableDrag: true,
      isDraggable: true,
      useSafeArea: true,
      initialChildSize: 0.5,
      minChildSize: 0.50,
      maxChildSize: 0.8,
      isScrollable: true,
    );
  }

  // Bottom sheet içindeki dönem listesi
  Widget _buildPeriodList() {
    return ListView.builder(
      itemCount: _periods.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final isSelected = _periods[index] == _selectedPeriod;
        return [
          PeriodListTile(
            period: _periods[index],
            isSelected: isSelected,
            onTap: () {
              setState(() => _selectedPeriod = _periods[index]);
              context.pop();
            },
          ),
          if (index < _periods.length - 1) context.divider(),
        ].column();
      },
    );
  }
}
