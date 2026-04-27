import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/product_view_in_space_button.dart';
import '../widgets/product_add_to_cart_button.dart';

class ProductActionsSection extends StatelessWidget {
  const ProductActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          children: [
            const ProductViewInSpaceButton(),
            const SizedBox(height: AppSpacing.sm),
            const ProductAddToCartButton(),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
