import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/preparatory_info/presentation/cubit/preparatory_info_cubit.dart';
import 'package:campus_hub/features/preparatory_info/presentation/widgets/preparatory_exam_tile.dart';
import 'package:campus_hub/features/preparatory_info/presentation/widgets/preparatory_module_tile.dart';
import 'package:campus_hub/features/preparatory_info/presentation/widgets/preparatory_summary_card.dart';
import 'package:campus_hub/shared/widgets/app_bar/core_app_bar.dart';
import 'package:campus_hub/shared/widgets/errors/app_error_view.dart';
import 'package:campus_hub/shared/widgets/lists/app_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Hazırlık bilgileri ekranı.
/// Neden: Quick Menu "Hazırlık Bilgileri" rotasına üretim ekranı sağlamak.
class PreparatoryInfoView extends StatelessWidget {
  const PreparatoryInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PreparatoryInfoCubit>(),
      child: const _PreparatoryInfoBody(),
    );
  }
}

class _PreparatoryInfoBody extends StatefulWidget {
  const _PreparatoryInfoBody();

  @override
  State<_PreparatoryInfoBody> createState() => _PreparatoryInfoBodyState();
}

class _PreparatoryInfoBodyState extends State<_PreparatoryInfoBody> {
  @override
  void initState() {
    super.initState();
    context.read<PreparatoryInfoCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(title: AppStrings.preparatoryInfo),
      body: BlocBuilder<PreparatoryInfoCubit, PreparatoryInfoState>(
        builder: (context, state) => switch (state) {
          PreparatoryInfoInitial() ||
          PreparatoryInfoLoading() => const CircularProgressIndicator().center,
          PreparatoryInfoError(:final message) => AppErrorView(
            message: AppStrings.preparatoryLoadError,
            subMessage: message ?? AppStrings.preparatoryLoadErrorSub,
            onRetry: () => context.read<PreparatoryInfoCubit>().loadData(),
          ),
          PreparatoryInfoLoaded() => _buildContent(state),
        },
      ),
    );
  }

  Widget _buildContent(PreparatoryInfoLoaded state) {
    return SingleChildScrollView(
      child: [
        PreparatorySummaryCard(
          info: state.info,
          summary: state.summary,
        ).paddingOnly(left: AppSize.v16, right: AppSize.v16, top: AppSize.v16),
        AppSize.v18.h,
        _buildSectionTitle(AppStrings.preparatoryModulesTitle),
        _buildModuleList(state),
        AppSize.v18.h,
        _buildSectionTitle(AppStrings.preparatoryExamsTitle),
        _buildExamList(state),
        AppSize.v24.h,
      ].column(crossAxisAlignment: .start),
    );
  }

  Widget _buildSectionTitle(String title) {
    return title.text
        .titleMedium(context)
        .semiBold
        .paddingSymmetric(h: AppSize.v16);
  }

  Widget _buildModuleList(PreparatoryInfoLoaded state) {
    return AppListView(
      items: state.info.modules,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v10,
        AppSize.v16,
        0,
      ),
      itemBuilder: (context, module, index) {
        return PreparatoryModuleTile(
          module: module,
        ).paddingOnly(bottom: AppSize.v10);
      },
    );
  }

  Widget _buildExamList(PreparatoryInfoLoaded state) {
    return AppListView(
      items: state.info.exams,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v10,
        AppSize.v16,
        0,
      ),
      itemBuilder: (context, exam, index) {
        return PreparatoryExamTile(exam: exam).paddingOnly(bottom: AppSize.v10);
      },
    );
  }
}
