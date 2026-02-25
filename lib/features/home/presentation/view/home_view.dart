import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/ui/widgets/menu_item_card.dart';
import 'package:campus_hub/features/home/presentation/model/academic_calendar_model.dart';
import 'package:campus_hub/features/home/presentation/model/menu_item_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../data/model/student_card_model.dart';
import '../widgets/calendar_event_card.dart';
import '../widgets/labeled_icon_row.dart';
import '../widgets/profil_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        child:
            [
                  ProfilCard(
                    student: StudentCardModel.mock(),
                    width: double.infinity,
                  ),
                  LabeledIconRow(
                    lable: AppStrings.quickMenu,
                    icon: Icons.dashboard_outlined,
                    onPressed: () {},
                  ),
                  _buildQuickMenuList().sized(height: AppSize.v128),
                  LabeledIconRow(
                    lable: AppStrings.academicCalendar,
                    icon: Icons.event_note,
                    onPressed: () {},
                  ),
                  _buildCalendarEvents(context),
                ]
                .column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .start,
                  spacing: AppSize.v24,
                )
                .paddingOnly(bottom: AppSize.v32),
      ).safeArea(),
    );
  }

  Widget _buildCalendarEvents(BuildContext context) {
    return ListView.builder(
      scrollDirection: .horizontal,
      itemCount: AcademicCalendarModel.calendarEvents.length,
      itemBuilder: (context, index) {
        final item = AcademicCalendarModel.calendarEvents[index];
        return CalendarEventCard(
          day: item.day,
          month: item.monthName,
          title: item.title,
          dateRange: item.dateRange,
          onPressed: () {},
        ).sized(width: context.width * 0.9);
      },
    ).sized(height: AppSize.v96);
  }

  ListView _buildQuickMenuList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: MenuItemModel.quickMenuItems.length,
      itemBuilder: (context, index) {
        MenuItemModel item = MenuItemModel.quickMenuItems[index];
        return AspectRatio(
          aspectRatio: 1.3,
          child: MenuitemCard(
            label: item.label,
            icon: item.icon,
            onPressed: () => context.pushPage(item.page),
          ),
        );
      },
    );
  }
}
