import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:campus_hub/features/exam_results/data/model/exam_result_model.dart';
import 'package:campus_hub/features/exam_results/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ExamResults — Sınav sonuçlarını dönem filtresiyle, ders bazında listeler.
// ─────────────────────────────────────────────────────────────────────────────
class ExamResults extends StatefulWidget {
  const ExamResults({super.key});

  @override
  State<ExamResults> createState() => _ExamResultsState();
}

class _ExamResultsState extends State<ExamResults> {
  // Verisi olan en son dönem varsayılan olarak seçilir.
  PeriodModel _selectedPeriod = PeriodModel.mockList.lastWhere(
    (p) => ExamResultModel.mockList.any((r) => r.periodId == p.id),
    orElse: () => PeriodModel.mockList.last,
  );

  // Seçili dönemin sonuçları, ders adına göre gruplu: { ders → [vize, final] }
  Map<String, List<ExamResultModel>> get _grouped {
    final map = <String, List<ExamResultModel>>{};
    for (final r in ExamResultModel.mockList) {
      if (r.periodId == _selectedPeriod.id) {
        map.putIfAbsent(r.courseTitle, () => []).add(r);
      }
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _grouped;
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.examResults),
      body: [
        PeriodSelector(
          selected: _selectedPeriod,
          onTap: () => _showPeriodSheet(context),
        ).paddingAll(AppSize.v16),
        _buildScrollableBody(context, grouped).expanded(),
      ].column(crossAxisAlignment: .start),
    ).safeArea(top: false);
  }

  Widget _buildScrollableBody(
    BuildContext context,
    Map<String, List<ExamResultModel>> grouped,
  ) {
    if (grouped.isEmpty) return EmptyState(period: _selectedPeriod.name);

    final allResults = grouped.values.expand((e) => e).toList();
    final entries = grouped.entries.toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SummaryCard(results: allResults)
              .paddingSymmetric(h: AppSize.v16)
              .paddingOnly(bottom: AppSize.v16),
        ),
        SliverList.separated(
          separatorBuilder: (_, _) => AppSize.v12.h,
          itemCount: entries.length,
          itemBuilder: (_, i) => ExamResultCard(
            courseTitle: entries[i].key,
            exams: entries[i].value,
          ).paddingSymmetric(h: AppSize.v16),
        ),
        SliverToBoxAdapter(child: AppSize.v32.h),
      ],
    );
  }

  void _showPeriodSheet(BuildContext context) {
    CustomBottomSheet.show(
      context,
      title: AppStrings.selectPeriod,
      titleColor: context.primaryColor,
      showHandle: true,
      handleColor: AppColors.onSurface,
      borderRadius: 20,
      isDismissible: true,
      enableDrag: true,
      isDraggable: true,
      useSafeArea: true,
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      isScrollable: true,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: PeriodModel.mockList.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (ctx, i) {
          final period = PeriodModel.mockList[i];
          final isSelected = period.id == _selectedPeriod.id;
          return ListTile(
            title: period.name.text
                .semiBold
                .color(
                  isSelected ? context.primaryColor : AppColors.textPrimary,
                ),
            trailing: isSelected
                ? Icon(Icons.check_circle, color: context.primaryColor)
                : null,
            onTap: () {
              setState(() => _selectedPeriod = period);
              context.pop();
            },
          );
        },
      ),
    );
  }
}
