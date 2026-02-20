import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/bottom_navigation/view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class StudentInformation extends StatefulWidget {
  const StudentInformation({super.key});

  @override
  State<StudentInformation> createState() => _StudentInformationState();
}

class _StudentInformationState extends State<StudentInformation> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _onSave() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      '$values'.infoLog(name: "STUDENT_INFO SAVED");
      context.pushAndRemoveUntilPage(const BottomNavigationView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _savedButton(),
      body: _buildBody(context).safeArea(),
    ).onTap(() => FocusScope.of(context).unfocus());
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      child: _forms(context)
          .column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            spacing: AppSize.v28,
          )
          .paddingSymmetric(h: AppSize.v16, v: AppSize.v24)
          .paddingOnly(bottom: MediaQuery.of(context).viewInsets.bottom),
    );
  }

  List<Widget> _forms(BuildContext context) {
    return [
      AppStrings.studentInfo.text
          .titleLarge(context)
          .color(context.primaryColor)
          .center,
      FormBuilder(
        key: _formKey,
        child: const Column(
          spacing: AppSize.v16,
          children: [
            CustomTextField(
              name: 'name',
              label: AppStrings.name,
              required: true,
            ),
            CustomTextField(
              name: 'surname',
              label: AppStrings.surname,
              required: true,
            ),
            CustomTextField(
              name: 'studentNo',
              type: CustomFieldType.studentNumber,
              label: AppStrings.studentNo,
              required: true,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              name: 'university',
              label: AppStrings.studentUniversity,
              required: true,
            ),
            CustomTextField(
              name: 'faculty',
              label: AppStrings.studentFaculty,
              required: true,
            ),
            CustomTextField(
              name: 'department',
              label: AppStrings.studentDepartment,
              required: true,
            ),
            CustomTextField(
              name: 'class',
              label: AppStrings.studentClass,
              required: true,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    ];
  }

  Widget _savedButton() {
    return CostumButton(
      text: AppStrings.save,
      textStyle: context.textTheme.labelLarge?.copyWith(fontWeight: .bold),
      onPressed: _onSave,
    ).paddingSymmetric(h: AppSize.v16, v: AppSize.v8).safeArea();
  }
}
