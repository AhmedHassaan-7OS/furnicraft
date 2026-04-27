import 'package:flutter/material.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../../../core/util/constants/app_spacing.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('FurniCraft', style: AppTextStyles.logo),
        const SizedBox(height: AppSpacing.xs),
        Text('Welcome Back', style: AppTextStyles.bodySecondary),
      ],
    );
  }
}
