import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/util/constants/app_colors.dart';
import '../../../../../core/util/constants/app_spacing.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../../../core/router/app_router.dart';

class WelcomeExploreButton extends StatelessWidget {
  const WelcomeExploreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            ),
          ),
          onPressed: () => context.go(AppRoutes.home),
          child: Text('Explore FurniCraft', style: AppTextStyles.button),
        ),
      ),
    );
  }
}
