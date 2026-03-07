import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

class CalendarEventCard extends StatelessWidget {
  // Zorunlu — kartın temel bilgileri
  final String day;
  final String month;
  final String title;

  // İsteğe bağlı — görsel özelleştirme
  final String dateRange;
  final Color? accentColor;
  final void Function() onPressed;

  const CalendarEventCard({
    super.key,
    required this.day,
    required this.month,
    required this.title,
    required this.onPressed,
    required this.dateRange,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return [
      // Sol — tarih kutusu
      _buildDateBox(context),
      AppSize.v16.w,
      // Sağ — başlık ve tarih aralığı
      Expanded(child: _buildContent(context)),
    ].row().asCard().onTap(onPressed);
  }

  Widget _buildDateBox(BuildContext context) {
    return [
          day.text.bold.fontSize(AppSize.v16).color(context.surfaceColor),
          month.text.fontSize(AppSize.v14).color(context.surfaceColor),
        ]
        .column(mainAxisAlignment: .center)
        .roundedBox(
          radius: AppSize.v12,
          backgroundColor: accentColor ?? context.primaryColor,
          width: AppSize.v72,
          height: AppSize.v72,
        );
  }

  Widget _buildContent(BuildContext context) {
    return [
      Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.titleMedium,
      ),
      AppSize.v4.h,
      dateRange.text.bodyMedium(context),
    ].column(crossAxisAlignment: .start, mainAxisAlignment: .center);
  }
}
