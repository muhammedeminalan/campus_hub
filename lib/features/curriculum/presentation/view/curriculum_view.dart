import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/curriculum/presentation/cubit/curriculum_cubit.dart';
import 'package:campus_hub/features/curriculum/presentation/widgets/curriculum_course_card.dart';
import 'package:campus_hub/features/curriculum/presentation/widgets/curriculum_empty_state.dart';
import 'package:campus_hub/features/curriculum/presentation/widgets/curriculum_filter_section.dart';
import 'package:campus_hub/shared/widgets/app_bar/core_app_bar.dart';
import 'package:campus_hub/shared/widgets/errors/app_error_view.dart';
import 'package:campus_hub/shared/widgets/lists/app_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class CurriculumView extends StatelessWidget {
  const CurriculumView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CurriculumCubit>(),
      child: const _CurriculumBody(),
    );
  }
}

class _CurriculumBody extends StatefulWidget {
  const _CurriculumBody();

  @override
  State<_CurriculumBody> createState() => _CurriculumBodyState();
}

class _CurriculumBodyState extends State<_CurriculumBody> {
  @override
  void initState() {
    super.initState();
    context.read<CurriculumCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(title: AppStrings.curriculum),
      body: BlocBuilder<CurriculumCubit, CurriculumState>(
        builder: (context, state) => switch (state) {
          CurriculumInitial() ||
          CurriculumLoading() => const CircularProgressIndicator().center,
          CurriculumError(:final message) => AppErrorView(
            message: AppStrings.curriculumLoadError,
            subMessage: message ?? AppStrings.curriculumLoadErrorSub,
            onRetry: () => context.read<CurriculumCubit>().loadData(),
          ),
          CurriculumLoaded() => _buildContent(state),
        },
      ),
    );
  }

  Widget _buildContent(CurriculumLoaded state) {
    final selectedCount = state.filteredCurriculums.length;
    final totalCredit = state.filteredCurriculums.fold<int>(
      0,
      (sum, item) => sum + item.credit,
    );
    final totalAkts = state.filteredCurriculums.fold<int>(
      0,
      (sum, item) => sum + item.akts,
    );

    return [
      _buildSummaryCard(
        state,
        selectedCount: selectedCount,
        totalCredit: totalCredit,
        totalAkts: totalAkts,
      ).paddingOnly(left: AppSize.v16, right: AppSize.v16, top: AppSize.v16),
      _buildFilterPanel(
        state,
      ).paddingOnly(left: AppSize.v16, right: AppSize.v16, top: AppSize.v12),
      _buildListHeader(selectedCount).paddingOnly(
        left: AppSize.v16,
        right: AppSize.v16,
        top: AppSize.v16,
        bottom: AppSize.v8,
      ),
      _buildCurriculumList(state).expanded(),
    ].column(crossAxisAlignment: .start);
  }

  Widget _buildSummaryCard(
    CurriculumLoaded state, {
    required int selectedCount,
    required int totalCredit,
    required int totalAkts,
  }) {
    final selectedClass = state.selectedClassLevel != null
        ? AppStrings.curriculumClassLabel(state.selectedClassLevel!)
        : '-';
    final selectedSemester = state.selectedSemester != null
        ? AppStrings.curriculumSemesterLabel(state.selectedSemester!)
        : '-';

    return [
          AppStrings.curriculumSelectedTitle.text
              .titleMedium(context)
              .semiBold
              .color(context.onPrimaryColor),
          AppSize.v6.h,
          '$selectedClass • $selectedSemester'.text
              .labelLarge(context)
              .color(context.onPrimaryColor.withValues(alpha: 0.9)),
          AppSize.v6.h,
          AppStrings.curriculumSelectedSub.text
              .bodySmall(context)
              .color(context.onPrimaryColor.withValues(alpha: 0.75)),
          AppSize.v14.h,
          [
            _buildMetricItem(
              label: AppStrings.curriculumSelectedCourseCount,
              value: '$selectedCount',
            ),
            _buildMetricItem(
              label: AppStrings.curriculumTotalCredit,
              value: '$totalCredit',
            ),
            _buildMetricItem(
              label: AppStrings.curriculumTotalAkts,
              value: '$totalAkts',
            ),
          ].row(mainAxisAlignment: .spaceBetween),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v16)
        .container(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppSize.v16,
        );
  }

  Widget _buildMetricItem({required String label, required String value}) {
    return [
      value.text
          .titleLarge(context)
          .semiBold
          .color(context.onPrimaryColor)
          .center,
      AppSize.v2.h,
      label.text
          .labelSmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.75))
          .center,
    ].column();
  }

  Widget _buildFilterPanel(CurriculumLoaded state) {
    return [
          [
            AppStrings.curriculumClassFilterTitle.text
                .titleSmall(context)
                .semiBold,
            TextButton(
              onPressed: () => context.read<CurriculumCubit>().resetFilters(),
              child: AppStrings.curriculumResetFilters.text,
            ),
          ].row(mainAxisAlignment: .spaceBetween),
          AppSize.v8.h,
          Wrap(
            spacing: AppSize.v8,
            runSpacing: AppSize.v8,
            children: state.classLevels.map((classLevel) {
              final isSelected = classLevel == state.selectedClassLevel;
              return ChoiceChip(
                label: AppStrings.curriculumClassLabel(classLevel).text,
                selected: isSelected,
                onSelected: (_) => context
                    .read<CurriculumCubit>()
                    .selectClassLevel(classLevel),
              );
            }).toList(),
          ),
          AppSize.v14.h,
          CurriculumFilterSection(
            title: AppStrings.curriculumSemesterFilterTitle,
            child: Wrap(
              spacing: AppSize.v8,
              runSpacing: AppSize.v8,
              children: state.semesters.map((semester) {
                final isSelected = semester == state.selectedSemester;
                return ChoiceChip(
                  label: AppStrings.curriculumSemesterLabel(semester).text,
                  selected: isSelected,
                  onSelected: (_) =>
                      context.read<CurriculumCubit>().selectSemester(semester),
                );
              }).toList(),
            ),
          ),
          AppSize.v10.h,
          AppStrings.curriculumFilterHelper.text
              .bodySmall(context)
              .color(context.onSurfaceColor.withValues(alpha: 0.6)),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v16)
        .container(
          color: context.surfaceColor,
          borderRadius: AppSize.v16,
          border: Border.all(color: AppColors.border),
        );
  }

  Widget _buildListHeader(int selectedCount) {
    return [
      AppStrings.curriculumListTitle.text.titleMedium(context).semiBold,
      '$selectedCount ${AppStrings.curriculumSelectedCourseCount}'.text
          .labelMedium(context)
          .semiBold
          .color(context.primaryColor)
          .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
          .container(
            color: context.primaryColor.withValues(alpha: 0.1),
            borderRadius: AppSize.v20,
          ),
    ].row(mainAxisAlignment: .spaceBetween);
  }

  Widget _buildCurriculumList(CurriculumLoaded state) {
    return AppListView(
      items: state.filteredCurriculums,
      isLoading: false,
      padding: AppSize.v16.horizontal,
      emptyWidget: CurriculumEmptyState(
        classLevel: state.selectedClassLevel,
        semester: state.selectedSemester,
        onResetFilters: () => context.read<CurriculumCubit>().resetFilters(),
      ),
      itemBuilder: (context, curriculum, index) {
        return CurriculumCourseCard(
          curriculum: curriculum,
        ).paddingOnly(bottom: AppSize.v12);
      },
    );
  }
}
