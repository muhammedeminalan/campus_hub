import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/ui/widgets/app_error_view.dart';
import 'package:campus_hub/core/ui/widgets/app_list_view.dart';
import 'package:campus_hub/core/ui/widgets/menu_item_card.dart';
import 'package:campus_hub/features/home/domain/academic_calendar_model.dart';
import 'package:campus_hub/features/home/presentation/cubit/home_cubit.dart';
import 'package:campus_hub/features/home/presentation/model/academic_calendar_display_x.dart';
import 'package:campus_hub/features/home/presentation/model/menu_item_model.dart';
import 'package:campus_hub/features/quick_menu/navigation/quick_menu_navigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../../core/constants/app_sizes.dart';
import '../widgets/calendar_event_card.dart';
import '../widgets/labeled_icon_row.dart';
import '../widgets/profil_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>(),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  @override
  void initState() {
    super.initState();
    // IndexedStack tüm sekmeleri baştan mount eder; loadData'yı
    // initState'e taşıyarak yalnızca widget ağacına eklendiğinde
    // veri çekimi başlatılır.
    context.read<HomeCubit>().loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.home),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => switch (state) {
          HomeInitial() ||
          HomeLoading() => const CircularProgressIndicator().center,
          HomeError(:final message) => AppErrorView(
            message: message,
            onRetry: () => context.read<HomeCubit>().loadHomeData(),
          ),
          HomeLoaded() => _buildContent(context, state),
        },
      ),
    ).safeArea(top: false);
  }

  Widget _buildContent(BuildContext context, HomeLoaded state) {
    return SingleChildScrollView(
      dragStartBehavior: DragStartBehavior.down,
      child:
          [
                ProfilCard(student: state.studentCard, width: double.infinity),
                LabeledIconRow(
                  label: AppStrings.quickMenu,
                  icon: Icons.dashboard_outlined,
                  onPressed: () {},
                ),
                _buildQuickMenuList(context).sized(height: AppSize.v128),
                LabeledIconRow(
                  label: AppStrings.academicCalendar,
                  icon: Icons.event_note,
                  onPressed: () {},
                ),
                _buildCalendarEvents(context, state.calendarEvents),
              ]
              .column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .start,
                spacing: AppSize.v24,
              )
              .paddingOnly(bottom: AppSize.v32),
    );
  }

  Widget _buildCalendarEvents(
    BuildContext context,
    List<AcademicCalendarModel> events,
  ) {
    return AppListView<AcademicCalendarModel>(
      items: events,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, item, index) => CalendarEventCard(
        day: item.day,
        month: item.monthName,
        title: item.title,
        dateRange: item.dateRange,
        onPressed: () {},
      ).sized(width: context.width * 0.9),
    ).sized(height: AppSize.v96);
  }

  Widget _buildQuickMenuList(BuildContext context) {
    return AppListView<MenuItemModel>(
      items: MenuItemModel.quickMenuItems,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, item, index) => AspectRatio(
        aspectRatio: 1.3,
        child: MenuitemCard(
          label: item.label,
          icon: item.icon,
          onPressed: () =>
              context.pushPage(QuickMenuNavigator.pageFor(item.route)),
        ),
      ),
    );
  }
}
