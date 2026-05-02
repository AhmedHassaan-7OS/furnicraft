import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/app_cached_image.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../cubit/product_cubit.dart';
import '../../cubit/product_states.dart';

class ProductImageCarousel extends StatelessWidget {
  const ProductImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is! ProductLoaded || state.product == null) {
          return const SizedBox(height: 280);
        }

        final product = state.product!;
        final List<String> images = [
          if (product.image != null) product.image!,
          ...(product.gallery ?? []),
        ];

        // Fallback if no images at all
        if (images.isEmpty) {
          images.add(''); // AppCachedImage will show placeholder
        }

        final currentIndex = state.currentImageIndex;

        return SizedBox(
          height: 280,
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 280,
                  viewportFraction: 1,
                  onPageChanged: (i, _) =>
                      context.read<ProductCubit>().changeImage(i),
                ),
                items: images
                    .map(
                      (url) => AppCachedImage(
                        url: url,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
              ),
              if (images.length > 1)
                Positioned(
                  bottom: AppSpacing.sm,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: currentIndex == i ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentIndex == i
                              ? AppColors.primary
                              : AppColors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusSm,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
