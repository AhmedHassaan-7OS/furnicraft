import 'package:flutter/material.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../../../core/util/constants/app_spacing.dart';

class WelcomeTitleText extends StatelessWidget {
  const WelcomeTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Text(
        'Crafting Your Comfort,\nDesigning Your Dream',
        textAlign: TextAlign.center,
        style: AppTextStyles.h1,
      ),
    );
  }
}
