import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/section_title.dart';
import '../widgets/product_card.dart';

class HomeRecommendedSection extends StatelessWidget {
  const HomeRecommendedSection({super.key});

  static const List<Map<String, String>> _products = [
    {
      'image':
          'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=400',
      'name': 'Oak Coffee Table',
      'price': '\$300',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=400',
      'name': 'Cozy Sectional Sofa',
      'price': '\$1200',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=400',
      'name': 'Minimalist Side Table',
      'price': '\$150',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?w=400',
      'name': 'Arc Floor Lamp',
      'price': '\$250',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.8,
            ),
            itemCount: _products.length,
            itemBuilder: (context, i) => ProductCard(
              imageUrl: _products[i]['image']!,
              name: _products[i]['name']!,
              price: _products[i]['price']!,
              isFavourite: false,
              onFavouriteTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
