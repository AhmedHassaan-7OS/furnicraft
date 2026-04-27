import 'package:flutter/material.dart';
import '../widgets/welcome/welcome_hero_image.dart';
import '../widgets/welcome/welcome_title_text.dart';
import '../widgets/welcome/welcome_subtitle_text.dart';
import '../widgets/welcome/welcome_explore_button.dart';
import '../widgets/welcome/welcome_signin_link.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_text_styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const WelcomeHeroImage(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  Text('FurniCraft', style: AppTextStyles.logo),
                  const SizedBox(height: AppSpacing.md),
                  const WelcomeTitleText(),
                  const SizedBox(height: AppSpacing.sm),
                  const WelcomeSubtitleText(),
                  const SizedBox(height: AppSpacing.xl),
                  const WelcomeExploreButton(),
                  const SizedBox(height: AppSpacing.md),
                  const WelcomeSignInLink(),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
