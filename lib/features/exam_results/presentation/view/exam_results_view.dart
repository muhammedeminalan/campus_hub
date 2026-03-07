import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/exam_results/presentation/cubit/exam_results_cubit.dart';
import 'package:campus_hub/features/exam_results/presentation/widgets/widgets.dart';
import 'package:campus_hub/shared/widgets/errors/app_error_view.dart';
import 'package:campus_hub/shared/widgets/selectors/period_list_tile.dart';
import 'package:campus_hub/shared/widgets/selectors/period_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ExamResults — Sınav sonuçlarını dönem filtresiyle, ders bazında listeler.
// ─────────────────────────────────────────────────────────────────────────────
class ExamResultsView extends StatelessWidget {
  const ExamResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ExamResultsCubit>(),
      child: const _ExamResultsBody(),
    );
  }
}

class _ExamResultsBody extends StatefulWidget {
  const _ExamResultsBody();

  @override
  State<_ExamResultsBody> createState() => _ExamResultsBodyState();
}

class _ExamResultsBodyState extends State<_ExamResultsBody> {
  @override
  void initState() {
    super.initState();
    // IndexedStack tüm sekmeleri baştan mount eder; loadData'yı
    // initState'e taşıyarak yalnızca widget ağacına eklendiğinde
    // veri çekimi başlatılır.
    context.read<ExamResultsCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Wonzy.appBar(title: AppStrings.examResults),
      body: BlocBuilder<ExamResultsCubit, ExamResultsState>(
        builder: (context, state) => switch (state) {
          ExamResultsInitial() || ExamResultsLoading() => _buildLoading(),
          ExamResultsError(:final message) => AppErrorView(
            message: AppStrings.genericError,
            subMessage: message,
            onRetry: () => context.read<ExamResultsCubit>().loadData(),
          ),
          ExamResultsLoaded() => _buildContent(context, state),
        },
      ),
    ).safeArea(top: false);
  }

  Widget _buildLoading() => const CircularProgressIndicator().center;

  Widget _buildContent(BuildContext context, ExamResultsLoaded state) {
    return [
      if (state.selectedPeriod != null)
        PeriodSelector(
          selected: state.selectedPeriod!,
          onTap: () => _showPeriodSheet(context, state),
        ).paddingAll(AppSize.v16),
      _buildScrollableBody(context, state).expanded(),
    ].column(crossAxisAlignment: .start);
  }

  Widget _buildScrollableBody(BuildContext context, ExamResultsLoaded state) {
    if (state.grouped.isEmpty) {
      return EmptyState(period: state.selectedPeriod?.name ?? '');
    }

    final allResults = state.grouped.values.expand((e) => e).toList();
    final entries = state.grouped.entries.toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SummaryCard(
            results: allResults,
          ).paddingSymmetric(h: AppSize.v16).paddingOnly(bottom: AppSize.v16),
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

  void _showPeriodSheet(BuildContext context, ExamResultsLoaded state) {
    // Cubit'i modal açılmadan önce yakala — route kendi context'ini oluşturur.
    final cubit = context.read<ExamResultsCubit>();
    Wonzy.bottomSheet.show(
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
        itemCount: state.periods.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (ctx, i) {
          final period = state.periods[i];
          final isSelected = period.id == state.selectedPeriod?.id;
          return PeriodListTile(
            period: period.name,
            isSelected: isSelected,
            onTap: () {
              cubit.selectPeriod(period);
              context.pop();
            },
          );
        },
      ),
    );
  }
}
