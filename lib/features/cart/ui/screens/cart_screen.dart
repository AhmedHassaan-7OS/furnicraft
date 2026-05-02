import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../cubit/cart_cubit.dart';
import '../../cubit/cart_states.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_price_summary.dart';
import '../widgets/cart_checkout_button.dart';
import '../widgets/cart_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartCheckoutSuccess) {
          _showSuccessSheet(context, state.orderReference);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CartAppBar(),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartCheckoutLoading) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: AppSpacing.md),
                    Text('Processing your order...'),
                  ],
                ),
              );
            }

            if (state is! CartLoaded || state.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_cart_outlined,
                        size: 80, color: AppColors.textSecondary),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Your cart is empty',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: state.items.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, i) =>
                        CartItemCard(item: state.items[i]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CartPriceSummary(total: state.total),
                      const SizedBox(height: AppSpacing.md),
                      const CartCheckoutButton(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showSuccessSheet(BuildContext context, String orderRef) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _CheckoutSuccessSheet(orderRef: orderRef),
    );
  }
}

class _CheckoutSuccessSheet extends StatelessWidget {
  final String orderRef;

  const _CheckoutSuccessSheet({required this.orderRef});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 48,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          Text('Order Placed!', style: AppTextStyles.headingMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Your order has been confirmed.',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Order Ref: $orderRef',
              style: AppTextStyles.bodyMedium
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'Continue Shopping',
                style: AppTextStyles.bodyLarge
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
