import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../cubit/product_cubit.dart';
import '../../cubit/product_states.dart';

class ProductImageCarousel extends StatelessWidget {
  const ProductImageCarousel({super.key});

  static const List<String> _images = [
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600',
    'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600',
    'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=600',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final currentIndex = state is ProductLoaded
            ? state.currentImageIndex
            : 0;
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
                items: _images
                    .map(
                      (url) => Image.network(
                        url,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.cardBackground,
                          child: const Icon(
                            Icons.chair,
                            size: 80,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                bottom: AppSpacing.sm,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _images.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: currentIndex == i ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? AppColors.primary
                            : AppColors.white.withOpacity(0.6),
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
