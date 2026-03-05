import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/ui/widgets/app_error_view.dart';
import 'package:campus_hub/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
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
      create: (_) => sl<CoursesCubit>(),
      child: const _CoursesBody(),
    );
  }
}

class _CoursesBody extends StatefulWidget {
  const _CoursesBody();

  @override
  State<_CoursesBody> createState() => _CoursesBodyState();
}

class _CoursesBodyState extends State<_CoursesBody> {
  @override
  void initState() {
    super.initState();
    // IndexedStack tüm sekmeleri baştan mount eder; loadData'yı
    // initState'e taşıyarak yalnızca widget ağacına eklendiğinde
    // veri çekimi başlatılır.
    context.read<CoursesCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.courses),
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) => switch (state) {
          CoursesInitial() || CoursesLoading() => _buildLoading(),
          CoursesError(:final message) => AppErrorView(
            message: AppStrings.coursesLoadError,
            subMessage: message ?? AppStrings.coursesLoadErrorSub,
            onRetry: () => context.read<CoursesCubit>().loadData(),
          ),
          CoursesLoaded() => _buildContent(context, state),
        },
      ),
    ).safeArea(top: false);
  }

  Widget _buildLoading() {
    return const CircularProgressIndicator().center;
  }

  Widget _buildContent(BuildContext context, CoursesLoaded state) {
    return [
      _buildPeriodSelector(context, state).paddingAll(AppSize.v16),
      _buildCourseList(context, state),
    ].column(crossAxisAlignment: .start);
  }

  Widget _buildPeriodSelector(BuildContext context, CoursesLoaded state) {
    // CustomTextField'ın readOnly: true + onTap kombinasyonu semantik olarak
    // hatalıdır. InkWell + InputDecorator kullanımı daha doğru erişilebilirlik
    // davranışı ve semantik anlamı sağlar.
    return InkWell(
      onTap: () => _showPeriodBottomSheet(context, state),
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: AppStrings.selectPeriod,
          suffixIcon: Icon(Icons.filter_list_alt, color: context.primaryColor),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSize.v16,
            vertical: AppSize.v14,
          ),
        ),
        child: Text(
          state.selectedPeriod?.name ?? AppStrings.selectPeriod,
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildCourseList(BuildContext context, CoursesLoaded state) {
    return AppListView<CourseModel>(
      items: state.filteredCourses,
      isLoading: false,
      padding: AppSize.v16.horizontal,
      emptyWidget:
          [
                Icon(
                  Icons.menu_book_outlined,
                  size: 64,
                  color: context.onSurfaceColor.withValues(alpha: 0.3),
                ),
                AppSize.v16.h,
                AppStrings.courseNotFound.text.titleMedium(context).center,
                AppSize.v8.h,
                AppStrings.courseNotFoundSub.text
                    .bodySmall(context)
                    .color(context.onSurfaceColor.withValues(alpha: 0.5))
                    .center,
              ]
              .column(mainAxisAlignment: .center)
              .paddingSymmetric(h: AppSize.v24, v: AppSize.v32),
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
    return CustomBottomSheet.show(
      context,
      title: AppStrings.selectPeriod,
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
      emptyWidget:
          [
                Icon(
                  Icons.school_outlined,
                  size: AppSize.v64,
                  color: context.onSurfaceColor.withValues(alpha: 0.4),
                ),
                AppSize.v12.h,
                AppStrings.periodNotFound.text.titleMedium(context).center,
                AppSize.v8.h,
                AppStrings.periodNotFoundSub.text
                    .bodySmall(context)
                    .color(context.onSurfaceColor.withValues(alpha: 0.6))
                    .center,
              ]
              .column(mainAxisAlignment: .center)
              .paddingSymmetric(h: AppSize.v24, v: AppSize.v32),
      items: state.periods,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, _) => const Divider(),
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
