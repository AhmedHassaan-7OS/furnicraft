import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/shop_product_card.dart';

class ShopProductsSection extends StatelessWidget {
  const ShopProductsSection({super.key});

  static const List<Map<String, String>> _products = [
    {
      'image':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
      'name': 'Plush Armchair',
      'price': '\$450',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=400',
      'name': 'Oak Coffee Table',
      'price': '\$300',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      'name': 'Elegant Bookshelf',
      'price': '\$600',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=400',
      'name': 'Minimalist Side Table',
      'price': '\$150',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=400',
      'name': 'Cozy Sectional Sofa',
      'price': '\$1200',
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
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, i) => ShopProductCard(
          imageUrl: _products[i]['image']!,
          name: _products[i]['name']!,
          price: _products[i]['price']!,
          isFavourite: false,
          onFavouriteTap: () {},
        ),
        childCount: _products.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.75,
      ),
    );
  }
}
