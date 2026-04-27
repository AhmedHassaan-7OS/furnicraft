import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';

class ProductRatingRow extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const ProductRatingRow({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (i) {
          if (i < rating.floor()) {
            return const Icon(Icons.star, color: AppColors.primary, size: 18);
          } else if (i < rating) {
            return const Icon(
              Icons.star_half,
              color: AppColors.primary,
              size: 18,
            );
          } else {
            return Icon(
              Icons.star_border,
              color: AppColors.primary.withOpacity(0.4),
              size: 18,
            );
          }
        }),
        const SizedBox(width: AppSpacing.xs),
        Text('($reviewCount Reviews)', style: AppTextStyles.caption),
      ],
    );
  }
}
