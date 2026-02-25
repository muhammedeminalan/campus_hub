import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/home/presentation/model/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../data/model/student_card_model.dart';
import '../widgets/profil_card.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  // Veri modelini tanımla

  @override
  Widget build(BuildContext context) {
    // Şimdilik mock veri; ileride BLoC / repository'den çekilir
    return Scaffold(
      /* appBar: CostumAppBar(
        title: 'Ana Sayfa',
        titleStyle: context.textTheme.titleMedium?.copyWith(
          fontWeight: .bold,
          color: context.colorScheme.onSecondary,
        ),
      ),*/
      body: SingleChildScrollView(
        child:
            [
              ProfilCard(
                student: StudentCardModel.mock(),
                width: double.infinity,
              ),
              _labeledIconRow(
                AppStrings.quickMenu,
                Icons.dashboard_outlined,
                () {},
                context,
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: MenuItem.quickMenuItems.length,
                  itemBuilder: (context, index) {
                    var item = MenuItem.quickMenuItems[index];
                    return AspectRatio(
                      aspectRatio: 1.3,
                      child: _menuCard(item.label, item.icon, () {}, context),
                    );
                  },
                ),
              ),
            ].column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .start,
              spacing: AppSize.v24,
            ),
      ).safeArea(),
    );
  }

  Widget _labeledIconRow(
    String lable,
    IconData icon,
    void Function()? onPressed,
    BuildContext context,
  ) {
    return [
          lable.text.bold.alignLeft,
          CostumIconButton(
            onPressed: onPressed,
            iconData: icon,
            size: AppSize.v24,
          ),
        ]
        .row(crossAxisAlignment: .center, mainAxisAlignment: .spaceBetween)
        .paddingSymmetric(h: AppSize.v16);
  }

  Widget _menuCard(
    String label,
    IconData icon,
    void Function() onPressed,
    BuildContext context,
  ) {
    return [
          Icon(icon, size: AppSize.v28),
          AppSize.v8.h,
          label.text.alignCenter.labelMedium(context).fontSize(AppSize.v12),
        ]
        .column(crossAxisAlignment: .center, mainAxisAlignment: .center)
        .paddingAll(AppSize.v12)
        .asCard()
        .onTap(onPressed);
  }
}
