class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final String color;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      imageUrl: imageUrl,
      color: color,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded({required this.items});

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get shipping => items.isEmpty ? 0 : 50;

  double get total => subtotal + shipping;
}

class CartEmpty extends CartState {
  const CartEmpty();
}
