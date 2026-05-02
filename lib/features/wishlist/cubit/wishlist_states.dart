import '../../../../data/models/product_model.dart';

abstract class WishlistState {
  const WishlistState();
}

class WishlistInitial extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductModel> items;
  final Set<int> productIds;

  const WishlistLoaded({
    required this.items,
    required this.productIds,
  });

  WishlistLoaded copyWith({
    List<ProductModel>? items,
    Set<int>? productIds,
  }) =>
      WishlistLoaded(
        items: items ?? this.items,
        productIds: productIds ?? this.productIds,
      );

  bool contains(int productId) => productIds.contains(productId);
}
