import 'package:campus_hub/core/constants/app_assets.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

/// Login sayfası üst kısmındaki uygulama logosu.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAssets.appLogo
        .asAssetImage(width: AppSize.v200)
        .paddingSymmetric(v: AppSize.v24);
  }
}
