import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../widgets/product_rating_row.dart';
import '../widgets/product_stock_badge.dart';
import '../widgets/product_color_selector.dart';
import '../widgets/product_expandable_tile.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/product_cubit.dart';
import '../../cubit/product_states.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is! ProductLoaded || state.product == null) {
            return const SizedBox.shrink();
          }

          final product = state.product!;

          return Container(
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
                Text(product.name, style: AppTextStyles.h2),
                const SizedBox(height: AppSpacing.xs),
                Text('\$${product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.priceXl),
                const SizedBox(height: AppSpacing.xs),
                const ProductRatingRow(rating: 4.5, reviewCount: 8),
                const SizedBox(height: AppSpacing.sm),
                const ProductStockBadge(inStock: true),
                const SizedBox(height: AppSpacing.md),
                const ProductColorSelector(),
                const Divider(color: AppColors.divider, height: AppSpacing.xl),
                ProductExpandableTile(
                  title: 'Product Description',
                  content: product.description ?? 'No description available.',
                ),
                if (product.specs != null)
                  ProductExpandableTile(
                    title: 'Specifications',
                    content: product.specs!.entries
                        .map((e) => '${e.key}: ${e.value}')
                        .join(' | '),
                  ),
                const ProductExpandableTile(
                  title: 'Materials & Care',
                  content:
                      'Frame: Solid Wood. Upholstery: Premium. Care: Spot clean only.',
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          );
        },
      ),
    );
  }
}
