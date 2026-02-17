import 'package:campus_hub/core/constants/app_assets.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

/// Login sayfası üst kısmındaki uygulama logosu.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  static const _verticalPadding = AppSize.v24;
  static const _logoWidth = AppSize.v200;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
      child: Image.asset(AppAssets.appLogo, width: _logoWidth),
    );
  }
}
