import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/course_model.dart';
import '../../../../core/models/period_model.dart';
import '../../../../core/ui/widgets/app_list_view.dart';
import '../../../../core/ui/widgets/course_card.dart';
import '../widgets/period_list_tile.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CoursesCubit>()..loadData(),
      child: const _CoursesBody(),
    );
  }
}

class _CoursesBody extends StatelessWidget {
  const _CoursesBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) => switch (state) {
          CoursesInitial() || CoursesLoading() => _buildLoading(),
          CoursesError() => _buildError(context),
          CoursesLoaded() => _buildContent(context, state),
        },
      ),
    ).safeArea();
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(BuildContext context) {
    return [
      Icon(
        Icons.error_outline,
        size: 64,
        color: context.onSurfaceColor.withValues(alpha: 0.4),
      ),
      AppSize.v16.h,
      'Veriler yüklenemedi'.text.titleMedium(context).center,
      AppSize.v8.h,
      'Lütfen tekrar deneyin.'.text
          .bodySmall(context)
          .color(context.onSurfaceColor.withValues(alpha: 0.5))
          .center,
      AppSize.v24.h,
      TextButton.icon(
        onPressed: () => context.read<CoursesCubit>().loadData(),
        icon: const Icon(Icons.refresh),
        label: const Text('Yeniden Dene'),
      ),
    ].column(mainAxisAlignment: .center).center;
  }

  Widget _buildContent(BuildContext context, CoursesLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPeriodSelector(context, state).paddingAll(AppSize.v16),
        _buildCourseList(context, state),
      ],
    );
  }

  Widget _buildPeriodSelector(BuildContext context, CoursesLoaded state) {
    return CustomTextField(
      name: 'selectPeriod',
      hint: state.selectedPeriod?.name ?? 'Dönem Seçiniz',
      readOnly: true,
      onTap: () => _showPeriodBottomSheet(context, state),
      suffixIcon: Icon(Icons.filter_list_alt, color: context.primaryColor),
    );
  }

  Widget _buildCourseList(BuildContext context, CoursesLoaded state) {
    return AppListView<CourseModel>(
      items: state.filteredCourses,
      isLoading: false,
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

  Widget _buildCourseCard(CourseModel course, int index) {
    return CourseCard(
      title: course.title,
      grade: course.grade,
      classInfo: course.classInfo,
      instructor: course.instructor,
      credit: course.credit,
      akts: course.akts,
      onTap: () {
        'CourseCard $index tıklandı'.infoLog();
      },
    );
  }

  Future<void> _showPeriodBottomSheet(
    BuildContext context,
    CoursesLoaded state,
  ) {
    // Cubit'i bottom sheet açılmadan önce yakala —
    // modal route kendi context'ini oluşturduğundan dışarıdan alınır.
    final cubit = context.read<CoursesCubit>();
    return CostumBottomSheet.show(
      context,
      title: 'Dönem Seçiniz',
      titleColor: context.primaryColor,
      child: [
        _buildPeriodList(context, state, cubit),
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

  Widget _buildPeriodList(
    BuildContext context,
    CoursesLoaded state,
    CoursesCubit cubit,
  ) {
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
      items: state.periods,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, _) => context.divider(),
      itemBuilder: (context, period, index) {
        return PeriodListTile(
          period: period.name,
          isSelected: period.id == state.selectedPeriod?.id,
          onTap: () {
            cubit.selectPeriod(period);
            context.pop();
          },
        );
      },
    );
  }
}
