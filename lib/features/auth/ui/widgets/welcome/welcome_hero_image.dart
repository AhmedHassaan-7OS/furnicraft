import 'package:flutter/material.dart';
import '../../../../../core/util/constants/app_colors.dart';

class WelcomeHeroImage extends StatelessWidget {
  const WelcomeHeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: const BoxDecoration(color: AppColors.cardBackground),
      child: Image.network(
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.chair, size: 80, color: AppColors.primary),
        ),
      ),
    );
  }
}
