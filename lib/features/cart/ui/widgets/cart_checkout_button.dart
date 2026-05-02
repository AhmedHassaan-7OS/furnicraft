import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../cubit/cart_cubit.dart';
import '../../cubit/cart_states.dart';
import 'checkout_bottom_sheet.dart';

class CartCheckoutButton extends StatelessWidget {
  const CartCheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final isLoading = state is CartCheckoutLoading;
        final isEmpty = state is CartLoaded && state.isEmpty;
        final total = state is CartLoaded ? state.total : 0.0;

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: (isLoading || isEmpty)
                ? null
                : () => _openCheckoutSheet(context, total),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: AppColors.primary.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock_outline_rounded,
                          color: Colors.white, size: 18),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Checkout  •  \$${total.toStringAsFixed(2)}',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  void _openCheckoutSheet(BuildContext context, double total) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<CartCubit>(),
        child: CheckoutBottomSheet(total: total),
      ),
    );
  }
}
