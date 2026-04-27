import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/router/app_router.dart';
import '../../cubit/product_cubit.dart';
import '../../cubit/product_states.dart';
import '../widgets/product_image_carousel.dart';

class ProductImagesSection extends StatelessWidget {
  const ProductImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          const ProductImageCarousel(),
          Positioned(
            top: AppSpacing.lg + MediaQuery.of(context).padding.top,
            left: AppSpacing.sm,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: AppColors.textPrimary,
                ),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(AppRoutes.home);
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.lg + MediaQuery.of(context).padding.top,
            right: AppSpacing.sm,
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                final isFav = state is ProductLoaded
                    ? state.isFavourite
                    : false;
                return CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: isFav
                          ? AppColors.favourite
                          : AppColors.textPrimary,
                    ),
                    onPressed: () =>
                        context.read<ProductCubit>().toggleFavourite(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
