import 'package:flutter/material.dart';
import '../../../../../core/util/constants/app_colors.dart';
import '../../../../../core/util/constants/app_spacing.dart';
import '../../../../../core/util/constants/app_text_styles.dart';

class LoginSocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const LoginSocialButton({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.divider),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          backgroundColor: AppColors.surface,
        ),
        icon: Icon(icon, color: iconColor, size: AppSpacing.iconSm),
        label: Text(label, style: AppTextStyles.buttonDark),
        onPressed: onTap,
      ),
    );
  }
}
