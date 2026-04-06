import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Müfredat filtre blokları için ortak başlık + içerik sarmalayıcısı.
class CurriculumFilterSection extends StatelessWidget {
  const CurriculumFilterSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return [
      title.text.titleSmall(context).semiBold,
      AppSize.v8.h,
      child,
    ].column(crossAxisAlignment: .start);
  }
}
