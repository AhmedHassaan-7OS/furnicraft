import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../../../core/router/app_router.dart';

class WelcomeSignInLink extends StatelessWidget {
  const WelcomeSignInLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRoutes.login),
      child: Text(
        'Already have an account? Sign In',
        style: AppTextStyles.link,
      ),
    );
  }
}
