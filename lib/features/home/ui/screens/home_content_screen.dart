import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/home_app_bar.dart';
import '../sections/home_banner_section.dart';
import '../sections/home_categories_section.dart';
import '../sections/home_featured_section.dart';
import '../sections/home_recommended_section.dart';

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const HomeAppBar(),
      body: ListView(
        children: const [
          SizedBox(height: AppSpacing.md),
          HomeBannerSection(),
          SizedBox(height: AppSpacing.lg),
          HomeCategoriesSection(),
          SizedBox(height: AppSpacing.lg),
          HomeFeaturedSection(),
          SizedBox(height: AppSpacing.lg),
          HomeRecommendedSection(),
          SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
