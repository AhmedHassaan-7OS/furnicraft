import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/section_title.dart';
import '../widgets/product_card.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_states.dart';

class HomeRecommendedSection extends StatelessWidget {
  const HomeRecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final products = state.recommendedProducts;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: SectionTitle(title: 'Recommended'),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: AppSpacing.productCardHeight,
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    final product = products[i];
                    return ProductCard(
                      product: product,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
