import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/academic_status/presentation/cubit/academic_status_cubit.dart';
import 'package:campus_hub/features/academic_status/presentation/widgets/academic_status_course_tile.dart';
import 'package:campus_hub/features/academic_status/presentation/widgets/academic_status_empty_state.dart';
import 'package:campus_hub/features/academic_status/presentation/widgets/academic_status_summary_card.dart';
import 'package:campus_hub/shared/widgets/app_bar/core_app_bar.dart';
import 'package:campus_hub/shared/widgets/errors/app_error_view.dart';
import 'package:campus_hub/shared/widgets/lists/app_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Öğrencinin akademik durum ekranı.
/// Neden: hızlı menüden girilen durumda özet ve ders detayını tek yerde sunmak.
class AcademicStatusView extends StatelessWidget {
  const AcademicStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AcademicStatusCubit>(),
      child: const _AcademicStatusBody(),
    );
  }
}

class _AcademicStatusBody extends StatefulWidget {
  const _AcademicStatusBody();

  @override
  State<_AcademicStatusBody> createState() => _AcademicStatusBodyState();
}

class _AcademicStatusBodyState extends State<_AcademicStatusBody> {
  @override
  void initState() {
    super.initState();
    context.read<AcademicStatusCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(title: AppStrings.academicStatus),
      body: BlocBuilder<AcademicStatusCubit, AcademicStatusState>(
        builder: (context, state) => switch (state) {
          AcademicStatusInitial() ||
          AcademicStatusLoading() => const CircularProgressIndicator().center,
          AcademicStatusError(:final message) => AppErrorView(
            message: AppStrings.academicStatusLoadError,
            subMessage: message ?? AppStrings.academicStatusLoadErrorSub,
            onRetry: () => context.read<AcademicStatusCubit>().loadData(),
          ),
          AcademicStatusLoaded() => _buildContent(state),
        },
      ),
    );
  }

  Widget _buildContent(AcademicStatusLoaded state) {
    return [
      AcademicStatusSummaryCard(
        status: state.status,
        summary: state.summary,
      ).paddingOnly(left: AppSize.v16, right: AppSize.v16, top: AppSize.v16),
      AppSize.v12.h,
      AppStrings.academicStatusCourseListTitle.text
          .titleMedium(context)
          .semiBold
          .paddingSymmetric(h: AppSize.v16),
      AppSize.v6.h,
      _buildCourseList(state).expanded(),
    ].column(crossAxisAlignment: .start);
  }

  Widget _buildCourseList(AcademicStatusLoaded state) {
    return AppListView(
      items: state.status.courses,
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v8,
        AppSize.v16,
        AppSize.v24,
      ),
      emptyWidget: const AcademicStatusEmptyState(),
      itemBuilder: (context, course, index) {
        return AcademicStatusCourseTile(
          course: course,
        ).paddingOnly(bottom: AppSize.v12);
      },
    );
  }
}
