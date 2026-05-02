import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/util/app_cached_image.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../../../data/models/product_model.dart';
import '../../cubit/search_cubit.dart';
import '../../cubit/search_states.dart';

class ProductSearchDelegate extends SearchDelegate<ProductModel?> {
  @override
  String get searchFieldLabel => 'Search furniture...';

  @override
  TextStyle? get searchFieldStyle => AppTextStyles.bodyMedium;

  @override
  List<Widget> buildActions(BuildContext context) => [
        if (query.isNotEmpty)
          IconButton(
            onPressed: () {
              query = '';
              showSuggestions(context);
            },
            icon: const Icon(Icons.clear_rounded),
          ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      );

  @override
  Widget buildResults(BuildContext context) {
    // Trigger search via cubit
    context.read<SearchCubit>().search(query);

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SearchError) {
          return Center(
            child: Text(state.message, style: AppTextStyles.bodyMedium),
          );
        }
        if (state is SearchLoaded) {
          if (state.results.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search_off_rounded,
                      size: 64, color: AppColors.textSecondary),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'No results for "${state.query}"',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: state.results.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) {
              final product = state.results[i];
              return _SearchResultTile(product: product, delegate: this);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'Start typing to search...',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }
    return buildResults(context);
  }
}

class _SearchResultTile extends StatelessWidget {
  final ProductModel product;
  final SearchDelegate delegate;

  const _SearchResultTile({
    required this.product,
    required this.delegate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        delegate.close(context, product);
        context.push(AppRoutes.productDetails, extra: product);
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            AppCachedImage(
              url: product.image,
              width: 64,
              height: 64,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: AppTextStyles.bodyMedium
                          .copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(
                    product.categoryId ?? '',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
