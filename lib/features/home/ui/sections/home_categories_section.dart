import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_states.dart';
import '../widgets/category_tab_item.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: List.generate(
                state.categories.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: CategoryTabItem(
                    label: state.categories[i].name,
                    isSelected: false,
                    onTap: () {
                      context.push(
                        AppRoutes.category,
                        extra: state.categories[i].id.toString(),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
