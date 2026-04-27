import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/banner_card.dart';

class HomeBannerSection extends StatelessWidget {
  const HomeBannerSection({super.key});

  static const List<Map<String, String>> _banners = [
    {
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600',
      'title': 'Summer Outdoor Collection',
      'subtitle': 'Up to 20% Off',
      'button': 'Shop Now',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600',
      'title': 'New Arrivals',
      'subtitle': 'Modern & Minimal',
      'button': 'Explore',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: AppSpacing.bannerHeight,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.92,
        autoPlayInterval: const Duration(seconds: 4),
      ),
      items: _banners
          .map(
            (b) => BannerCard(
              imageUrl: b['image']!,
              title: b['title']!,
              subtitle: b['subtitle']!,
              buttonText: b['button']!,
              onShopNow: () {},
            ),
          )
          .toList(),
    );
  }
}
