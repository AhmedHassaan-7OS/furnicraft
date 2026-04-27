import 'package:flutter/material.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../../../core/util/constants/app_colors.dart';

class LoginSignUpLink extends StatelessWidget {
  const LoginSignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have an account? ",
        style: AppTextStyles.body,
        children: [
          TextSpan(
            text: 'Sign Up',
            style: AppTextStyles.link.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
