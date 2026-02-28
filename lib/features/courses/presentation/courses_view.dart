import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/models/course_model.dart';
import '../../../core/models/period_model.dart';
import '../../../core/ui/widgets/app_list_view.dart';
import '../../../core/ui/widgets/course_card.dart';
import '../../../core/contracts/courses/i_course_service.dart';
import '../../../core/mock/mock_course_service.dart';
import 'widgets/period_list_tile.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  // ── Servis — gerçek API'ye geçmek için bu satırı değiştir ────────────────
  final ICourseService _service = MockCourseService();

  PeriodModel? _selectedPeriod;
  List<PeriodModel> _periods = [];
  List<CourseModel> _courses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final periods = await _service.getPeriods();
    final courses = await _service.getAll();
    setState(() {
      _periods = periods;
      _courses = courses;
      _isLoading = false;
    });
  }

  // Seçili döneme göre filtrelenmiş dersler
  List<CourseModel> get _filteredCourses {
    if (_selectedPeriod == null) return _courses;
    return _courses.where((c) => c.periodId == _selectedPeriod!.id).toList();
  }

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
      hint: _selectedPeriod?.name ?? 'Dönem Seçiniz',
      readOnly: true,
      onTap: () => _showPeriodBottomSheet(context),
      suffixIcon: Icon(Icons.filter_list_alt, color: context.primaryColor),
    );
  }

  // Ders kartı listesi
  Widget _buildCourseList() {
    return AppListView<CourseModel>(
      items: _filteredCourses,
      isLoading: _isLoading,
      padding: AppSize.v16.horizontal,
      emptyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 64,
            color: context.onSurfaceColor.withValues(alpha: 0.3),
          ),
          AppSize.v16.h,
          'Ders Bulunamadı'.text.titleMedium(context).center,
          AppSize.v8.h,
          'Seçili döneme ait ders kaydı mevcut değil.'.text
              .bodySmall(context)
              .color(context.onSurfaceColor.withValues(alpha: 0.5))
              .center,
        ],
      ).paddingSymmetric(h: AppSize.v24, v: AppSize.v32),
      itemBuilder: (context, course, index) =>
          _buildCourseCard(course, index).paddingOnly(bottom: AppSize.v16),
    ).expanded();
  }

  // Tek bir ders kartı
  Widget _buildCourseCard(CourseModel course, int index) {
    return CourseCard(
      title: course.title,
      grade: course.grade,
      classInfo: course.classInfo,
      instructor: course.instructor,
      credit: course.credit,
      akts: course.akts,
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
    return AppListView<PeriodModel>(
      emptyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: AppSize.v64,
            color: context.onSurfaceColor.withValues(alpha: 0.4),
          ),
          AppSize.v12.h,
          'Dönem Bulunamadı'.text.titleMedium(context).center,
          AppSize.v8.h,
          'Kayıtlı dönem bilgisi mevcut değil.'.text
              .bodySmall(context)
              .color(context.onSurfaceColor.withValues(alpha: 0.6))
              .center,
        ],
      ).paddingSymmetric(h: AppSize.v24, v: AppSize.v32),
      items: _periods,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, _) => context.divider(),
      itemBuilder: (context, period, index) {
        return PeriodListTile(
          period: period.name,
          isSelected: period.id == _selectedPeriod?.id,
          onTap: () {
            setState(() => _selectedPeriod = period);
            context.pop();
          },
        );
      },
    );
  }
}
