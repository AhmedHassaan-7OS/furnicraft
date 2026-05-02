import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/product_model.dart';
import '../../cubit/wishlist_cubit.dart';
import '../../cubit/wishlist_states.dart';

/// زرار القلب — ضعه في أي Product Card
class WishlistHeartButton extends StatelessWidget {
  final ProductModel product;
  final double size;

  const WishlistHeartButton({
    super.key,
    required this.product,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      // ← بيبني بس لو الـ liked status للـ product ده اتغير، مش كل rebuild
      buildWhen: (prev, curr) {
        if (prev is WishlistLoaded && curr is WishlistLoaded) {
          return prev.contains(product.id) != curr.contains(product.id);
        }
        return true;
      },
      builder: (context, state) {
        final liked = state is WishlistLoaded && state.contains(product.id);
        return GestureDetector(
          onTap: () => context.read<WishlistCubit>().toggle(product),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              key: ValueKey(liked),
              color: liked ? Colors.red : Colors.grey,
              size: size,
            ),
          ),
        );
      },
    );
  }
}
