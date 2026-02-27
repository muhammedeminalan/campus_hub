import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../core/constants/app_sizes.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  var selectedPeriod = "Dönem Seçiniz";
  var periodItem = [
    "2025-2026 Güz Dönemi",
    "2025-2026 Bahar Dönemi",
    "2024-2025 Güz Dönemi",
    "2024-2025 Bahar Dönemi",
    "2023-2024 Güz Dönemi",
    "2023-2024 Bahar Dönemi",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context)).safeArea();
  }

  Widget _buildBody(BuildContext context) {
    return [_periodField(context)]
        .column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .start,
          spacing: AppSize.v24,
        )
        .paddingAll(AppSize.v16);
  }

  CustomTextField _periodField(BuildContext context) {
    return CustomTextField(
      name: 'selectPeriod',
      hint: selectedPeriod,
      readOnly: true,
      onTap: () => _periodBottomSheet(context),

      suffixIcon: Icon(Icons.filter_list_alt, color: context.primaryColor),
    );
  }

  Future<dynamic> _periodBottomSheet(BuildContext context) {
    return CostumBottomSheet.show(
      context,
      title: 'Dönem Seçiniz',
      titleColor: context.primaryColor,

      child: [
        _buildListViewBuilder(),
      ].column(spacing: AppSize.v16, mainAxisSize: .min),
      showHandle: true,
      handleColor: AppColors.onSurface,
      borderRadius: 20,
      elevation: 8,
      maxHeight: 0.8,
      isDismissible: true,
      enableDrag: true,
      isDraggable: true,
      useSafeArea: true,
      initialChildSize: 0.5,
      minChildSize: 0.50,
      maxChildSize: 0.8,
      isScrollable: true,
    );
  }

  ListView _buildListViewBuilder() {
    return ListView.builder(
      itemCount: periodItem.length,

      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return [
          ListTile(
            title: periodItem[index].text.titleMedium(context),
            onTap: () {
              setState(() {
                selectedPeriod = periodItem[index];
              });
              context.pop();
            },
          ),
          context.divider(),
        ].column();
      },
    );
  }
}
