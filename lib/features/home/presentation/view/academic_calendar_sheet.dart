import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/models/academic_calendar_model.dart';
import 'package:campus_hub/features/home/presentation/model/academic_calendar_display_x.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../widgets/calendar_event_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AcademicCalendarBottomSheet — Akademik takvim etkinliklerini modal bottom
// sheet içinde tam liste olarak gösterir.
//
// Kullanım: AcademicCalendarBottomSheet.show(context, events)
// ─────────────────────────────────────────────────────────────────────────────
class AcademicCalendarBottomSheet extends StatelessWidget {
  const AcademicCalendarBottomSheet({
    super.key,
    required this.events,
    required this.scrollController,
  });

  final List<AcademicCalendarModel> events;
  final ScrollController scrollController;

  static void show(BuildContext context, List<AcademicCalendarModel> events) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (_, scrollController) => AcademicCalendarBottomSheet(
          events: events,
          scrollController: scrollController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: ListView.separated(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(
              AppSize.v16,
              AppSize.v8,
              AppSize.v16,
              AppSize.v32,
            ),
            itemCount: events.length,
            separatorBuilder: (_, _) => AppSize.v12.h,
            itemBuilder: (context, index) {
              final item = events[index];
              return CalendarEventCard(
                day: item.day,
                month: item.monthName,
                title: item.title,
                dateRange: item.dateRange,
                accentColor: item.category.accentColor,
                onPressed: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v4,
        AppSize.v16,
        AppSize.v12,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.outline.withValues(alpha: 0.15),
          ),
        ),
      ),
      child: [
        Icon(Icons.event_note, color: context.primaryColor, size: AppSize.v20)
            .paddingAll(AppSize.v8)
            .container(
              color: context.primaryColor.withValues(alpha: 0.1),
              borderRadius: AppSize.v10,
            ),
        [
          AppStrings.academicCalendar.text.semiBold.fontSize(AppSize.v16),
          AppStrings.eventsCountLabel(
            events.length,
          ).text.fontSize(AppSize.v12).color(AppColors.textSecondary),
        ].column(crossAxisAlignment: .start, mainAxisSize: .min),
      ].row(spacing: AppSize.v12),
    );
  }
}

// ── Kategori → accent rengi ───────────────────────────────────────────────────
extension _CategoryColor on AcademicCalendarCategory {
  Color get accentColor => switch (this) {
    AcademicCalendarCategory.sinav => AppColors.error,
    AcademicCalendarCategory.kayit => AppColors.info,
    AcademicCalendarCategory.ders => AppColors.success,
    AcademicCalendarCategory.harc => AppColors.warning,
    AcademicCalendarCategory.tatil => AppColors.secondary,
    AcademicCalendarCategory.mezuniyet => AppColors.primaryDark,
    AcademicCalendarCategory.diger => AppColors.textSecondary,
  };
}
