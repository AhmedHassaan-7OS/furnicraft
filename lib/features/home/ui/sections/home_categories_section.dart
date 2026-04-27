import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_states.dart';
import '../widgets/category_tab_item.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  static const List<String> _categories = [
    'Living Room',
    'Bedroom',
    'Office',
    'Outdoor',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        int selected = 0;
        if (state is HomeCategoryChanged) selected = state.selectedIndex;
        if (state is HomeLoaded) selected = state.selectedCategoryIndex;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: List.generate(
              _categories.length,
              (i) => Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: CategoryTabItem(
                  label: _categories[i],
                  isSelected: selected == i,
                  onTap: () => context.read<HomeCubit>().selectCategory(i),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
