import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/home_app_bar.dart';
import '../sections/home_banner_section.dart';
import '../sections/home_categories_section.dart';
import '../sections/home_featured_section.dart';
import '../sections/home_recommended_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.surface,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _currentNavIndex = index);
          if (index == 1) context.go(AppRoutes.category, extra: 'Living Room');
          if (index == 2) context.go(AppRoutes.cart);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
