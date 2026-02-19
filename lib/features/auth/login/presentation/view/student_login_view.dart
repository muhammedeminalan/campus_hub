import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/student_information/presentation/view/student_information.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class StudentLoginView extends StatefulWidget {
  const StudentLoginView({super.key});

  @override
  State<StudentLoginView> createState() => _StudentLoginViewState();
}

class _StudentLoginViewState extends State<StudentLoginView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        const TextField(
          decoration: InputDecoration(labelText: AppStrings.studentNumber),
        ),
        AppSize.v16.height,
        const TextField(
          decoration: InputDecoration(labelText: AppStrings.password),
          obscureText: true,
        ),
        AppSize.v24.height,
        CostumButton(
          text: AppStrings.login,
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            await context.pushAndRemoveUntilPage(const StudentInformation());
            if (mounted) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
        ),
      ],
    ).paddingSymmetric(h: AppSize.v24, v: AppSize.v16);
  }
}
