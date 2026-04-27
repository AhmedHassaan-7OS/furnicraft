import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../cubit/product_cubit.dart';
import '../../cubit/product_states.dart';

class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listenWhen: (_, curr) => curr is ProductAddedToCart,
      listener: (context, _) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Added to cart!')));
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.white,
            ),
            label: Text('Add to Cart', style: AppTextStyles.button),
            onPressed: () => context.read<ProductCubit>().addToCart(),
          ),
        );
      },
    );
  }
}
