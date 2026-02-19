import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class TeacherLoginView extends StatefulWidget {
  const TeacherLoginView({super.key});

  @override
  State<TeacherLoginView> createState() => _TeacherLoginViewState();
}

class _TeacherLoginViewState extends State<TeacherLoginView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        const TextField(
          decoration: InputDecoration(labelText: AppStrings.teacherNumber),
        ),
        AppSize.v24.height,
        const TextField(
          decoration: InputDecoration(labelText: AppStrings.password),
          obscureText: true,
        ),
        AppSize.v24.height,
        _loginButton(context),
      ],
    ).paddingSymmetric(h: AppSize.v24, v: AppSize.v16);
  }

  CostumButton _loginButton(BuildContext context) {
    return CostumButton(
      text: AppStrings.login,
      textStyle: context.textTheme.labelLarge?.copyWith(fontWeight: .bold),
      onPressed: () {},
    );
  }
}
