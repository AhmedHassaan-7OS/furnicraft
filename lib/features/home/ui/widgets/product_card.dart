import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../../../core/util/app_cached_image.dart';
import '../../../../core/router/app_router.dart';
import '../../../../data/models/product_model.dart';
import '../../../wishlist/ui/widgets/wishlist_heart_button.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.productDetails, extra: product),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  AppCachedImage(
                    url: product.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppSpacing.radiusMd),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: WishlistHeartButton(product: product),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text('\$${product.price}', style: AppTextStyles.price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
