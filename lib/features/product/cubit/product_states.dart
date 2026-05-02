import '../../../../data/models/product_model.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoaded extends ProductState {
  final ProductModel? product;
  final int selectedColorIndex;
  final bool isFavourite;
  final int currentImageIndex;

  const ProductLoaded({
    this.product,
    this.selectedColorIndex = 0,
    this.isFavourite = false,
    this.currentImageIndex = 0,
  });

  ProductLoaded copyWith({
    ProductModel? product,
    int? selectedColorIndex,
    bool? isFavourite,
    int? currentImageIndex,
  }) {
    return ProductLoaded(
      product: product ?? this.product,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      isFavourite: isFavourite ?? this.isFavourite,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
    );
  }
}

class ProductAddedToCart extends ProductState {
  const ProductAddedToCart();
}
