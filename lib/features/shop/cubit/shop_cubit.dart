import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/products_repository.dart';
import 'shop_states.dart';

class ShopCubit extends Cubit<ShopState> {
  final ProductsRepository _productsRepository;

  ShopCubit({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(ShopInitial());

  Future<void> loadByCategory(String categoryName) async {
    emit(ShopLoading());
    try {
      final products =
          await _productsRepository.fetchByCategory(categoryName);
      emit(ShopLoaded(products: products));
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }
}
