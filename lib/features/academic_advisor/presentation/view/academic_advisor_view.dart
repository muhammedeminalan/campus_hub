import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/academic_advisor/presentation/cubit/academic_advisor_cubit.dart';
import 'package:campus_hub/features/academic_advisor/presentation/widgets/advisor_contact_card.dart';
import 'package:campus_hub/features/academic_advisor/presentation/widgets/advisor_header_card.dart';
import 'package:campus_hub/features/academic_advisor/presentation/widgets/advisor_office_hours_card.dart';
import 'package:campus_hub/shared/widgets/app_bar/core_app_bar.dart';
import 'package:campus_hub/shared/widgets/errors/app_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class AcademicAdvisorView extends StatelessWidget {
  const AcademicAdvisorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AcademicAdvisorCubit>(),
      child: const _AcademicAdvisorBody(),
    );
  }
}

class _AcademicAdvisorBody extends StatefulWidget {
  const _AcademicAdvisorBody();

  @override
  State<_AcademicAdvisorBody> createState() => _AcademicAdvisorBodyState();
}

class _AcademicAdvisorBodyState extends State<_AcademicAdvisorBody> {
  @override
  void initState() {
    super.initState();
    context.read<AcademicAdvisorCubit>().loadAdvisor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(title: AppStrings.academicAdvisor),
      body: BlocBuilder<AcademicAdvisorCubit, AcademicAdvisorState>(
        builder: (context, state) => switch (state) {
          AcademicAdvisorInitial() ||
          AcademicAdvisorLoading() => const CircularProgressIndicator().center,
          AcademicAdvisorError(:final message) => AppErrorView(
            message: AppStrings.academicAdvisorLoadError,
            subMessage: message ?? AppStrings.academicAdvisorLoadErrorSub,
            onRetry: () => context.read<AcademicAdvisorCubit>().loadAdvisor(),
          ),
          AcademicAdvisorLoaded() => _buildContent(state),
        },
      ),
    );
  }

  Widget _buildContent(AcademicAdvisorLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSize.v16),
      child: [
        AdvisorHeaderCard(advisor: state.advisor),
        AdvisorContactCard(advisor: state.advisor),
        AdvisorOfficeHoursCard(advisor: state.advisor),
      ].column(spacing: AppSize.v16),
    );
  }
}
