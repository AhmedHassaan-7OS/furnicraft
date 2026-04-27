import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_text_styles.dart';

class ProductExpandableTile extends StatelessWidget {
  final String title;
  final String content;

  const ProductExpandableTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(title, style: AppTextStyles.label),
      iconColor: AppColors.textPrimary,
      collapsedIconColor: AppColors.textSecondary,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(content, style: AppTextStyles.bodySecondary),
        ),
      ],
    );
  }
}
