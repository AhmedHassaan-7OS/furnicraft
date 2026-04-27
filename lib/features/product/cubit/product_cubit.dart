import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_states.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductInitial());

  ProductLoaded get _current =>
      state is ProductLoaded ? state as ProductLoaded : const ProductLoaded();

  void loadProduct() => emit(const ProductLoaded());

  void selectColor(int index) =>
      emit(_current.copyWith(selectedColorIndex: index));

  void toggleFavourite() =>
      emit(_current.copyWith(isFavourite: !_current.isFavourite));

  void changeImage(int index) =>
      emit(_current.copyWith(currentImageIndex: index));

  void addToCart() => emit(const ProductAddedToCart());
}
