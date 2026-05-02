import '../../../../data/models/category_model.dart';
import '../../../../data/models/product_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CategoryModel> categories;
  final List<ProductModel> featuredProducts;
  final List<ProductModel> recommendedProducts;

  const HomeLoaded({
    required this.categories,
    required this.featuredProducts,
    required this.recommendedProducts,
  });

  HomeLoaded copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? featuredProducts,
    List<ProductModel>? recommendedProducts,
  }) =>
      HomeLoaded(
        categories: categories ?? this.categories,
        featuredProducts: featuredProducts ?? this.featuredProducts,
        recommendedProducts: recommendedProducts ?? this.recommendedProducts,
      );
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
