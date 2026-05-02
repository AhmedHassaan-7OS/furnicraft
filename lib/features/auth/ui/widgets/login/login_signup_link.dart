import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/util/constants/app_colors.dart';
import '../../../../../core/util/constants/app_text_styles.dart';

class LoginSignupLink extends StatelessWidget {
  const LoginSignupLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        GestureDetector(
          onTap: () => context.go(AppRoutes.signup),
          child: Text(
            'Sign Up',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
