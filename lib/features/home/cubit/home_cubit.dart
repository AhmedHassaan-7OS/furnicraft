import '../../../../data/models/category_model.dart';
import '../../../../data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/categories_repository.dart';
import '../../../../data/repositories/products_repository.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoriesRepository _categoriesRepository;
  final ProductsRepository _productsRepository;

  HomeCubit({
    required CategoriesRepository categoriesRepository,
    required ProductsRepository productsRepository,
  })  : _categoriesRepository = categoriesRepository,
        _productsRepository = productsRepository,
        super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        _categoriesRepository.fetchAll(),
        _productsRepository.fetchFeatured(),
        _productsRepository.fetchAll(),
      ]);

      final categories = results[0] as List<CategoryModel>;
      final featured = results[1] as List<ProductModel>;
      final all = results[2] as List<ProductModel>;

      // Filter out featured products from the recommended list
      final featuredIds = featured.map((p) => p.id).toSet();
      final recommended = all.where((p) => !featuredIds.contains(p.id)).toList();

      emit(HomeLoaded(
        categories: categories,
        featuredProducts: featured,
        recommendedProducts: recommended,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
