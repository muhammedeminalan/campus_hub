import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String grade; // not hesaplanmadıysa "--" geçilir
  final String classInfo; // "2.Sınıf - YBS 208 (1)"
  final String instructor;
  final int credit;
  final int akts;

  const CourseCard({
    super.key,
    required this.title,
    required this.grade,
    required this.classInfo,
    required this.instructor,
    required this.credit,
    required this.akts,
  });
  //
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .zero,
      clipBehavior: .antiAlias,
      child: [
        _buildHeader(context),
        context.divider(color: context.onSurfaceColor),
        //AppSize.v4.h.container(color: context.onPrimaryColor),
        _buildContent(),
      ].column(crossAxisAlignment: .stretch),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return title.text
        .color(context.onPrimaryColor)
        .fontSize(AppSize.v16)
        .semiBold
        .paddingSymmetric(h: AppSize.v16, v: AppSize.v14)
        .container(color: context.primaryColor);
  }

  Widget _buildContent() {
    return [
      _buildGradeCircle(),
      AppSize.v16.w,
      _buildInfoColumn().expanded(),
    ].row().paddingAll(AppSize.v16);
  }

  Widget _buildGradeCircle() {
    return grade.text
        .fontSize(AppSize.v16)
        .bold
        .color(AppColors.textPrimary)
        .center
        .sized(width: AppSize.v64, height: AppSize.v64)
        .container(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.warning, width: 2.5),
        );
  }

  Widget _buildInfoColumn() {
    return [
      classInfo.text.fontSize(AppSize.v14).color(AppColors.textPrimary),
      AppSize.v4.h,
      instructor.text.fontSize(AppSize.v14).color(AppColors.textPrimary),
      AppSize.v4.h,
      'Kredi : $credit    AKTS : $akts'.text
          .fontSize(AppSize.v12)
          .color(AppColors.textSecondary),
    ].column(crossAxisAlignment: .start);
  }
}
