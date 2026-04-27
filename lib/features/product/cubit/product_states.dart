abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoaded extends ProductState {
  final int selectedColorIndex;
  final bool isFavourite;
  final int currentImageIndex;

  const ProductLoaded({
    this.selectedColorIndex = 0,
    this.isFavourite = false,
    this.currentImageIndex = 0,
  });

  ProductLoaded copyWith({
    int? selectedColorIndex,
    bool? isFavourite,
    int? currentImageIndex,
  }) {
    return ProductLoaded(
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      isFavourite: isFavourite ?? this.isFavourite,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
    );
  }
}

class ProductAddedToCart extends ProductState {
  const ProductAddedToCart();
}
