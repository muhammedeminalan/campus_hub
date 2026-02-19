import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wonzy_core_utils/core_utils.dart';

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
      debugPrint('Form values: $values');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar:
          CostumButton(text: AppStrings.save, onPressed: _onSave)
              .paddingSymmetric(h: AppSize.v16, v: AppSize.v8)
              .safeArea()
              .paddingOnly(bottom: MediaQuery.of(context).viewInsets.bottom),
      body: SingleChildScrollView(
        child:
            [
                  'Öğrenci Bilgileri'.text
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
                        ),
                      ],
                    ),
                  ),
                ]
                .column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSize.v24,
                )
                .paddingSymmetric(h: 16, v: 24),
      ).safeArea(),
    ).onTap(() => FocusScope.of(context).unfocus());
  }
}
