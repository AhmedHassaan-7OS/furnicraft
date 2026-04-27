import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../cubit/product_cubit.dart';
import '../../cubit/product_states.dart';

class ProductColorSelector extends StatelessWidget {
  const ProductColorSelector({super.key});

  static const List<Color> _colors = [
    Color(0xFFD4A853),
    Color(0xFFBDBDBD),
    Color(0xFF1A1A1A),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final selected = state is ProductLoaded ? state.selectedColorIndex : 0;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Color', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: List.generate(
                _colors.length,
                (i) => GestureDetector(
                  onTap: () => context.read<ProductCubit>().selectColor(i),
                  child: Container(
                    margin: const EdgeInsets.only(right: AppSpacing.sm),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _colors[i],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected == i
                            ? AppColors.primary
                            : AppColors.divider,
                        width: selected == i ? 2.5 : 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
