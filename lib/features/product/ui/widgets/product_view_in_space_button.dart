import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';

class ProductViewInSpaceButton extends StatelessWidget {
  const ProductViewInSpaceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          backgroundColor: AppColors.primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
        icon: const Icon(Icons.view_in_ar, color: AppColors.primary),
        label: Text(
          'View in your space',
          style: AppTextStyles.buttonDark.copyWith(color: AppColors.primary),
        ),
        onPressed: () {},
      ),
    );
  }
}
