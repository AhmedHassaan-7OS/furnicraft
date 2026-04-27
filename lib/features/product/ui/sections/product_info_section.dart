import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../widgets/product_rating_row.dart';
import '../widgets/product_stock_badge.dart';
import '../widgets/product_color_selector.dart';
import '../widgets/product_expandable_tile.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Elegant Beige Armchair', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.xs),
            Text('\$499.99', style: AppTextStyles.priceXl),
            const SizedBox(height: AppSpacing.xs),
            const ProductRatingRow(rating: 3.5, reviewCount: 125),
            const SizedBox(height: AppSpacing.sm),
            const ProductStockBadge(inStock: true),
            const SizedBox(height: AppSpacing.md),
            const ProductColorSelector(),
            const Divider(color: AppColors.divider, height: AppSpacing.xl),
            const ProductExpandableTile(
              title: 'Product Description',
              content:
                  'Experience unparalleled comfort and style with our Elegant Beige Armchair. Crafted with a solid wood frame and upholstered in premium, soft-touch fabric.',
            ),
            const ProductExpandableTile(
              title: 'Dimensions',
              content:
                  'Width: 80cm | Depth: 85cm | Height: 90cm | Seat Height: 45cm',
            ),
            const ProductExpandableTile(
              title: 'Materials & Care',
              content:
                  'Frame: Solid Oak Wood. Upholstery: Premium Fabric. Care: Spot clean only. Avoid direct sunlight.',
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
