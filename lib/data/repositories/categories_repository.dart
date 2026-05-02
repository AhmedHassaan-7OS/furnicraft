import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';

class CategoriesRepository {
  final SupabaseClient _client;

  CategoriesRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  Future<List<CategoryModel>> fetchAll() async {
    final data = await _client
        .from('categories')
        .select()
        .order('id', ascending: true);

    return (data as List<dynamic>)
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
