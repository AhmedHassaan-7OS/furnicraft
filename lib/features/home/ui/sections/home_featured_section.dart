import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/section_title.dart';
import '../widgets/product_card.dart';

class HomeFeaturedSection extends StatelessWidget {
  const HomeFeaturedSection({super.key});

  static const List<Map<String, String>> _products = [
    {
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      'name': 'Modern Sofa',
      'price': '\$1200',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=400',
      'name': 'Elegant Dining Table',
      'price': '\$800',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?w=400',
      'name': 'Stylish Desk Chair',
      'price': '\$350',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
      'name': 'Cozy Armchair',
      'price': '\$450',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: SectionTitle(title: 'Featured Items'),
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
