import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/utils/index.dart';
import 'package:campus_hub/core/utils/widgets/buttons/costum_button.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        const TextField(
          decoration: InputDecoration(labelText: 'Öğretmen Numarası'),
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
