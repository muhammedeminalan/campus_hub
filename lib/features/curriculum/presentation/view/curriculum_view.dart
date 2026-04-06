import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/curriculum/data/model/curriculum_model.dart';
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
  const CurriculumView({super.key, this.cubit});

  final CurriculumCubit? cubit;

  @override
  Widget build(BuildContext context) {
    final injectedCubit = cubit;
    if (injectedCubit != null) {
      return BlocProvider.value(
        value: injectedCubit,
        child: const _CurriculumBody(),
      );
    }

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
      _buildFilterTrigger(
        state,
      ).paddingOnly(left: AppSize.v16, right: AppSize.v16, top: AppSize.v12),
      AppStrings.curriculumFilterHelper.text
          .bodySmall(context)
          .color(context.onSurfaceColor.withValues(alpha: 0.6))
          .paddingOnly(left: AppSize.v16, right: AppSize.v16, top: AppSize.v10),
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
          Text(
            '$selectedClass • $selectedSemester',
            key: const ValueKey('curriculum_selected_category_text'),
            style: context.textTheme.labelLarge?.copyWith(
              color: context.onPrimaryColor.withValues(alpha: 0.9),
            ),
          ),
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

  Widget _buildFilterTrigger(CurriculumLoaded state) {
    final selectedClass = state.selectedClassLevel != null
        ? AppStrings.curriculumClassLabel(state.selectedClassLevel!)
        : '-';
    final selectedSemester = state.selectedSemester != null
        ? AppStrings.curriculumSemesterLabel(state.selectedSemester!)
        : '-';

    return InkWell(
      key: const ValueKey('curriculum_filter_open_button'),
      onTap: () => _showFilterBottomSheet(context, state),
      borderRadius: BorderRadius.circular(AppSize.v12),
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: AppStrings.curriculumFilterSheetTitle,
          prefixIcon: Icon(Icons.tune, color: context.primaryColor),
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.primaryColor,
          ),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSize.v16,
            vertical: AppSize.v14,
          ),
        ),
        child: Text(
          '$selectedClass • $selectedSemester',
          key: const ValueKey('curriculum_filter_current_value_text'),
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
  }

  Future<void> _showFilterBottomSheet(
    BuildContext context,
    CurriculumLoaded state,
  ) {
    final cubit = context.read<CurriculumCubit>();
    final classLevels = state.classLevels;

    if (classLevels.isEmpty) return Future.value();

    int selectedClassLevel = state.selectedClassLevel ?? classLevels.first;
    List<int> semesters = _resolveSemestersForClass(
      state.allCurriculums,
      selectedClassLevel,
    );
    int? selectedSemester = semesters.contains(state.selectedSemester)
        ? state.selectedSemester
        : (semesters.isNotEmpty ? semesters.first : null);

    return Wonzy.bottomSheet.show(
      context,
      title: AppStrings.curriculumFilterSheetTitle,
      titleColor: context.primaryColor,
      showHandle: true,
      handleColor: AppColors.onSurface,
      borderRadius: 20,
      elevation: 8,
      maxHeight: 0.8,
      isDismissible: true,
      enableDrag: true,
      isDraggable: true,
      useSafeArea: true,
      initialChildSize: 0.55,
      minChildSize: 0.45,
      maxChildSize: 0.85,
      isScrollable: true,
      child: StatefulBuilder(
        builder: (context, setSheetState) {
          return [
            CurriculumFilterSection(
              title: AppStrings.curriculumClassFilterTitle,
              child: Wrap(
                spacing: AppSize.v8,
                runSpacing: AppSize.v8,
                children: classLevels.map((classLevel) {
                  final isSelected = classLevel == selectedClassLevel;
                  return _FilterPill(
                    label: AppStrings.curriculumClassLabel(classLevel),
                    isSelected: isSelected,
                    onTap: () {
                      setSheetState(() {
                        selectedClassLevel = classLevel;
                        semesters = _resolveSemestersForClass(
                          state.allCurriculums,
                          selectedClassLevel,
                        );
                        selectedSemester = semesters.isNotEmpty
                            ? semesters.first
                            : null;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            CurriculumFilterSection(
              title: AppStrings.curriculumSemesterFilterTitle,
              child: Wrap(
                spacing: AppSize.v8,
                runSpacing: AppSize.v8,
                children: semesters.map((semester) {
                  final isSelected = semester == selectedSemester;
                  return _FilterPill(
                    label: AppStrings.curriculumSemesterLabel(semester),
                    isSelected: isSelected,
                    onTap: () {
                      setSheetState(() {
                        selectedSemester = semester;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            [
              OutlinedButton(
                onPressed: () {
                  cubit.resetFilters();
                  context.pop();
                },
                child: AppStrings.curriculumResetFilters.text,
              ).expanded(),
              ElevatedButton(
                key: const ValueKey('curriculum_filter_apply_button'),
                onPressed: selectedSemester == null
                    ? null
                    : () {
                        cubit.applyFilters(
                          classLevel: selectedClassLevel,
                          semester: selectedSemester!,
                        );
                        context.pop();
                      },
                child: AppStrings.curriculumApplyFilters.text,
              ).expanded(),
            ].row(spacing: AppSize.v12),
          ].column(spacing: AppSize.v16, mainAxisSize: .min);
        },
      ),
    );
  }

  List<int> _resolveSemestersForClass(
    List<CurriculumModel> allCurriculums,
    int classLevel,
  ) {
    final semesters =
        allCurriculums
            .where((curriculum) => curriculum.classLevel == classLevel)
            .map((curriculum) => curriculum.semester)
            .toSet()
            .toList()
          ..sort();

    return semesters;
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

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isSelected
        ? context.primaryColor
        : context.onSurfaceColor.withValues(alpha: 0.75);

    return GestureDetector(
      onTap: onTap,
      child: label.text
          .labelMedium(context)
          .semiBold
          .color(foregroundColor)
          .paddingSymmetric(h: AppSize.v12, v: AppSize.v8)
          .container(
            color: isSelected
                ? context.primaryColor.withValues(alpha: 0.12)
                : context.surfaceColor,
            borderRadius: AppSize.v10,
            border: Border.all(
              color: isSelected
                  ? context.primaryColor.withValues(alpha: 0.35)
                  : AppColors.border,
            ),
          ),
    );
  }
}
