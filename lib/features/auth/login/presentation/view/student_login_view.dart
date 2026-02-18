import 'package:campus_hub/core/constants/app_strings.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        const TextField(
          decoration: InputDecoration(labelText: 'Öğrenci Numarası'),
        ),
        16.height,
        const TextField(
          decoration: InputDecoration(labelText: 'Şifre'),
          obscureText: true,
        ),
        24.height,
        CostumButton(text: AppStrings.login, onPressed: () {}),
      ],
    );
  }
}
