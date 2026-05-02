import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

class ProductsRepository {
  final SupabaseClient _client;

  ProductsRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  Future<List<ProductModel>> fetchAll() async {
    final data = await _client
        .from('products')
        .select()
        .order('id', ascending: true);

    return (data as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductModel>> fetchByCategory(String categoryId) async {
    final data = await _client
        .from('products')
        .select()
        .eq('categoryId', categoryId)
        .order('id', ascending: true);

    return (data as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductModel>> fetchFeatured() async {
    final data = await _client
        .from('products')
        .select()
        .eq('isFeatured', true)
        .order('id', ascending: true);

    return (data as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductModel>> search(String query) async {
    final data = await _client
        .from('products')
        .select()
        .or('name.ilike.%$query%,description.ilike.%$query%')
        .order('id', ascending: true);

    return (data as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ProductModel?> fetchById(int id) async {
    final data = await _client
        .from('products')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;
    return ProductModel.fromJson(data as Map<String, dynamic>);
  }
}
