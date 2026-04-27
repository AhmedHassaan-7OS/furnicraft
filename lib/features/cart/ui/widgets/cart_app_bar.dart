import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../../../core/router/app_router.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRoutes.home);
          }
        },
      ),
      title: Text('Shopping Cart', style: AppTextStyles.h3),
      centerTitle: true,
    );
  }
}
