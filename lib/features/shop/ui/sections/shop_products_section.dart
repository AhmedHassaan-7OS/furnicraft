import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/shop_product_card.dart';
import '../../cubit/shop_cubit.dart';
import '../../cubit/shop_states.dart';

class ShopProductsSection extends StatelessWidget {
  const ShopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        if (state is ShopLoaded) {
          final products = state.products;
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final product = products[i];
                return ShopProductCard(
                  product: product,
                );
              },
              childCount: products.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.75,
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
