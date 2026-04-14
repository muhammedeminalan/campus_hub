import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/absence_status/presentation/cubit/absence_status_cubit.dart';
import 'package:campus_hub/features/absence_status/presentation/widgets/absence_course_tile.dart';
import 'package:campus_hub/features/absence_status/presentation/widgets/absence_empty_state.dart';
import 'package:campus_hub/features/absence_status/presentation/widgets/absence_summary_card.dart';
import 'package:campus_hub/shared/widgets/app_bar/core_app_bar.dart';
import 'package:campus_hub/shared/widgets/errors/app_error_view.dart';
import 'package:campus_hub/shared/widgets/lists/app_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Ders bazlı devamsızlık durumu ekranı.
/// Neden: öğrenciye hangi derste ne kadar hak kaldığını sade ve net göstermek.
class AbsenceStatusView extends StatelessWidget {
  const AbsenceStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AbsenceStatusCubit>(),
      child: const _AbsenceStatusBody(),
    );
  }
}

class _AbsenceStatusBody extends StatefulWidget {
  const _AbsenceStatusBody();

  @override
  State<_AbsenceStatusBody> createState() => _AbsenceStatusBodyState();
}

class _AbsenceStatusBodyState extends State<_AbsenceStatusBody> {
  @override
  void initState() {
    super.initState();
    context.read<AbsenceStatusCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(title: AppStrings.absenceStatus),
      body: BlocBuilder<AbsenceStatusCubit, AbsenceStatusState>(
        builder: (context, state) => switch (state) {
          AbsenceStatusInitial() ||
          AbsenceStatusLoading() => const CircularProgressIndicator().center,
          AbsenceStatusError(:final message) => AppErrorView(
            message: AppStrings.absenceLoadError,
            subMessage: message ?? AppStrings.absenceLoadErrorSub,
            onRetry: () => context.read<AbsenceStatusCubit>().loadData(),
          ),
          AbsenceStatusLoaded() => _buildContent(state),
        },
      ),
    );
  }

  Widget _buildContent(AbsenceStatusLoaded state) {
    return [
      AbsenceSummaryCard(
        summary: state.summary,
      ).paddingOnly(left: AppSize.v16, right: AppSize.v16, top: AppSize.v16),
      AppSize.v12.h,
      AppStrings.absenceListTitle.text
          .titleMedium(context)
          .semiBold
          .paddingSymmetric(h: AppSize.v16),
      AppSize.v6.h,
      _buildCourseList(state).expanded(),
    ].column(crossAxisAlignment: .start);
  }

  Widget _buildCourseList(AbsenceStatusLoaded state) {
    return AppListView(
      items: state.courses,
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v8,
        AppSize.v16,
        AppSize.v24,
      ),
      emptyWidget: const AbsenceEmptyState(),
      itemBuilder: (context, course, index) {
        return AbsenceCourseTile(
          course: course,
        ).paddingOnly(bottom: AppSize.v12);
      },
    );
  }
}
