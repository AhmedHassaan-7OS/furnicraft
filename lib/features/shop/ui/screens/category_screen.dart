import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/shop_app_bar.dart';
import '../sections/shop_products_section.dart';
import '../../cubit/shop_cubit.dart';
import '../../cubit/shop_states.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;

  const CategoryScreen({super.key, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().loadByCategory(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: ShopAppBar(title: widget.categoryName),
      body: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state is ShopError) {
            return Center(child: Text(state.message));
          }
          if (state is ShopLoaded) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.md),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  sliver: const ShopProductsSection(),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.xl)),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
