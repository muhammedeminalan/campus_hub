import 'package:campus_hub/core/constants/app_assets.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [card(), _avatar()],
          ),
        ].column(),
      ).paddingHorizontal(AppSize.v8),
    ).safeArea();
  }

  Widget _avatar() {
    return AppAssets.avatar
        .asAssetImage()
        .circleAvatar(
          size: AppSize.v112,
          borderColor: context.onPrimaryColor,
          borderWidth: 4,
        )
        .center;
  }

  Widget card() {
    return [
          [
            AppStrings.studentCardName.text.titleLarge(context),

            AppStrings.studentCardNo.text.labelMedium(context),

            AppStrings.studentCardDepartment.text.labelLarge(context),
          ].column(),
          [
            Icon(Icons.school, size: AppSize.v48, color: context.primaryColor),
            Icon(Icons.school, size: AppSize.v48, color: context.primaryColor),
            Icon(Icons.school, size: AppSize.v48, color: context.primaryColor),
          ].row(spacing: AppSize.v16),
        ]
        .column()
        .paddingOnly(top: AppSize.v64)
        .withOpacity(1.0)
        .sized(width: .infinity, height: context.screenHeight(0.50))
        .container(
          // padding: const .only(top: AppSize.v112 / 2),
          border: .all(color: context.primaryColor, width: 2),
          borderRadius: AppSize.v24,
        )
        .paddingOnly(top: AppSize.v112 / 2);
  }
}
