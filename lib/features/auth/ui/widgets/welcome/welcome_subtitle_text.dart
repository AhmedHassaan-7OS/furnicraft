import 'package:flutter/material.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../../../core/util/constants/app_spacing.dart';

class WelcomeSubtitleText extends StatelessWidget {
  const WelcomeSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Text(
        'Discover modern furniture and decor for every space.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySecondary,
      ),
    );
  }
}
