import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../data/models/product_model.dart';
import 'cart_states.dart';
import 'dart:math';

class CartCubit extends Cubit<CartState> {
  final SupabaseClient _client;

  CartCubit(this._client) : super(const CartLoaded(items: []));

  Future<void> loadFromSupabase() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final data = await _client
          .from('cart_items')
          .select('*, products(*)')
          .eq('user_id', userId);

      final List<CartItem> items = (data as List).map((item) {
        return CartItem(
          product: ProductModel.fromJson(item['products']),
          quantity: item['quantity'],
        );
      }).toList();

      emit(CartLoaded(items: items));
    } catch (e) {
      // Handle error
    }
  }

  void addProduct(ProductModel product, {int quantity = 1}) {
    if (state is! CartLoaded) return;
    final current = state as CartLoaded;
    final existingIndex =
        current.items.indexWhere((item) => item.product.id == product.id);

    List<CartItem> newItems;
    if (existingIndex >= 0) {
      newItems = List.from(current.items);
      newItems[existingIndex] = newItems[existingIndex].copyWith(
        quantity: newItems[existingIndex].quantity + quantity,
      );
      _syncUpdate(product.id, newItems[existingIndex].quantity);
    } else {
      newItems = [...current.items, CartItem(product: product, quantity: quantity)];
      _syncAdd(product.id, quantity);
    }

    emit(current.copyWith(items: newItems));
  }

  void removeProduct(int productId) {
    if (state is! CartLoaded) return;
    final current = state as CartLoaded;
    final newItems = current.items.where((i) => i.product.id != productId).toList();
    emit(current.copyWith(items: newItems));
    _syncRemove(productId);
  }

  void incrementQuantity(int productId) {
    _updateQuantity(productId, 1);
  }

  void decrementQuantity(int productId) {
    if (state is! CartLoaded) return;
    final current = state as CartLoaded;
    final item = current.items.firstWhere((i) => i.product.id == productId);
    if (item.quantity <= 1) {
      removeProduct(productId);
    } else {
      _updateQuantity(productId, -1);
    }
  }

  void _updateQuantity(int productId, int delta) {
    if (state is! CartLoaded) return;
    final current = state as CartLoaded;
    int? newQuantity;
    final newItems = current.items.map((item) {
      if (item.product.id == productId) {
        newQuantity = item.quantity + delta;
        return item.copyWith(quantity: newQuantity!);
      }
      return item;
    }).toList();
    emit(current.copyWith(items: newItems));
    if (newQuantity != null) {
      _syncUpdate(productId, newQuantity!);
    }
  }

  // ── Sync Methods ──────────────────────────────────────────────

  Future<void> _syncAdd(int productId, int quantity) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;
    await _client.from('cart_items').upsert({
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
    });
  }

  Future<void> _syncUpdate(int productId, int quantity) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;
    await _client
        .from('cart_items')
        .update({'quantity': quantity})
        .eq('user_id', userId)
        .eq('product_id', productId);
  }

  Future<void> _syncRemove(int productId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;
    await _client
        .from('cart_items')
        .delete()
        .eq('user_id', userId)
        .eq('product_id', productId);
  }

  void clearCart() {
    emit(const CartLoaded(items: []));
    // Clear in Supabase too? Usually done after successful checkout.
  }

  Future<void> checkout() async {
    final current = state;
    if (current is! CartLoaded || current.isEmpty) return;

    emit(CartCheckoutLoading());

    await Future.delayed(const Duration(milliseconds: 1500));
    final ref = 'FC-${Random().nextInt(900000) + 100000}';

    // In a real app, you'd create an order in Supabase here.
    
    emit(CartCheckoutSuccess(ref));

    await Future.delayed(const Duration(milliseconds: 300));
    clearCart();
    // Delete items from cart_items table in Supabase
    final userId = _client.auth.currentUser?.id;
    if (userId != null) {
      await _client.from('cart_items').delete().eq('user_id', userId);
    }
  }
}
