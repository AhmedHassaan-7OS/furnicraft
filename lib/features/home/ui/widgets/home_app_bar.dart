import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../../search/ui/screens/search_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text('FurniCraft', style: AppTextStyles.headingMedium),
      actions: [
        // Search icon → opens SearchDelegate
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: ProductSearchDelegate(),
            );
          },
          icon: const Icon(Icons.search_rounded, color: AppColors.textPrimary),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
