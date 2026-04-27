import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial());

  final List<CartItem> _items = [
    CartItem(
      id: '1',
      name: 'Velvet Accent Chair',
      imageUrl:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
      color: 'Emerald Green',
      price: 299.00,
    ),
    CartItem(
      id: '2',
      name: 'Oak Coffee Table',
      imageUrl:
          'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=400',
      color: 'Solid Wood',
      price: 450.00,
    ),
  ];

  void loadCart() {
    if (_items.isEmpty) {
      emit(const CartEmpty());
    } else {
      emit(CartLoaded(items: List.from(_items)));
    }
  }

  void increaseQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
      emit(CartLoaded(items: List.from(_items)));
    }
  }

  void decreaseQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity - 1,
      );
      emit(CartLoaded(items: List.from(_items)));
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    if (_items.isEmpty) {
      emit(const CartEmpty());
    } else {
      emit(CartLoaded(items: List.from(_items)));
    }
  }
}
