import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/app_cached_image.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../cubit/cart_cubit.dart';
import '../../cubit/cart_states.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Image
          AppCachedImage(
            url: item.product.image,
            width: 80,
            height: 80,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(width: AppSpacing.md),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: AppTextStyles.bodyMedium
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.product.price.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Quantity controls
          Column(
            children: [
              // Remove
              GestureDetector(
                onTap: () =>
                    context.read<CartCubit>().removeProduct(item.product.id),
                child: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.error, size: 20),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _QtyButton(
                    icon: Icons.remove,
                    onTap: () => context
                        .read<CartCubit>()
                        .decrementQuantity(item.product.id),
                  ),
                  const SizedBox(width: 8),
                  Text('${item.quantity}',
                      style: AppTextStyles.bodyMedium
                          .copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  _QtyButton(
                    icon: Icons.add,
                    onTap: () => context
                        .read<CartCubit>()
                        .incrementQuantity(item.product.id),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.primary),
      ),
    );
  }
}
