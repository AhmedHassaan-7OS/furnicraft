import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../data/models/product_model.dart';
import 'wishlist_states.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final SupabaseClient _client;

  WishlistCubit(this._client)
      : super(WishlistLoaded(items: const [], productIds: const {}));

  /// Toggle: لو الـ product موجود يحذفه، لو مش موجود يضيفه
  Future<void> toggle(ProductModel product) async {
    final current = state as WishlistLoaded;
    final alreadyLiked = current.contains(product.id);

    if (alreadyLiked) {
      // ── Remove ─────────────────────────────────────────────
      final newIds = Set<int>.from(current.productIds)..remove(product.id);
      final newItems = current.items.where((p) => p.id != product.id).toList();
      emit(current.copyWith(items: newItems, productIds: newIds));

      // Supabase sync (لو في user مسجل دخول)
      _syncRemove(product.id);
    } else {
      // ── Add ────────────────────────────────────────────────
      final newIds = Set<int>.from(current.productIds)..add(product.id);
      final newItems = [...current.items, product];
      emit(current.copyWith(items: newItems, productIds: newIds));

      // Supabase sync
      _syncAdd(product.id);
    }
  }

  bool isLiked(int productId) {
    final current = state;
    if (current is WishlistLoaded) return current.contains(productId);
    return false;
  }

  // ── Supabase operations (silent — لو فشلوا الـ UI مش بيتأثر) ─────────

  Future<void> _syncAdd(int productId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;
    try {
      await _client.from('wishlists').upsert({
        'user_id': userId,
        'product_id': productId,
      });
    } catch (_) {
      // silent fail — local state already updated
    }
  }

  Future<void> _syncRemove(int productId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;
    try {
      await _client
          .from('wishlists')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);
    } catch (_) {
      // silent fail
    }
  }

  /// استدعيه لما المستخدم يعمل login عشان يجيب الـ wishlist من Supabase
  Future<void> loadFromSupabase() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;
    try {
      final data = await _client
          .from('wishlists')
          .select('product_id, products(*)')
          .eq('user_id', userId);

      final items = (data as List<dynamic>).map((row) {
        final productJson = row['products'] as Map<String, dynamic>;
        return ProductModel.fromJson(productJson);
      }).toList();

      final ids = items.map((p) => p.id).toSet();
      emit(WishlistLoaded(items: items, productIds: ids));
    } catch (_) {
      // keep local state
    }
  }
}
