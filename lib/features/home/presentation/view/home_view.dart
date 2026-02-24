import 'package:campus_hub/features/home/data/model/student_card_model.dart';
import 'package:campus_hub/features/home/presentation/widgets/profil_card.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Şimdilik mock veri; ileride BLoC / repository'den çekilir
    return SingleChildScrollView(
      child: [ProfilCard(student: StudentCardModel.mock())].column(),
    ).safeArea();
  }
}
