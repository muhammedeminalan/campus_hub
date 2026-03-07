import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Hızlı menü arama çubuğu widget'ı.
///
/// Temizleme butonu [CustomTextField.showClearButton] tarafından yönetilir;
/// yalnızca [CustomTextField] iç state'i rebuild olur.
class QuickMenuSearchBar extends StatelessWidget {
  const QuickMenuSearchBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v12,
        AppSize.v16,
        AppSize.v4,
      ),
      child: Wonzy.textField(
        name: 'quick_menu_search',
        controller: controller,
        hint: AppStrings.searchHint,
        prefixIcon: const Icon(Icons.search_rounded, size: AppSize.v20),
        showClearButton: true,
        textInputAction: TextInputAction.search,
        autovalidateMode: AutovalidateMode.disabled,
      ),
    );
  }
}
