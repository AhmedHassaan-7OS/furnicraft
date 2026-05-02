import '../../../../data/models/product_model.dart';

abstract class ShopState {
  const ShopState();
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<ProductModel> products;

  const ShopLoaded({required this.products});
}

class ShopError extends ShopState {
  final String message;
  const ShopError(this.message);
}
