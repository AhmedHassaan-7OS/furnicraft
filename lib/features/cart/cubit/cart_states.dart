import '../../../../data/models/product_model.dart';

class CartItem {
  final ProductModel product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({ProductModel? product, int? quantity}) => CartItem(
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
      );

  double get subtotal => product.price * quantity;
}

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded({required this.items});

  CartLoaded copyWith({List<CartItem>? items}) =>
      CartLoaded(items: items ?? this.items);

  double get total => items.fold(0, (sum, item) => sum + item.subtotal);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;
}

class CartCheckoutSuccess extends CartState {
  final String orderReference;
  const CartCheckoutSuccess(this.orderReference);
}

class CartCheckoutLoading extends CartState {}
