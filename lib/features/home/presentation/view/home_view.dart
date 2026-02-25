import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/ui/widgets/menu_item_card.dart';
import 'package:campus_hub/features/home/presentation/model/menu_item.dart';
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: [
                      CalendarEventCard(
                        day: '12',
                        month: 'Eylül',
                        title: 'Ders Kayıtları Başlıyor',
                        dateRange: '12 Eylül - 20 Eylül',
                        onPressed: () {},
                      ),
                      AppSize.v16.w,
                      CalendarEventCard(
                        day: '25',
                        month: 'Eylül',
                        title: 'Öğrenci Meclisi Seçimleri',
                        onPressed: () {},
                      ),
                      AppSize.v16.w,
                      CalendarEventCard(
                        day: '5',
                        month: 'Ekim',
                        title: 'Kampüs Festivali',
                        dateRange: '5 Ekim - 7 Ekim',

                        onPressed: () {},
                      ),
                    ].row(),
                  ),
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

  ListView _buildQuickMenuList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: MenuItem.quickMenuItems.length,
      itemBuilder: (context, index) {
        MenuItem item = MenuItem.quickMenuItems[index];
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
